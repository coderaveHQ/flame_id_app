-- File: supabase/tests/2_touch_updated_at.behavior.test.sql
begin;
create extension if not exists pgtap;

-- 3 Checks:
-- 1) Sentinel beim Insert gesetzt
-- 2) Genau 1 Zeile geupdatet
-- 3) updated_at > Sentinel nach UPDATE (Trigger hat zugeschlagen)
select plan(3);

-- Saubere Testtabelle
drop table if exists public._touch_updated_at_e2e cascade;
create table public._touch_updated_at_e2e (
  id uuid primary key,
  name text,
  updated_at timestamptz not null default now()
);

-- Trigger anheften
drop trigger if exists _set_updated_at_e2e on public._touch_updated_at_e2e;
create trigger _set_updated_at_e2e
before update on public._touch_updated_at_e2e
for each row
execute function public.touch_updated_at();

-- Insert mit ALTEM Timestamp (Sentinel)
insert into public._touch_updated_at_e2e (id, name, updated_at)
values ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'first', '2000-01-01 00:00:00+00');

-- (1) Sentinel wirklich gesetzt?
select ok(
  (select updated_at = '2000-01-01 00:00:00+00'::timestamptz
     from public._touch_updated_at_e2e
    where id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  'sentinel set'
);

-- (2) UPDATE ausführen und sicherstellen, dass genau 1 Zeile betroffen war
with upd as (
  update public._touch_updated_at_e2e
     set name = 'second'
   where id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'
  returning 1
)
select is((select count(*) from upd), 1::bigint, 'exactly one row updated');

-- (3) Neuer Timestamp ist > Sentinel (Trigger hat updated_at gesetzt)
select ok(
  (select updated_at > '2000-01-01 00:00:00+00'::timestamptz
     from public._touch_updated_at_e2e
    where id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  'updated_at increased on UPDATE via trigger'
);

select * from finish();
rollback;
