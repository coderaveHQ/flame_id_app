begin;
create extension if not exists pgtap;

select plan(18);

select has_table('public', 'fire_department_sub_units', 'fire_department_sub_units table exists');

select has_column('public','fire_department_sub_units','id','id column exists');
select has_column('public','fire_department_sub_units','created_at','created_at column exists');
select has_column('public','fire_department_sub_units','updated_at','updated_at column exists');
select has_column('public','fire_department_sub_units','fire_department_id','fire_department_id column exists');
select has_column('public','fire_department_sub_units','type','type column exists');
select has_column('public','fire_department_sub_units','name','name column exists');

select col_type_is('public','fire_department_sub_units','id','uuid','id is uuid');
select col_type_is('public','fire_department_sub_units','created_at','timestamp with time zone','created_at is timestamp with time zone');
select col_type_is('public','fire_department_sub_units','updated_at','timestamp with time zone','updated_at is timestamp with time zone');
select col_type_is('public','fire_department_sub_units','fire_department_id','uuid','fire_department_id is uuid');
select col_type_is('public','fire_department_sub_units','type','fire_department_sub_unit_type','type is fire_department_sub_unit_type');
select col_type_is('public','fire_department_sub_units','name','text','name is text');

select has_pk('public','fire_department_sub_units','fire_department_sub_units has a PK');
select col_is_pk('public','fire_department_sub_units', 'id', 'fire_department_sub_units PK matches');

select has_fk('public','fire_department_sub_units','fire_department_sub_units has a FK');

select col_is_fk('public','fire_department_sub_units','fire_department_id','fire_department_sub_units.fire_department_id is a foreign key');
select fk_ok('public','fire_department_sub_units','fire_department_id','public','fire_departments','id',
             'public.fire_department_sub_units.fire_department_id references public.fire_departments.id');

select * from finish();
rollback;
