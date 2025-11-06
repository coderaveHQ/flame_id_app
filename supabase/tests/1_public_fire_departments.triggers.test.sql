begin;
create extension if not exists pgtap;

select plan(2);

-- 1) Insert mit *altem* Timestamp (übersteuert DEFAULT now())
insert into public.fire_departments (id, type, name, updated_at)
values (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid,
  'freiwillige_feuerwehr'::public.fire_department_type,
  'Freiwillige Feuerwehr Solingen',
  '2000-01-01 00:00:00+00'::timestamptz
);

-- Check 1: Sentinel wirklich gesetzt?
select ok(
  (select updated_at = '2000-01-01 00:00:00+00'::timestamptz
     from public.fire_departments
    where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  'updated_at preset to sentinel timestamp'
);

-- 2) Update auslösen und *vorher*/*nachher* sauber vergleichen
with before_ts as (
  select updated_at as old_ts
  from public.fire_departments
  where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
),
upd as (
  update public.fire_departments
     set name = 'Freiwillige Feuerwehr Dubai'
   where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
  returning updated_at as new_ts
)
select ok(
  (select new_ts > old_ts from upd, before_ts),
  'updated_at increased on UPDATE via trigger'
);

select * from finish();
rollback;
