begin;
create extension if not exists pgtap;

-- (1) Sentinel korrekt gesetzt
-- (2) UPDATE bringt updated_at > Sentinel (Trigger greift)
select plan(2);

-- 0) Parent-Department + Sub-Unit für die FKs anlegen (idempotent)
insert into public.fire_departments (id, type, name)
values (
  'cccccccc-cccc-cccc-cccc-cccccccccccc'::uuid,
  'freiwillige_feuerwehr'::public.fire_department_type,
  'FF Parent (SubUnit Users)'
)
on conflict (id) do nothing;

insert into public.fire_department_sub_units (id, fire_department_id, type, name)
values (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid,
  'cccccccc-cccc-cccc-cccc-cccccccccccc'::uuid,
  'loescheinheit'::public.fire_department_sub_unit_type,
  'Einheit A'
)
on conflict (id) do nothing;

-- 0b) FK zu auth.users temporär entfernen (nur in diesem Test, ROLLBACK am Ende)
alter table public.fire_department_sub_unit_users
  drop constraint if exists fk_fire_department_sub_unit_users_user;

-- 1) Datensatz mit *altem* updated_at einfügen
insert into public.fire_department_sub_unit_users (
  fire_department_sub_unit_id, user_id, role, updated_at
) values (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid,
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'::uuid,  -- Dummy-User
  'user'::public.fire_department_sub_unit_user_role,
  '2000-01-01 00:00:00+00'::timestamptz
);

-- (1) Sentinel gesetzt?
select ok(
  (select updated_at = '2000-01-01 00:00:00+00'::timestamptz
     from public.fire_department_sub_unit_users
    where fire_department_sub_unit_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
      and user_id                     = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  'sentinel set on insert'
);

-- UPDATE auslösen (Trigger setzt updated_at := now())
update public.fire_department_sub_unit_users
   set role = 'admin'::public.fire_department_sub_unit_user_role
 where fire_department_sub_unit_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
   and user_id                     = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb';

-- (2) Neuer Timestamp > Sentinel?
select ok(
  (select updated_at > '2000-01-01 00:00:00+00'::timestamptz
     from public.fire_department_sub_unit_users
    where fire_department_sub_unit_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
      and user_id                     = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  'updated_at increased on UPDATE via trigger'
);

select * from finish();
rollback;
