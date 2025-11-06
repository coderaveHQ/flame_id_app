-- File: supabase/tests/fn_touch_updated_at.behavior.test.sql
begin;
create extension if not exists pgtap;

-- (1) Sentinel korrekt gesetzt
-- (2) UPDATE erhöht updated_at (Trigger greift)
select plan(2);

-- Testtabelle
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

-- (1) Insert mit *altem* Timestamp (übersteuert DEFAULT now())
insert into public._touch_updated_at_e2e (id, name, updated_at)
values ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'first', '2000-01-01 00:00:00+00');

select ok(
  (select updated_at = '2000-01-01 00:00:00+00'::timestamptz
     from public._touch_updated_at_e2e
    where id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  'sentinel set on insert'
);

-- (2) Update -> Trigger setzt updated_at := now()  (muss > Sentinel sein)
update public._touch_updated_at_e2e
   set name = 'second'
 where id   = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb';

select ok(
  (select updated_at > '2000-01-01 00:00:00+00'::timestamptz
     from public._touch_updated_at_e2e
    where id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  'updated_at increased on UPDATE via trigger'
);

select * from finish();
rollback;
