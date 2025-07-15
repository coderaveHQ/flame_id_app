import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/src/features/users/data/models/fire_department_sub_unit_model.dart';
import 'package:flame_id_app/src/features/users/data/datasources/users_remote_datasource.dart';

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource {

  const UsersRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<List<FireDepartmentSubUnitModel>> getFireDepartmentSubUnitsOfCurrentUsersFireDepartment() async {
    final List<Map<String, dynamic>> response = await _client.rpc('get_sub_units_of_users_fire_department');
    return response.map((Map<String, dynamic> json) => FireDepartmentSubUnitModel.fromJson(json)).toList();
  }
}