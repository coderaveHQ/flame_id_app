begin;
create extension if not exists pgtap;

select plan(1);

select is(
  (
    select c.relrowsecurity
    from pg_class c
    join pg_namespace n on n.oid = c.relnamespace
    where n.nspname = 'public' and c.relname = 'fire_departments'
  ),
  true,
  'RLS is enabled on public.fire_departments'
);

select * from finish();
rollback;

/*
-- supabase/tests/rls_profiles.test.sql
begin;
create extension if not exists pgtap;
select plan(5);

-- Anon darf z. B. nicht insert'en
set local role anon;
select set_config('request.jwt.claims', '{"sub":"00000000-0000-0000-0000-000000000000","role":"anon"}', true);
select throws_ok(
  $$ insert into public.profiles (user_id, username) values ('00000000-0000-0000-0000-000000000000','hacker') $$,
  '42501',
  'anon cannot insert into profiles'
);

-- User A darf seine eigenen Rows sehen/schreiben
set local role authenticated;
select set_config('request.jwt.claims', '{"sub":"aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa","role":"authenticated"}', true);
insert into public.profiles (user_id, username) values ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa','alice');
select ok(
  (select count(*) from public.profiles) = 1,
  'owner sees own row'
);

-- User B sieht nur eigene Daten
set local role authenticated;
select set_config('request.jwt.claims', '{"sub":"bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb","role":"authenticated"}', true);
insert into public.profiles (user_id, username) values ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb','bob');

-- B soll nur 'bob' sehen
select results_eq(
  $$ select username from public.profiles order by username $$,
  $$ values ('bob') $$,
  'RLS restricts rows to current user'
);

-- B darf A's Row nicht updaten
select throws_ok(
  $$ update public.profiles set username='alice-hijacked' where user_id='aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa' $$,
  '42501',
  'cannot update other users rows'
);

select * from finish();
rollback;

*/