import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/core/error/failures/auth_failure.dart';
import 'package:flame_id_app/core/error/failures/function_failure.dart';
import 'package:flame_id_app/core/error/failures/general_failure.dart';
import 'package:flame_id_app/core/error/failures/network_failure.dart';
import 'package:flame_id_app/core/error/failures/postgrest_failure.dart';
import 'package:flame_id_app/core/error/failures/realtime_failure.dart';
import 'package:flame_id_app/core/error/failures/storage_failure.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';

Future<Either<Failure, T>> handleAsyncExceptions<T>(Future<T> Function() action) async {
  try {
    final T result = await action();
    return Right(result);
  } on AuthException catch (e) {
    return Left(AuthFailure.fromAuthException(e));
  } on StorageException catch (_) {
    return const Left(StorageFailure());
  } on FunctionException catch (_) {
    return const Left(FunctionFailure());
  } on PostgrestException catch (e) {
    return Left(PostgrestFailure.fromPostgrestException(e));
  } on RealtimeSubscribeException catch (_) {
    return const Left(RealtimeFailure());
  } on SocketException catch (_) {
    return const Left(NetworkFailure.noConnection());
  } on TimeoutException catch (_) {
    return const Left(NetworkFailure.timeout());
  } catch (e, stackTrace) {
    return Left(GeneralFailure.unexpected(stackTrace: stackTrace));
  }
}

Stream<Either<Failure, T>> handleStreamExceptions<T>(Stream<T> Function() action) {
  return action().handleError((e, stackTrace) {
    if (e is AuthException) {
      return Left(AuthFailure.fromAuthException(e));
    } else if (e is StorageException) {
      return const Left(StorageFailure());
    } else if (e is FunctionException) {
      return const Left(FunctionFailure());
    } else if (e is PostgrestException) {
      return Left(PostgrestFailure.fromPostgrestException(e));
    } else if (e is RealtimeSubscribeException) {
      return const Left(RealtimeFailure());
    } else if (e is SocketException) {
      return const Left(NetworkFailure.noConnection());
    } else if (e is TimeoutException) {
      return const Left(NetworkFailure.timeout());
    }
    return Left(GeneralFailure.unexpected(stackTrace: stackTrace));
  }).map((result) => Right(result));
}