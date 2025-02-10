enum UserRole {

  admin(
    dbValue: 'admin',
    title: 'Admin'
  ),
  supervisor(
    dbValue: 'moderator',
    title: 'Moderator'
  ),
  normal(
    dbValue: 'normal',
    title: 'Normal'
  );

  final String dbValue;
  final String title;

  const UserRole({
    required this.dbValue,
    required this.title
  });

  static UserRole fromDbValue(String dbValue) {
    return UserRole.values.firstWhere((UserRole role) => role.dbValue == dbValue);
  }
}