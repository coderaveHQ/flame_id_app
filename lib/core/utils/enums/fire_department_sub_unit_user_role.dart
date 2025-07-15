enum FireDepartmentSubUnitUserRole {

  admin(
    title: 'Admin',
    dbValue: 'admin'
  ),

  representativeAdmin(
    title: 'Vertretender Admin',
    dbValue: 'representative_admin'
  ),

  user(
    title: 'Benutzer',
    dbValue: 'user'
  );

  final String title;
  final String dbValue;

  const FireDepartmentSubUnitUserRole({
    required this.title,
    required this.dbValue
  });

  static FireDepartmentSubUnitUserRole getFromDbValue(String dbValue) {
    return FireDepartmentSubUnitUserRole.values.firstWhere((FireDepartmentSubUnitUserRole fireDepartmentSubUnitUserRole) => fireDepartmentSubUnitUserRole.dbValue == dbValue);
  }
}