enum FireDepartmentUserRole {

  admin(
    title: 'Admin',
    dbValue: 'admin'
  ),

  user(
    title: 'Benutzer',
    dbValue: 'user'
  );

  final String title;
  final String dbValue;

  const FireDepartmentUserRole({
    required this.title,
    required this.dbValue
  });

  static FireDepartmentUserRole getFromDbValue(String dbValue) {
    return FireDepartmentUserRole.values.firstWhere((FireDepartmentUserRole fireDepartmentUserRole) => fireDepartmentUserRole.dbValue == dbValue);
  }
}