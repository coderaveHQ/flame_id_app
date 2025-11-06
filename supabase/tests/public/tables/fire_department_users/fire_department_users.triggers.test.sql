-- File: supabase/tests/trigger_fire_department_users.updated_at.behavior.test.sql
begin;
create extension if not exists pgtap;

-- (1) Sentinel korrekt gesetzt
-- (2) UPDATE bringt updated_at > Sentinel (Trigger greift)
select plan(2);

-- 0) Parent-Department anlegen (für FK fire_department_id)
insert into public.fire_departments (id, type, name)
values (
  'dddddddd-dddd-dddd-dddd-dddddddddddd'::uuid,
  'freiwillige_feuerwehr'::public.fire_department_type,
  'FF Parent'
)
on conflict (id) do nothing;

-- 0b) FK zu auth.users temporär entfernen (nur innerhalb dieses Tests)
--     (Name entspricht deiner Migration.)
alter table public.fire_department_users
  drop constraint if exists fk_fire_department_users_user;

-- 1) Datensatz mit *altem* updated_at einfügen
insert into public.fire_department_users (
  fire_department_id, user_id, role, rank, name, updated_at
) values (
  'dddddddd-dddd-dddd-dddd-dddddddddddd'::uuid,
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'::uuid,  -- Dummy-User
  'user'::public.fire_department_user_role,
  'feuerwehrmann'::public.fire_department_user_rank,
  'Max Muster',
  '2000-01-01 00:00:00+00'::timestamptz
);

-- (1) Sentinel gesetzt?
select ok(
  (select updated_at = '2000-01-01 00:00:00+00'::timestamptz
     from public.fire_department_users
    where fire_department_id = 'dddddddd-dddd-dddd-dddd-dddddddddddd'
      and user_id            = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  'sentinel set on insert'
);

-- UPDATE auslösen (Trigger setzt updated_at := now())
update public.fire_department_users
   set name = 'Max Muster (aktualisiert)'
 where fire_department_id = 'dddddddd-dddd-dddd-dddd-dddddddddddd'
   and user_id            = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb';

-- (2) Neuer Timestamp > Sentinel?
select ok(
  (select updated_at > '2000-01-01 00:00:00+00'::timestamptz
     from public.fire_department_users
    where fire_department_id = 'dddddddd-dddd-dddd-dddd-dddddddddddd'
      and user_id            = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  'updated_at increased on UPDATE via trigger'
);

select * from finish();
rollback;
