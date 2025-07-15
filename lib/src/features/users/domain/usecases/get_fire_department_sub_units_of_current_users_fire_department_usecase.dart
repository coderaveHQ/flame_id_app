import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/users/domain/entities/fire_department_sub_unit_entity.dart';
import 'package:flame_id_app/src/features/users/domain/repositories/users_repository.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';

part 'get_fire_department_sub_units_of_current_users_fire_department_usecase.g.dart';

@riverpod
GetFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecase getFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecase(Ref ref) {
  final UsersRepository usersRepository = ref.watch(usersRepositoryProvider);
  return GetFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecase(usersRepository);
}

class GetFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecase {

  final UsersRepository _usersRepository;

  const GetFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecase(this._usersRepository);

  Future<Either<Failure, List<FireDepartmentSubUnitEntity>>> call() async {
    return await _usersRepository.getFireDepartmentSubUnitsOfCurrentUsersFireDepartment();
  }
}
