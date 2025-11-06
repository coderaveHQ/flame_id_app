begin;
create extension if not exists pgtap;

select plan(21);

select has_table('public', 'fire_department_users', 'fire_department_users table exists');

select has_column('public','fire_department_users','fire_department_id','fire_department_id column exists');
select has_column('public','fire_department_users','user_id','user_id column exists');
select has_column('public','fire_department_users','created_at','created_at column exists');
select has_column('public','fire_department_users','updated_at','updated_at column exists');
select has_column('public','fire_department_users','role','role column exists');
select has_column('public','fire_department_users','rank','rank column exists');
select has_column('public','fire_department_users','name','name column exists');

select col_type_is('public','fire_department_users','fire_department_id','uuid','fire_department_id is uuid');
select col_type_is('public','fire_department_users','created_at','timestamp with time zone','created_at is timestamp with time zone');
select col_type_is('public','fire_department_users','updated_at','timestamp with time zone','updated_at is timestamp with time zone');
select col_type_is('public','fire_department_users','role','fire_department_user_role','role is fire_department_user_role');
select col_type_is('public','fire_department_users','rank','fire_department_user_rank','rank is fire_department_user_rank');
select col_type_is('public','fire_department_users','name','text','name is text');

select has_pk('public','fire_department_users','fire_department_users has a PK');
select col_is_pk('public','fire_department_users', array['fire_department_id', 'user_id'], 'fire_department_users PK matches');

select has_fk('public','fire_department_users','fire_department_users has a FK');

select col_is_fk('public','fire_department_users','fire_department_id','fire_department_users.fire_department_id is a foreign key');
select fk_ok('public','fire_department_users','fire_department_id','public','fire_departments','id',
             'public.fire_department_users.fire_department_id references public.fire_departments.id');

select col_is_fk('public','fire_department_users','user_id','fire_department_users.user_id is a foreign key');
select fk_ok('public','fire_department_users','user_id','auth','users','id',
             'public.fire_department_users.user_id references auth.users.id');

select * from finish();
rollback;
