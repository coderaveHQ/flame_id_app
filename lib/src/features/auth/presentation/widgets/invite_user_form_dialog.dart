import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

import 'package:flame_id_app/src/features/users/domain/entities/fire_department_sub_unit_entity.dart';
import 'package:flame_id_app/src/features/users/presentation/providers/get_fire_department_sub_units_of_current_users_fire_department_provider.dart';
import 'package:flame_id_app/core/utils/toaster.dart';
import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/invite_user_unspecified_sub_unit_details_alert.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_rank.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_sub_unit_user_role.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_user_role.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/send_invitation_usecase.dart';

class InviteUserDialog extends ConsumerStatefulWidget {

  final FDialogStyle style;
  final Animation<double> animation;

  const InviteUserDialog({ 
    super.key,
    required this.style,
    required this.animation
  });

  @override
  ConsumerState<InviteUserDialog> createState() => _InviteUserDialogState();
}

class _InviteUserDialogState extends ConsumerState<InviteUserDialog> with TickerProviderStateMixin {

  bool _isSendInvitationUsecaseLoading = false;
  List<({ String? subUnitId, FireDepartmentSubUnitUserRole? role })> _subUnits = <({ String? subUnitId, FireDepartmentSubUnitUserRole? role })>[];

  late final SendInvitationUsecase _sendInvitationUsecase;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  late final FSelectController<FireDepartmentUserRole> _roleController;
  late final FSelectController<FireDepartmentRank> _rankController;

  void _handleCancel() {
    if (_isSendInvitationUsecaseLoading) return;
    context.pop();
  }

  void _handleAddSubUnit() {
    setState(() => _subUnits.add((subUnitId: null, role: null)));
  }

  void _handleUpdateSubUnitId(int index, FireDepartmentSubUnitEntity? subUnit) {
    ({FireDepartmentSubUnitUserRole? role, String? subUnitId}) newUnit = (
      subUnitId: subUnit?.id,
      role: _subUnits[index].role
    );
    _subUnits[index] = newUnit;
  }

  void _handleUpdateSubUnitRole(int index, FireDepartmentSubUnitUserRole? role) {
    ({FireDepartmentSubUnitUserRole? role, String? subUnitId}) newUnit = (
      subUnitId: _subUnits[index].subUnitId,
      role: role
    );
    _subUnits[index] = newUnit;
  }

  void _handleRemoveSubUnit(int index) {
    setState(() => _subUnits.removeAt(index));
  }

