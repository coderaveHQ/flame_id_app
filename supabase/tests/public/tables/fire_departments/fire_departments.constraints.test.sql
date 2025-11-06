-- File: supabase/tests/fire_departments.name_length.constraint.test.sql
begin;
create extension if not exists pgtap;

-- 4 Checks:
-- 1) Constraint existiert
-- 2) Valider Name (6 Zeichen) ist erlaubt
-- 3) Zu kurz (5 Zeichen) wird abgelehnt (23514)
-- 4) Zu lang (129 Zeichen) wird abgelehnt (23514)
select plan(4);

-- (1) Strukturcheck: Constraint existiert auf der richtigen Tabelle
select ok(
  exists (
    select 1
    from pg_constraint c
    join pg_class t  on t.oid  = c.conrelid
    join pg_namespace n on n.oid = t.relnamespace
    where c.contype  = 'c'                              -- check constraint
      and c.conname  = 'chk_fire_departments_name_length'
      and n.nspname  = 'public'
      and t.relname  = 'fire_departments'
  ),
  'chk_fire_departments_name_length exists on public.fire_departments'
);

-- (2) Erfolg: genau 6 Zeichen
insert into public.fire_departments (id, type, name)
values (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid,
  'freiwillige_feuerwehr'::public.fire_department_type,
  repeat('x', 6)
);
select ok(
  exists(
    select 1 from public.fire_departments
     where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
  ),
  'insert with 6 chars succeeded'
);

-- (3) Fehler: zu kurz (5 Zeichen) -> SQLSTATE 23514 (check_violation)
select throws_ok(
  $q$
    insert into public.fire_departments (type, name)
    values ('freiwillige_feuerwehr', repeat('x', 5))
  $q$,
  '23514'
);

-- (4) Fehler: zu lang (129 Zeichen)
select throws_ok(
  $q$
    insert into public.fire_departments (type, name)
    values ('freiwillige_feuerwehr', repeat('x', 129))
  $q$,
  '23514'
);

select * from finish();
rollback;
