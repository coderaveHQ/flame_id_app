begin;
create extension if not exists pgtap;

select plan(1);

select is(
  (
    select c.relrowsecurity
    from pg_class c
    join pg_namespace n on n.oid = c.relnamespace
    where n.nspname = 'public' and c.relname = 'fire_department_sub_units'
  ),
  true,
  'RLS is enabled on public.fire_department_sub_units'
);

select * from finish();
rollback;
