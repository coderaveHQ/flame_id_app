begin;
create extension if not exists pgtap;

select plan(3);

select has_function('public','touch_updated_at', '{}'::text[], 'function exists');
select function_returns('public','touch_updated_at', '{}'::text[], 'trigger');
select function_lang_is('public','touch_updated_at', '{}'::text[], 'plpgsql');

select * from finish();
rollback;
