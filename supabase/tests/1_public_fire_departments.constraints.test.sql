begin;
create extension if not exists pgtap;

select plan(1);

-- Immer grün
select ok(true, 'smoke test always passes');

select * from finish();
rollback;

/*
-- supabase/tests/constraints_profiles.test.sql
begin;
create extension if not exists pgtap;
select plan(2);

-- UNIQUE(username) verhindert Duplikate
insert into public.profiles (user_id, username) values
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'dup');

select throws_ok(
  $$ insert into public.profiles (user_id, username) values ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'dup') $$,
  '23505',
  'duplicate username rejected'
);

-- Beispiel: CHECK(age > 0) wirft Fehler
-- (nur falls du so eine Spalte hast)
select throws_ok(
  $$ insert into public.some_table (age) values (-1) $$,
  '23514',
  'check constraint blocks invalid age'
);

select * from finish();
rollback;

*/