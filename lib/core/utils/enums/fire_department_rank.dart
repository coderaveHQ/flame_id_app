enum FireDepartmentRank {

  feuerwehrmannAnwaerter(
    title: 'Feuerwehrmann-Anwärter',
    dbValue: 'feuerwehrmann_anwaerter'
  ),

  feuerwehrmann(
    title: 'Feuerwehrmann',
    dbValue: 'feuerwehrmann'
  ),

  oberfeuerwehrmann(
    title: 'Oberfeuerwehrmann',
    dbValue: 'oberfeuerwehrmann'
  ),

  hauptfeuerwehrmann(
    title: 'Hauptfeuerwehrmann',
    dbValue: 'hauptfeuerwehrmann'
  ),

  loeschmeister(
    title: 'Löschmeister',
    dbValue: 'loeschmeister'
  ),

  oberloeschmeister(
    title: 'Oberlöschmeister',
    dbValue: 'oberloeschmeister'
  ),

  hauptloeschmeister(
    title: 'Hauptlöschmeister',
    dbValue: 'hauptloeschmeister'
  ),

  unterbrandmeister(
    title: 'Unterbrandmeister',
    dbValue: 'unterbrandmeister'
  ),

  brandmeisterAnwaerter(
    title: 'Brandmeister-Anwärter',
    dbValue: 'brandmeister_anwaerter'
  ),

  brandmeister(
    title: 'Brandmeister',
    dbValue: 'brandmeister'
  ),

  oberbrandmeister(
    title: 'Oberbrandmeister',
    dbValue: 'oberbrandmeister'
  ),

  hauptbrandmeister(
    title: 'Hauptbrandmeister',
    dbValue: 'hauptbrandmeister'
  ),

  hauptbrandmeisterMitZulage(
    title: 'Hauptbrandmeister mit Zulage',
    dbValue: 'hauptbrandmeister_mit_zulage'
  ),

  gruppenfuehrer(
    title: 'Gruppenführer',
    dbValue: 'gruppenfuehrer'
  ),

  zugfuehrer(
    title: 'Zugführer',
    dbValue: 'zugfuehrer'
  ),

  kreisbrandmeister(
    title: 'Kreisbrandmeister',
    dbValue: 'kreisbrandmeister'
  ),

  kreisbrandrat(
    title: 'Kreisbrandrat',
    dbValue: 'kreisbrandrat'
  ),

  kreisbranddirektor(
    title: 'Kreisbranddirektor',
    dbValue: 'kreisbranddirektor'
  ),

  brandinspektor(
    title: 'Brandinspektor',
    dbValue: 'brandinspektor'
  ),

  brandoberinspektor(
    title: 'Brandoberinspektor',
    dbValue: 'brandoberinspektor'
  ),

  stadtbrandinspektor(
    title: 'Stadtbrandinspektor',
    dbValue: 'stadtbrandinspektor'
  ),

  brandamtmann(
    title: 'Brandamtmann',
    dbValue: 'brandamtmann'
  ),

  brandamtsrat(
    title: 'Brandamtsrat',
    dbValue: 'brandamtsrat'
  ),

  brandoberamtsrat(
    title: 'Brandoberamtsrat',
    dbValue: 'brandoberamtsrat'
  ),

  brandreferendar(
    title: 'Brandreferendar',
    dbValue: 'brandreferendar'
  ),

  brandrat(
    title: 'Brandrat',
    dbValue: 'brandrat'
  ),

  oberbrandrat(
    title: 'Oberbrandrat',
    dbValue: 'oberbrandrat'
  ),

  branddirektor(
    title: 'Branddirektor',
    dbValue: 'branddirektor'
  ),

  leitenderBranddirektor(
    title: 'Leitender Branddirektor',
    dbValue: 'leitender_branddirektor'
  ),

  direktorBerufsfeuerwehr(
    title: 'Direktor Berufsfeuerwehr',
    dbValue: 'direktor_berufsfeuerwehr'
  ),

  other(
    title: 'Andere',
    dbValue: 'other'
  ),

  none(
    title: 'Keine',
    dbValue: 'none'
  );

  final String title;
  final String dbValue;

  const FireDepartmentRank({
    required this.title,
    required this.dbValue
  });

  static FireDepartmentRank getFromDbValue(String dbValue) {
    return FireDepartmentRank.values.firstWhere((FireDepartmentRank fireDepartmentRank) => fireDepartmentRank.dbValue == dbValue);
  }
}