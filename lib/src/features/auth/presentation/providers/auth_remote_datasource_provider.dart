import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource.dart';

part 'auth_remote_datasource_provider.g.dart';

@riverpod
AuthRemoteDatasource authRemoteDatasource(Ref ref) {
  return AuthRemoteDatasourceImpl(Supabase.instance.client);
}