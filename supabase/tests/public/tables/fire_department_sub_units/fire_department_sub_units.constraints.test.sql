-- File: public/tables/fire_department_sub_units/fire_department_sub_units.name_length.constraint.test.sql
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
    where c.contype = 'c'  -- check constraint
      and c.conname = 'chk_fire_department_sub_units_name_length'
      and n.nspname = 'public'
      and t.relname = 'fire_department_sub_units'
  ),
  'chk_fire_department_sub_units_name_length exists on public.fire_department_sub_units'
);

-- TEST-VORBEREITUNG:
-- Parent-Department für FK anlegen (idempotent)
insert into public.fire_departments (id, type, name)
values (
  'dddddddd-dddd-dddd-dddd-dddddddddddd'::uuid,
  'freiwillige_feuerwehr'::public.fire_department_type,
  'FF Parent Dept'
)
on conflict (id) do nothing;

-- (2) Erfolg: genau 2 Zeichen
insert into public.fire_department_sub_units (id, fire_department_id, type, name)
values (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid,
  'dddddddd-dddd-dddd-dddd-dddddddddddd'::uuid,
  'loescheinheit'::public.fire_department_sub_unit_type,
  repeat('x', 2)
);

select ok(
  exists(
    select 1 from public.fire_department_sub_units
     where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
  ),
  'insert with 2 chars succeeded'
);

-- (3) Fehler: zu kurz (1 Zeichen) -> SQLSTATE 23514 (check_violation)
select throws_ok(
  $q$
    insert into public.fire_department_sub_units (fire_department_id, type, name)
    values (
      'dddddddd-dddd-dddd-dddd-dddddddddddd',
      'loescheinheit',
      repeat('x', 1)
    )
  $q$,
  '23514'
);

-- (4) Fehler: zu lang (129 Zeichen)
select throws_ok(
  $q$
    insert into public.fire_department_sub_units (fire_department_id, type, name)
    values (
      'dddddddd-dddd-dddd-dddd-dddddddddddd',
      'loescheinheit',
      repeat('x', 129)
    )
  $q$,
  '23514'
);

select * from finish();
rollback;
