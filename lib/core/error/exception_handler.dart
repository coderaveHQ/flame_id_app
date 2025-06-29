import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/core/error/failures/supabase/supabase_auth_failure.dart';
import 'package:flame_id_app/core/error/failures/supabase/supabase_function_failure.dart';
import 'package:flame_id_app/core/error/failures/supabase/supabase_network_failure.dart';
import 'package:flame_id_app/core/error/failures/supabase/supabase_postgrest_failure.dart';
import 'package:flame_id_app/core/error/failures/supabase/supabase_realtime_failure.dart';
import 'package:flame_id_app/core/error/failures/supabase/supabase_storage_failure.dart';
import 'package:flame_id_app/core/error/failures/general_failure.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';

Future<Either<Failure, T>> handleAsyncExceptions<T>(Future<T> Function() action) async {
  try {
    final T result = await action();
    return Right(result);
  } on AuthException catch (e) {
    return Left(SupabaseAuthFailure.fromAuthException(e));
  } on StorageException catch (_) {
    return const Left(SupabaseStorageFailure());
  } on FunctionException catch (_) {
    return const Left(SupabaseFunctionFailure());
  } on PostgrestException catch (e) {
    return Left(SupabasePostgrestFailure.fromPostgrestException(e));
  } on RealtimeSubscribeException catch (_) {
    return const Left(SupabaseRealtimeFailure());
  } on SocketException catch (_) {
    return const Left(SupabaseNetworkFailure.noConnection());
  } on TimeoutException catch (_) {
    return const Left(SupabaseNetworkFailure.timeout());
  } catch (e, stackTrace) {
    return Left(GeneralFailure.unexpected(stackTrace: stackTrace));
  }
}

Stream<Either<Failure, T>> handleStreamExceptions<T>(Stream<T> Function() action) {
  return action().handleError((e, stackTrace) {
    if (e is AuthException) {
      return Left(SupabaseAuthFailure.fromAuthException(e));
    } else if (e is StorageException) {
      return const Left(SupabaseStorageFailure());
    } else if (e is FunctionException) {
      return const Left(SupabaseFunctionFailure());
    } else if (e is PostgrestException) {
      return Left(SupabasePostgrestFailure.fromPostgrestException(e));
    } else if (e is RealtimeSubscribeException) {
      return const Left(SupabaseRealtimeFailure());
    } else if (e is SocketException) {
      return const Left(SupabaseNetworkFailure.noConnection());
    } else if (e is TimeoutException) {
      return const Left(SupabaseNetworkFailure.timeout());
    }
    return Left(GeneralFailure.unexpected(stackTrace: stackTrace));
  }).map((result) => Right(result));
}