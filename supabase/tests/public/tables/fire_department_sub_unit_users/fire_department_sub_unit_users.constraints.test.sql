begin;
create extension if not exists pgtap;

select plan(1);
select ok(true, 'smoke: always passes');

select * from finish();
rollback;
