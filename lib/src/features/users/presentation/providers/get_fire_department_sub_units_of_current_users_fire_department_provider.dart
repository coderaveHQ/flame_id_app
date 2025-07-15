import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/users/domain/entities/fire_department_sub_unit_entity.dart';
import 'package:flame_id_app/src/features/users/domain/usecases/get_fire_department_sub_units_of_current_users_fire_department_usecase.dart';

part 'get_fire_department_sub_units_of_current_users_fire_department_provider.g.dart';

@riverpod
Future<List<FireDepartmentSubUnitEntity>> getFireDepartmentSubUnitsOfCurrentUsersFireDepartment(Ref ref) async {
  final GetFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecase getFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecase = ref.read(getFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecaseProvider);
  final Either<Failure, List<FireDepartmentSubUnitEntity>> getFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecaseResult = await getFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecase();
  return getFireDepartmentSubUnitsOfCurrentUsersFireDepartmentUsecaseResult.fold(
    (Failure failure) => throw failure,
    (List<FireDepartmentSubUnitEntity> data) => data
  );
}