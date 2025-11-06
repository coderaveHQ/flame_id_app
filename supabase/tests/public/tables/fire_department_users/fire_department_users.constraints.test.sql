-- File: supabase/tests/fire_department_users.name_length.constraint.test.sql
begin;
create extension if not exists pgtap;

-- 4 Checks:
-- 1) Constraint existiert
-- 2) Valider Name (2 Zeichen) ist erlaubt
-- 3) Zu kurz (1 Zeichen) wird abgelehnt (23514)
-- 4) Zu lang (129 Zeichen) wird abgelehnt (23514)
select plan(4);

-- (1) Strukturcheck: Constraint existiert auf der richtigen Tabelle
select ok(
  exists (
    select 1
    from pg_constraint c
    join pg_class t  on t.oid  = c.conrelid
    join pg_namespace n on n.oid = t.relnamespace
    where c.contype = 'c'                               -- check constraint
      and c.conname = 'chk_fire_department_users_name_length'
      and n.nspname = 'public'
      and t.relname = 'fire_department_users'
  ),
  'chk_fire_department_users_name_length exists on public.fire_department_users'
);

-- TEST-VORBEREITUNG:
-- Für fire_department_id brauchen wir einen Parent, für user_id existiert ein FK auf auth.users.
-- Wir legen ein Department an und droppen den auth.users-FK *nur innerhalb dieser Transaktion*,
-- damit wir einen Dummy-User verwenden können (am Ende wird alles gerollbackt).

-- Parent-Department
insert into public.fire_departments (id, type, name)
values (
  'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee'::uuid,
  'freiwillige_feuerwehr'::public.fire_department_type,
  'FF Parent Dept'
)
on conflict (id) do nothing;

-- FK zu auth.users temporär entfernen (Name entspricht deiner DDL)
alter table public.fire_department_users
  drop constraint if exists fk_fire_department_users_user;

-- (2) Erfolg: genau 2 Zeichen
insert into public.fire_department_users (
  fire_department_id, user_id, role, rank, name
) values (
  'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee'::uuid,
  '11111111-1111-1111-1111-111111111111'::uuid,  -- Dummy-User
  'user'::public.fire_department_user_role,
  'feuerwehrmann'::public.fire_department_user_rank,
  repeat('x', 2)
);
select ok(
  exists(
    select 1 from public.fire_department_users
     where fire_department_id = 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee'
       and user_id            = '11111111-1111-1111-1111-111111111111'
  ),
  'insert with 2 chars succeeded'
);

-- (3) Fehler: zu kurz (1 Zeichen) -> SQLSTATE 23514 (check_violation)
select throws_ok(
  $q$
    insert into public.fire_department_users (
      fire_department_id, user_id, role, rank, name
    ) values (
      'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
      '22222222-2222-2222-2222-222222222222',
      'user', 'feuerwehrmann', repeat('x', 1)
    )
  $q$,
  '23514'
);

-- (4) Fehler: zu lang (129 Zeichen)
select throws_ok(
  $q$
    insert into public.fire_department_users (
      fire_department_id, user_id, role, rank, name
    ) values (
      'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
      '33333333-3333-3333-3333-333333333333',
      'user', 'feuerwehrmann', repeat('x', 129)
    )
  $q$,
  '23514'
);

select * from finish();
rollback;
