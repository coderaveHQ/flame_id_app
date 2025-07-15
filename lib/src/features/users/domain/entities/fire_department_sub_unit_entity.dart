import 'package:equatable/equatable.dart';

import 'package:flame_id_app/core/utils/enums/fire_department_sub_unit_type.dart';

class FireDepartmentSubUnitEntity extends Equatable {

  final String id;
  final FireDepartmentSubUnitType type;
  final String name;

  const FireDepartmentSubUnitEntity({
    required this.id,
    required this.type,
    required this.name
  });

  @override
  List<Object?> get props => [
    id, 
    type, 
    name
  ];
}