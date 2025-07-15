enum FireDepartmentType {

  freiwilligeFeuerwehr(
    title: 'Freiwillige Feuerwehr',
    dbValue: 'freiwillige_feuerwehr'
  ),

  berufsfeuerwehr(
    title: 'Berufsfeuerwehr',
    dbValue: 'berufsfeuerwehr'
  ),

  pflichtfeuerwehr(
    title: 'Pflichtfeuerwehr',
    dbValue: 'pflichtfeuerwehr'
  ),

  other(
    title: 'Andere',
    dbValue: 'other'
  );

  final String title;
  final String dbValue;

  const FireDepartmentType({
    required this.title,
    required this.dbValue
  });

  static FireDepartmentType getFromDbValue(String dbValue) {
    return FireDepartmentType.values.firstWhere((FireDepartmentType fireDepartmentType) => fireDepartmentType.dbValue == dbValue);
  }
}