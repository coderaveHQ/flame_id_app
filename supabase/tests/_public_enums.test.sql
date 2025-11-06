begin;
create extension if not exists pgtap;

select plan(2);

select has_enum('public', 'fire_department_type', 'enum fire_department_type exists');
select enum_has_labels('public', 'fire_department_type', array['freiwillige_feuerwehr','berufsfeuerwehr','pflichtfeuerwehr', 'other'], 'enum fire_department_type has all labels');

select * from finish();
rollback;