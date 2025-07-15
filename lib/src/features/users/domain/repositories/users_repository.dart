import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/users/domain/entities/fire_department_sub_unit_entity.dart';
import 'package:flame_id_app/src/features/users/data/datasources/users_remote_datasource.dart';
import 'package:flame_id_app/src/features/users/data/repositories/users_repository_impl.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';

part 'users_repository.g.dart';

@riverpod
UsersRepository usersRepository(Ref ref) {
  final UsersRemoteDatasource usersRemoteDatasource = ref.watch(usersRemoteDatasourceProvider);
  return UsersRepositoryImpl(usersRemoteDatasource);
}

abstract class UsersRepository {

  Future<Either<Failure, List<FireDepartmentSubUnitEntity>>> getFireDepartmentSubUnitsOfCurrentUsersFireDepartment();
}
