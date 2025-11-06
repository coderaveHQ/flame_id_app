begin;
create extension if not exists pgtap;

select plan(13);

select has_table('public', 'fire_departments', 'fire_departments table exists');

select has_column('public','fire_departments','id','id column exists');
select has_column('public','fire_departments','created_at','created_at column exists');
select has_column('public','fire_departments','updated_at','updated_at column exists');
select has_column('public','fire_departments','type','type column exists');
select has_column('public','fire_departments','name','name column exists');

select col_type_is('public','fire_departments','id','uuid','id is uuid');
select col_type_is('public','fire_departments','created_at','timestamp with time zone','created_at is timestamp with time zone');
select col_type_is('public','fire_departments','updated_at','timestamp with time zone','updated_at is timestamp with time zone');
select col_type_is('public','fire_departments','type','fire_department_type','type is fire_department_type');
select col_type_is('public','fire_departments','name','text','name is text');

select has_pk('public','fire_departments','fire_departments has a PK');
select col_is_pk('public','fire_departments', 'id', 'fire_departments PK matches');

select * from finish();
rollback;