enum FireDepartmentSubUnitType {

  loescheinheit(
    title: 'Löscheinheit',
    dbValue: 'loescheinheit'
  ),

  jugendfeuerwehr(
    title: 'Jugendfeuerwehr',
    dbValue: 'jugendfeuerwehr'
  ),

  kinderfeuerwehr(
    title: 'Kinderfeuerwehr',
    dbValue: 'kinderfeuerwehr'
  ),

  iukEinheit(
    title: 'IuK-Einheit',
    dbValue: 'iuk_einheit'
  ),

  musikVersorgungszug(
    title: 'Musik-/Versorgungszug',
    dbValue: 'musik_versorgungszug'
  ),

  technischeEinsatzgruppe(
    title: 'Technische Einsatzgruppe',
    dbValue: 'technische_einsatzgruppe'
  ),

  gefahrgutgruppe(
    title: 'Gefahrgutgruppe',
    dbValue: 'gefahrgutgruppe'
  ),

  atemschutzgruppe(
    title: 'Atemschutzgruppe',
    dbValue: 'atemschutzgruppe'
  ),

  drohneneinheit(
    title: 'Drohneneinheit',
    dbValue: 'drohneneinheit'
  ),

  wasserrettungsgruppe(
    title: 'Wasserrettungsgruppe',
    dbValue: 'wasserrettungsgruppe'
  ),

  hoehenrettungsgruppe(
    title: 'Höhenrettungsgruppe',
    dbValue: 'hoehenrettungsgruppe'
  ),

  sanitaetsgruppe(
    title: 'Sanitätsgruppe',
    dbValue: 'sanitaetsgruppe'
  ),

  fuehrungsgruppe(
    title: 'Führungsgruppe',
    dbValue: 'fuehrungsgruppe'
  ),

  musikzug(
    title: 'Musikzug',
    dbValue: 'musikzug'
  ),

  versorgungszug(
    title: 'Versorgungszug',
    dbValue: 'versorgungszug'
  ),

  altersEhrenabteilung(
    title: 'Alters-/Ehrenabteilung',
    dbValue: 'alters_ehrenabteilung'
  ),

  feuerwehrverein(
    title: 'Feuerwehrverein',
    dbValue: 'feuerwehrverein'
  );

  final String title;
  final String dbValue;

  const FireDepartmentSubUnitType({
    required this.title,
    required this.dbValue
  });

  static FireDepartmentSubUnitType getFromDbValue(String dbValue) {
    return FireDepartmentSubUnitType.values.firstWhere((FireDepartmentSubUnitType fireDepartmentSubUnitType) => fireDepartmentSubUnitType.dbValue == dbValue);
  }
}