-- File: supabase/tests/trigger_fire_department_sub_units.updated_at.behavior.test.sql
begin;
create extension if not exists pgtap;

-- (1) Sentinel korrekt gesetzt
-- (2) UPDATE bringt updated_at > Sentinel (Trigger greift)
select plan(2);

-- 0) Parent-Department anlegen (FK fire_department_id)
insert into public.fire_departments (id, type, name)
values (
  'cccccccc-cccc-cccc-cccc-cccccccccccc'::uuid,
  'freiwillige_feuerwehr'::public.fire_department_type,
  'FF Parent (SubUnits)'
)
on conflict (id) do nothing;

-- 1) Sub-Unit mit *altem* updated_at einfügen
insert into public.fire_department_sub_units (
  id, fire_department_id, type, name, updated_at
) values (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid,
  'cccccccc-cccc-cccc-cccc-cccccccccccc'::uuid,
  'loescheinheit'::public.fire_department_sub_unit_type,
  'Einheit 1',
  '2000-01-01 00:00:00+00'::timestamptz
);

-- (1) Sentinel gesetzt?
select ok(
  (select updated_at = '2000-01-01 00:00:00+00'::timestamptz
     from public.fire_department_sub_units
    where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  'sentinel set on insert'
);

-- UPDATE auslösen (Trigger setzt updated_at := now())
update public.fire_department_sub_units
   set name = 'Einheit 1 (aktualisiert)'
 where id   = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';

-- (2) Neuer Timestamp > Sentinel?
select ok(
  (select updated_at > '2000-01-01 00:00:00+00'::timestamptz
     from public.fire_department_sub_units
    where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  'updated_at increased on UPDATE via trigger'
);

select * from finish();
rollback;
