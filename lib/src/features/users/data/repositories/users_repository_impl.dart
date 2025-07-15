import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/exception_handler.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/users/data/datasources/users_remote_datasource.dart';
import 'package:flame_id_app/src/features/users/data/models/fire_department_sub_unit_model.dart';
import 'package:flame_id_app/src/features/users/domain/entities/fire_department_sub_unit_entity.dart';
import 'package:flame_id_app/src/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {

  const UsersRepositoryImpl(this._remoteDataSource);

  final UsersRemoteDatasource _remoteDataSource;

  @override
  Future<Either<Failure, List<FireDepartmentSubUnitEntity>>> getFireDepartmentSubUnitsOfCurrentUsersFireDepartment() async {
    return handleAsyncExceptions(() async {
      final List<FireDepartmentSubUnitModel> models = await _remoteDataSource.getFireDepartmentSubUnitsOfCurrentUsersFireDepartment();
      return models.map((FireDepartmentSubUnitModel model) => model.toEntity()).toList();
    });
  }
}
