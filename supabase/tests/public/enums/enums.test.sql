begin;
create extension if not exists pgtap;

select plan(10);

select has_enum('public', 'fire_department_type', 'enum fire_department_type exists');
select enum_has_labels('public', 'fire_department_type', array[
    'freiwillige_feuerwehr', 
    'berufsfeuerwehr', 
    'pflichtfeuerwehr', 
    'other'
], 'enum fire_department_type has all labels');

select has_enum('public', 'fire_department_user_role', 'enum fire_department_user_role exists');
select enum_has_labels('public', 'fire_department_user_role', array[
    'admin', 
    'representative_admin',
    'user'
], 'enum fire_department_user_role has all labels');

select has_enum('public', 'fire_department_user_rank', 'enum fire_department_user_rank exists');
select enum_has_labels('public', 'fire_department_user_rank', array[
    'feuerwehrmann_anwaerter', 
    'feuerwehrmann',
    'oberfeuerwehrmann',
    'hauptfeuerwehrmann',
    'loeschmeister',
    'oberloeschmeister',
    'hauptloeschmeister',
    'unterbrandmeister',
    'brandmeister_anwaerter',
    'brandmeister',
    'oberbrandmeister',
    'hauptbrandmeister',
    'hauptbrandmeister_mit_zulage',
    'gruppenfuehrer',
    'zugfuehrer',
    'kreisbrandmeister',
    'kreisbrandrat',
    'kreisbranddirektor',
    'brandinspektor',
    'brandoberinspektor',
    'stadtbrandinspektor',
    'brandamtmann',
    'brandamtsrat',
    'brandoberamtsrat',
    'brandreferendar',
    'brandrat',
    'oberbrandrat',
    'branddirektor',
    'leitender_branddirektor',
    'direktor_berufsfeuerwehr',
    'other',
    'none'
], 'enum fire_department_user_rank has all labels');

select has_enum('public', 'fire_department_sub_unit_type', 'enum fire_department_sub_unit_type exists');
select enum_has_labels('public', 'fire_department_sub_unit_type', array[
    'loescheinheit',
    'jugendfeuerwehr',
    'kinderfeuerwehr',
    'iuk_einheit',
    'musik_versorgungszug',
    'technische_einsatzgruppe',
    'gefahrgutgruppe',
    'atemschutzgruppe',
    'drohneneinheit',
    'wasserrettungsgruppe',
    'hoehenrettungsgruppe',
    'sanitaetsgruppe',
    'fuehrungsgruppe',
    'musikzug',
    'versorgungszug',
    'alters_ehrenabteilung',
    'feuerwehrverein'
], 'enum fire_department_sub_unit_type has all labels');

select has_enum('public', 'fire_department_sub_unit_user_role', 'enum fire_department_sub_unit_user_role exists');
select enum_has_labels('public', 'fire_department_sub_unit_user_role', array[
    'admin',
    'representative_admin',
    'user'
], 'enum fire_department_sub_unit_user_role has all labels');

select * from finish();
rollback;