  Future<void> _handleSendInvitation() async {
    if (_isSendInvitationUsecaseLoading) return;

    if (_roleController.value == null) {
      Toaster.showError(
        context: context, 
        title: 'Rolle nicht angegeben', 
        description: 'Eine Rolle muss zugewiesen werden.'
      );
      return;
    }

    if (_rankController.value == null) {
      Toaster.showError(
        context: context, 
        title: 'Dienstgrad nicht angegeben', 
        description: 'Ein Dienstgrad muss zugewiesen werden.'
      );
      return;
    }

    if (_subUnits.any((({FireDepartmentSubUnitUserRole? role, String? subUnitId}) subUnit) => subUnit.subUnitId == null || subUnit.role == null)) {
      final bool removeUnspecifiedSubUnitDetails = await showInviteUserUnspecifiedSubUnitDetailsAlert(context);
      if (!removeUnspecifiedSubUnitDetails) return;
    }

    setState(() { 
      _isSendInvitationUsecaseLoading = true;

      _subUnits = _subUnits
        .where((({FireDepartmentSubUnitUserRole? role, String? subUnitId}) subUnit) => subUnit.subUnitId != null && subUnit.role != null)
        .toList();
    });

    final Either<Failure, Unit> sendInvitationResult = await _sendInvitationUsecase(
      email: _emailController.text.toLowerCase().trim(),
      name: _nameController.text.trim(),
      role: _roleController.value!,
      rank: _rankController.value!,
      subUnits: _subUnits
        .map((({FireDepartmentSubUnitUserRole? role, String? subUnitId}) subUnit) => (subUnitId: subUnit.subUnitId!, role: subUnit.role!))
        .toList()
    );

    sendInvitationResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) {
        if (mounted) {
          const Success.invitationSent().showToast(context);
          context.pop();
        }
      }
    );

    if (mounted) setState(() => _isSendInvitationUsecaseLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _sendInvitationUsecase = ref.read(sendInvitationUsecaseProvider);
    _roleController = FSelectController<FireDepartmentUserRole>(vsync: this);
    _rankController = FSelectController<FireDepartmentRank>(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _nameController.dispose();
    _roleController.dispose();
    _rankController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final FThemeData theme = context.theme;
    final FTypography typography = theme.typography;

    return FDialog(
      style: widget.style.call,
      animation: widget.animation,
      title: const Text('Benutzer einladen'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FTextField.email(
              controller: _emailController,
              label: const Text('E-Mail'),
              hint: 'mail@feuerwehr.de'
            ),
            const SizedBox(height: 10.0),
            FTextField(
              controller: _nameController,
              label: const Text('Vollständiger Name'),
              hint: 'Max Mustermann',
              keyboardType: TextInputType.name
            ),
            const SizedBox(height: 10.0),
            FSelect<FireDepartmentUserRole>.search(
              controller: _roleController,
              label: const Text('Rolle'),
              hint: '',
              emptyBuilder: (BuildContext _, FSelectStyle _, Widget? _) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Keine Ergebnisse')
              ),
              format: (FireDepartmentUserRole role) => role.title,
              filter: (String query) => FireDepartmentUserRole.values.where((FireDepartmentUserRole role) => query.isEmpty || role.title.toLowerCase().contains(query.toLowerCase())),
              contentBuilder: (BuildContext _, ({ String query, Iterable<FireDepartmentUserRole> values }) data) => <FSelectItem<FireDepartmentUserRole>>[ for (final FireDepartmentUserRole role in data.values) FSelectItem<FireDepartmentUserRole>(role.title, role) ]
            ),
            const SizedBox(height: 10.0),
            FSelect<FireDepartmentRank>.search(
              controller: _rankController,
              label: const Text('Dienstgrad'),
              hint: '',
              emptyBuilder: (BuildContext _, FSelectStyle _, Widget? _) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Keine Ergebnisse')
              ),
              format: (FireDepartmentRank rank) => rank.title,
              filter: (String query) => FireDepartmentRank.values.where((FireDepartmentRank rank) => query.isEmpty || rank.title.toLowerCase().contains(query.toLowerCase())),
              contentBuilder: (BuildContext _, ({ String query, Iterable<FireDepartmentRank> values }) data) => <FSelectItem<FireDepartmentRank>>[ for (final FireDepartmentRank rank in data.values) FSelectItem<FireDepartmentRank>(rank.title, rank) ]
            ),
            const SizedBox(height: 10.0),
            Text(
              'Untereinheiten',
              style: typography.sm.copyWith(fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 10.0),
            if (_subUnits.isEmpty) const Text('Keine Untereinheiten ausgewählt.'),
            if (_subUnits.isEmpty) const SizedBox(height: 10.0),
            if (_subUnits.isNotEmpty) ..._subUnits.mapIndexed((int index, ({FireDepartmentSubUnitUserRole? role, String? subUnitId}) subUnit) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: FSelect<FireDepartmentSubUnitEntity>.search(
                        hint: '',
                        emptyBuilder: (BuildContext _, FSelectStyle _, Widget? _) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Keine Ergebnisse')
                        ),
                        format: (FireDepartmentSubUnitEntity subUnit) => subUnit.name,
                        filter: (String query) async {
                          final List<FireDepartmentSubUnitEntity> subUnits = await ref.read(getFireDepartmentSubUnitsOfCurrentUsersFireDepartmentProvider.future);
                          return subUnits.where((FireDepartmentSubUnitEntity subUnit) => !_subUnits.map((({FireDepartmentSubUnitUserRole? role, String? subUnitId}) unit) => unit.subUnitId).contains(subUnit.id) && (query.isEmpty || subUnit.name.toLowerCase().contains(query.toLowerCase())));
                        },
                        onChange: (FireDepartmentSubUnitEntity? subUnit) => _handleUpdateSubUnitId(index, subUnit),
                        contentBuilder: (BuildContext _, ({ String query, Iterable<FireDepartmentSubUnitEntity> values }) data) => <FSelectItem<FireDepartmentSubUnitEntity>>[ for (final FireDepartmentSubUnitEntity subUnit in data.values) FSelectItem<FireDepartmentSubUnitEntity>(subUnit.name, subUnit) ],
                        searchErrorBuilder: (BuildContext _, Object? err, StackTrace _) {
                          final IconThemeData style = theme.selectStyle.iconStyle;
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              FIcons.badgeX, 
                              size: style.size, 
                              color: style.color
                            )
                          );
                        }
                      )
                    ),
                    const SizedBox(width: 8.0),
                    const Icon(FIcons.arrowRight), 
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: FSelect<FireDepartmentSubUnitUserRole>.search(
                        hint: '',
                        emptyBuilder: (BuildContext _, FSelectStyle _, Widget? _) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Keine Ergebnisse')
                        ),
                        onChange: (FireDepartmentSubUnitUserRole? role) => _handleUpdateSubUnitRole(index, role),
                        format: (FireDepartmentSubUnitUserRole role) => role.title,
                        filter: (String query) => FireDepartmentSubUnitUserRole.values.where((FireDepartmentSubUnitUserRole role) => query.isEmpty || role.title.toLowerCase().contains(query.toLowerCase())),
                        contentBuilder: (BuildContext _, ({ String query, Iterable<FireDepartmentSubUnitUserRole> values }) data) => <FSelectItem<FireDepartmentSubUnitUserRole>>[ for (final FireDepartmentSubUnitUserRole role in data.values) FSelectItem<FireDepartmentSubUnitUserRole>(role.title, role) ]
                      )
                    ),
                    const SizedBox(width: 8.0),
                    FTooltip(
                      tipBuilder: (BuildContext _, FTooltipController _) => const Text('Abmelden'),
                      child: FButton.icon(
                        onPress: () => _handleRemoveSubUnit(index),
                        child: Icon(FIcons.trash)
                      )
                    )
                  ]
                )
              );
            }),
            Align(
              alignment: Alignment.centerRight,
              child: FTappable(
                onPress: _handleAddSubUnit,
                child: const Text('Untereinheit hinzufügen')
              )
            )
          ]
        )
      ),
      actions: [
        FButton(
          onPress: _handleSendInvitation, 
          child: _isSendInvitationUsecaseLoading
            ? const FProgress.circularIcon()
            : const Text('Senden')
        ),
        FButton(
          onPress: _handleCancel,
          style: FButtonStyle.secondary(),
          child: const Text('Abbrechen')
        )
      ]
    );
  }
}