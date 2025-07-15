import 'package:flame_id_app/core/utils/enums/fire_department_sub_unit_type.dart';
import 'package:flame_id_app/src/features/users/domain/entities/fire_department_sub_unit_entity.dart';

class FireDepartmentSubUnitModel {

  final String id;
  final String type;
  final String name;

  const FireDepartmentSubUnitModel({
    required this.id,
    required this.type,
    required this.name
  });

  factory FireDepartmentSubUnitModel.fromJson(Map<String, dynamic> json) {
    return FireDepartmentSubUnitModel(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String
    );
  }

  FireDepartmentSubUnitEntity toEntity() {
    return FireDepartmentSubUnitEntity(
      id: id,
      type: FireDepartmentSubUnitType.getFromDbValue(type),
      name: name
    );
  }
}