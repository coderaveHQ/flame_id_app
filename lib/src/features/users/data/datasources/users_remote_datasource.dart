import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/src/features/users/data/models/fire_department_sub_unit_model.dart';
import 'package:flame_id_app/src/features/users/data/datasources/users_remote_datasource_impl.dart';

part 'users_remote_datasource.g.dart';

@riverpod
UsersRemoteDatasource usersRemoteDatasource(Ref ref) {
  return UsersRemoteDatasourceImpl(Supabase.instance.client);
}

abstract class UsersRemoteDatasource {

  Future<List<FireDepartmentSubUnitModel>> getFireDepartmentSubUnitsOfCurrentUsersFireDepartment();
}