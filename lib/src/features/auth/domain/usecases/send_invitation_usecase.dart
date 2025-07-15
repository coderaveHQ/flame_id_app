import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/utils/enums/fire_department_rank.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_sub_unit_user_role.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_user_role.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/error/failures/validation_failure.dart';
import 'package:flame_id_app/core/utils/validator.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'send_invitation_usecase.g.dart';

@riverpod
SendInvitationUsecase sendInvitationUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return SendInvitationUsecase(authRepository);
}

class SendInvitationUsecase {

  final AuthRepository _authRepository;

  const SendInvitationUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String name,
    required FireDepartmentUserRole role,
    required FireDepartmentRank rank,
    required List<({ String subUnitId, FireDepartmentSubUnitUserRole role })> subUnits
  }) async {
    final ValidationFailure? emailValidationFailure = Validator.validateEmail(email);
    if (emailValidationFailure != null) return Left(emailValidationFailure);
    
    final ValidationFailure? nameValidationFailure = Validator.validateName(name);
    if (nameValidationFailure != null) return Left(nameValidationFailure);

    return await _authRepository.sendInvitation(
      email: email,
      name: name,
      role: role,
      rank: rank,
      subUnits: subUnits
    );
  }
}
