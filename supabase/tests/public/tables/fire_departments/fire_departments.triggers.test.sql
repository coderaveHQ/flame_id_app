-- File: supabase/tests/trigger_fire_departments.updated_at.behavior.test.sql
begin;
create extension if not exists pgtap;

-- (1) Sentinel korrekt gesetzt
-- (2) UPDATE bringt updated_at > Sentinel (Trigger greift)
select plan(2);

-- Testdatensatz mit *altem* updated_at einfügen
insert into public.fire_departments (id, type, name, updated_at)
values (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid,
  'freiwillige_feuerwehr'::public.fire_department_type,
  'FF Teststadt',
  '2000-01-01 00:00:00+00'::timestamptz
);

-- (1) Sentinel gesetzt?
select ok(
  (select updated_at = '2000-01-01 00:00:00+00'::timestamptz
     from public.fire_departments
    where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  'sentinel set on insert'
);

-- UPDATE auslösen (Trigger setzt updated_at := now())
update public.fire_departments
   set name = 'FF Teststadt (aktualisiert)'
 where id   = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';

-- (2) Neuer Timestamp > Sentinel?
select ok(
  (select updated_at > '2000-01-01 00:00:00+00'::timestamptz
     from public.fire_departments
    where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  'updated_at increased on UPDATE via trigger'
);

select * from finish();
rollback;
