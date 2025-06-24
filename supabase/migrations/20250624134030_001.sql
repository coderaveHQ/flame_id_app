create type "public"."fire_department_rank" as enum ('feuerwehrmann_anwaerter', 'feuerwehrmann', 'oberfeuerwehrmann', 'hauptfeuerwehrmann', 'loeschmeister', 'oberloeschmeister', 'hauptloeschmeister', 'unterbrandmeister', 'brandmeister_anwaerter', 'brandmeister', 'oberbrandmeister', 'hauptbrandmeister', 'hauptbrandmeister_mit_zulage', 'gruppenfuehrer', 'zugfuehrer', 'kreisbrandmeister', 'kreisbrandrat', 'kreisbranddirektor', 'brandinspektor', 'brandoberinspektor', 'stadtbrandinspektor', 'brandamtmann', 'brandamtsrat', 'brandoberamtsrat', 'brandreferendar', 'brandrat', 'oberbrandrat', 'branddirektor', 'leitender_branddirektor', 'direktor_berufsfeuerwehr', 'other', 'none');

create type "public"."fire_department_sub_unit_type" as enum ('loescheinheit', 'jugendfeuerwehr', 'kinderfeuerwehr', 'iuk_einheit', 'musik_versorgungszug', 'technische_einsatzgruppe', 'gefahrgutgruppe', 'atemschutzgruppe', 'drohneneinheit', 'wasserrettungsgruppe', 'hoehenrettungsgruppe', 'sanitaetsgruppe', 'fuehrungsgruppe', 'musikzug', 'versorgungszug', 'alters_ehrenabteilung', 'feuerwehrverein');

create type "public"."fire_department_sub_unit_user_role" as enum ('admin', 'representative_admin', 'user');

create type "public"."fire_department_type" as enum ('freiwillige_feuerwehr', 'berufsfeuerwehr', 'pflichtfeuerwehr', 'other');

create type "public"."fire_department_user_role" as enum ('admin', 'user');

create table "public"."fire_department_addresses" (
    "id" uuid not null default gen_random_uuid(),
    "fire_department_id" uuid not null,
    "street" text not null,
    "postal_code" text not null,
    "city" text not null
);


alter table "public"."fire_department_addresses" enable row level security;

create table "public"."fire_department_sub_unit_addresses" (
    "id" uuid not null default gen_random_uuid(),
    "fire_department_sub_unit_id" uuid not null,
    "street" text not null,
    "postal_code" text not null,
    "city" text not null
);


alter table "public"."fire_department_sub_unit_addresses" enable row level security;

create table "public"."fire_department_sub_unit_users" (
    "fire_department_sub_unit_id" uuid not null,
    "user_id" uuid not null,
    "role" fire_department_sub_unit_user_role not null
);


alter table "public"."fire_department_sub_unit_users" enable row level security;

create table "public"."fire_department_sub_units" (
    "id" uuid not null default gen_random_uuid(),
    "fire_department_id" uuid not null,
    "type" fire_department_sub_unit_type not null,
    "name" text not null
);


alter table "public"."fire_department_sub_units" enable row level security;

create table "public"."fire_department_users" (
    "fire_department_id" uuid not null,
    "user_id" uuid not null,
    "role" fire_department_user_role not null,
    "rank" fire_department_rank not null,
    "name" text not null
);


alter table "public"."fire_department_users" enable row level security;

create table "public"."fire_departments" (
    "id" uuid not null default gen_random_uuid(),
    "type" fire_department_type not null,
    "name" text not null
);


alter table "public"."fire_departments" enable row level security;

CREATE UNIQUE INDEX pk_fire_department_addresses ON public.fire_department_addresses USING btree (id);

CREATE UNIQUE INDEX pk_fire_department_sub_unit_addresses ON public.fire_department_sub_unit_addresses USING btree (id);

CREATE UNIQUE INDEX pk_fire_department_sub_unit_users ON public.fire_department_sub_unit_users USING btree (fire_department_sub_unit_id, user_id);

CREATE UNIQUE INDEX pk_fire_department_sub_units ON public.fire_department_sub_units USING btree (id);

CREATE UNIQUE INDEX pk_fire_department_users ON public.fire_department_users USING btree (fire_department_id, user_id);

CREATE UNIQUE INDEX pk_fire_departments ON public.fire_departments USING btree (id);

alter table "public"."fire_department_addresses" add constraint "pk_fire_department_addresses" PRIMARY KEY using index "pk_fire_department_addresses";

alter table "public"."fire_department_sub_unit_addresses" add constraint "pk_fire_department_sub_unit_addresses" PRIMARY KEY using index "pk_fire_department_sub_unit_addresses";

alter table "public"."fire_department_sub_unit_users" add constraint "pk_fire_department_sub_unit_users" PRIMARY KEY using index "pk_fire_department_sub_unit_users";

alter table "public"."fire_department_sub_units" add constraint "pk_fire_department_sub_units" PRIMARY KEY using index "pk_fire_department_sub_units";

alter table "public"."fire_department_users" add constraint "pk_fire_department_users" PRIMARY KEY using index "pk_fire_department_users";

alter table "public"."fire_departments" add constraint "pk_fire_departments" PRIMARY KEY using index "pk_fire_departments";

alter table "public"."fire_department_addresses" add constraint "fk_fire_department_addresses_fire_department" FOREIGN KEY (fire_department_id) REFERENCES fire_departments(id) not valid;

alter table "public"."fire_department_addresses" validate constraint "fk_fire_department_addresses_fire_department";

alter table "public"."fire_department_sub_unit_addresses" add constraint "fk_fire_department_sub_unit_addresses_fire_department_sub_unit" FOREIGN KEY (fire_department_sub_unit_id) REFERENCES fire_department_sub_units(id) not valid;

alter table "public"."fire_department_sub_unit_addresses" validate constraint "fk_fire_department_sub_unit_addresses_fire_department_sub_unit";

alter table "public"."fire_department_sub_unit_users" add constraint "fk_fire_department_sub_unit_users_fire_department_sub_unit" FOREIGN KEY (fire_department_sub_unit_id) REFERENCES fire_department_sub_units(id) not valid;

alter table "public"."fire_department_sub_unit_users" validate constraint "fk_fire_department_sub_unit_users_fire_department_sub_unit";

alter table "public"."fire_department_sub_unit_users" add constraint "fk_fire_department_sub_unit_users_user" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."fire_department_sub_unit_users" validate constraint "fk_fire_department_sub_unit_users_user";

alter table "public"."fire_department_sub_units" add constraint "fk_fire_department_sub_units_fire_department" FOREIGN KEY (fire_department_id) REFERENCES fire_departments(id) not valid;

alter table "public"."fire_department_sub_units" validate constraint "fk_fire_department_sub_units_fire_department";

alter table "public"."fire_department_users" add constraint "fk_fire_department_users_fire_department" FOREIGN KEY (fire_department_id) REFERENCES fire_departments(id) not valid;

alter table "public"."fire_department_users" validate constraint "fk_fire_department_users_fire_department";

alter table "public"."fire_department_users" add constraint "fk_fire_department_users_user" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."fire_department_users" validate constraint "fk_fire_department_users_user";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.check_fire_department_or_sub_unit_admin(p_user_id uuid, p_fire_department_sub_unit_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
    RETURN (
        public.get_fire_department_user_role(
            p_user_id,
            public.get_fire_department_id_from_sub_unit(p_fire_department_sub_unit_id)
        ) = 'admin'::public.fire_department_user_role
        OR
        public.get_fire_department_sub_unit_user_role(
            p_user_id,
            p_fire_department_sub_unit_id
        ) = ANY (ARRAY[
            'admin'::public.fire_department_sub_unit_user_role,
            'representative_admin'::public.fire_department_sub_unit_user_role
        ])
    );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_fire_department_id_from_sub_unit(p_fire_department_sub_unit_id uuid)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
    RETURN (
        SELECT fire_department_id
        FROM public.fire_department_sub_units
        WHERE id = p_fire_department_sub_unit_id
        LIMIT 1
    );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_fire_department_sub_unit_user_role(p_user_id uuid, p_fire_department_sub_unit_id uuid)
 RETURNS fire_department_sub_unit_user_role
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
    RETURN (
        SELECT role
        FROM public.fire_department_sub_unit_users
        WHERE fire_department_sub_unit_id = p_fire_department_sub_unit_id
        AND user_id = p_user_id
        LIMIT 1
    );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_fire_department_user_role(p_user_id uuid, p_fire_department_id uuid)
 RETURNS fire_department_user_role
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
    RETURN (
        SELECT role
        FROM public.fire_department_users
        WHERE fire_department_id = p_fire_department_id
        AND user_id = p_user_id
        LIMIT 1
    );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
    INSERT INTO public.fire_department_users (
        fire_department_id,
        user_id,
        role,
        rank,
        name
    )
    VALUES (
        (NEW.raw_user_meta_data->>'fire_department_id')::UUID,
        NEW.id,
        (NEW.raw_user_meta_data->>'role')::public.fire_department_user_role,
        (NEW.raw_user_meta_data->>'rank')::public.fire_department_rank,
        (NEW.raw_user_meta_data->>'name')::TEXT
    );
    RETURN NEW;
END;
$function$
;

grant delete on table "public"."fire_department_addresses" to "anon";

grant insert on table "public"."fire_department_addresses" to "anon";

grant references on table "public"."fire_department_addresses" to "anon";

grant select on table "public"."fire_department_addresses" to "anon";

grant trigger on table "public"."fire_department_addresses" to "anon";

grant truncate on table "public"."fire_department_addresses" to "anon";

grant update on table "public"."fire_department_addresses" to "anon";

grant delete on table "public"."fire_department_addresses" to "authenticated";

grant insert on table "public"."fire_department_addresses" to "authenticated";

grant references on table "public"."fire_department_addresses" to "authenticated";

grant select on table "public"."fire_department_addresses" to "authenticated";

grant trigger on table "public"."fire_department_addresses" to "authenticated";

grant truncate on table "public"."fire_department_addresses" to "authenticated";

grant update on table "public"."fire_department_addresses" to "authenticated";

grant delete on table "public"."fire_department_addresses" to "service_role";

grant insert on table "public"."fire_department_addresses" to "service_role";

grant references on table "public"."fire_department_addresses" to "service_role";

grant select on table "public"."fire_department_addresses" to "service_role";

grant trigger on table "public"."fire_department_addresses" to "service_role";

grant truncate on table "public"."fire_department_addresses" to "service_role";

grant update on table "public"."fire_department_addresses" to "service_role";

grant delete on table "public"."fire_department_sub_unit_addresses" to "anon";

grant insert on table "public"."fire_department_sub_unit_addresses" to "anon";

grant references on table "public"."fire_department_sub_unit_addresses" to "anon";

grant select on table "public"."fire_department_sub_unit_addresses" to "anon";

grant trigger on table "public"."fire_department_sub_unit_addresses" to "anon";

grant truncate on table "public"."fire_department_sub_unit_addresses" to "anon";

grant update on table "public"."fire_department_sub_unit_addresses" to "anon";

grant delete on table "public"."fire_department_sub_unit_addresses" to "authenticated";

grant insert on table "public"."fire_department_sub_unit_addresses" to "authenticated";

grant references on table "public"."fire_department_sub_unit_addresses" to "authenticated";

grant select on table "public"."fire_department_sub_unit_addresses" to "authenticated";

grant trigger on table "public"."fire_department_sub_unit_addresses" to "authenticated";

grant truncate on table "public"."fire_department_sub_unit_addresses" to "authenticated";

grant update on table "public"."fire_department_sub_unit_addresses" to "authenticated";

grant delete on table "public"."fire_department_sub_unit_addresses" to "service_role";

grant insert on table "public"."fire_department_sub_unit_addresses" to "service_role";

grant references on table "public"."fire_department_sub_unit_addresses" to "service_role";

grant select on table "public"."fire_department_sub_unit_addresses" to "service_role";

grant trigger on table "public"."fire_department_sub_unit_addresses" to "service_role";

grant truncate on table "public"."fire_department_sub_unit_addresses" to "service_role";

grant update on table "public"."fire_department_sub_unit_addresses" to "service_role";

grant delete on table "public"."fire_department_sub_unit_users" to "anon";

grant insert on table "public"."fire_department_sub_unit_users" to "anon";

grant references on table "public"."fire_department_sub_unit_users" to "anon";

grant select on table "public"."fire_department_sub_unit_users" to "anon";

grant trigger on table "public"."fire_department_sub_unit_users" to "anon";

grant truncate on table "public"."fire_department_sub_unit_users" to "anon";

grant update on table "public"."fire_department_sub_unit_users" to "anon";

grant delete on table "public"."fire_department_sub_unit_users" to "authenticated";

grant insert on table "public"."fire_department_sub_unit_users" to "authenticated";

grant references on table "public"."fire_department_sub_unit_users" to "authenticated";

grant select on table "public"."fire_department_sub_unit_users" to "authenticated";

grant trigger on table "public"."fire_department_sub_unit_users" to "authenticated";

grant truncate on table "public"."fire_department_sub_unit_users" to "authenticated";

grant update on table "public"."fire_department_sub_unit_users" to "authenticated";

grant delete on table "public"."fire_department_sub_unit_users" to "service_role";

grant insert on table "public"."fire_department_sub_unit_users" to "service_role";

grant references on table "public"."fire_department_sub_unit_users" to "service_role";

grant select on table "public"."fire_department_sub_unit_users" to "service_role";

grant trigger on table "public"."fire_department_sub_unit_users" to "service_role";

grant truncate on table "public"."fire_department_sub_unit_users" to "service_role";

grant update on table "public"."fire_department_sub_unit_users" to "service_role";

grant delete on table "public"."fire_department_sub_units" to "anon";

grant insert on table "public"."fire_department_sub_units" to "anon";

grant references on table "public"."fire_department_sub_units" to "anon";

grant select on table "public"."fire_department_sub_units" to "anon";

grant trigger on table "public"."fire_department_sub_units" to "anon";

grant truncate on table "public"."fire_department_sub_units" to "anon";

grant update on table "public"."fire_department_sub_units" to "anon";

grant delete on table "public"."fire_department_sub_units" to "authenticated";

grant insert on table "public"."fire_department_sub_units" to "authenticated";

grant references on table "public"."fire_department_sub_units" to "authenticated";

grant select on table "public"."fire_department_sub_units" to "authenticated";

grant trigger on table "public"."fire_department_sub_units" to "authenticated";

grant truncate on table "public"."fire_department_sub_units" to "authenticated";

grant update on table "public"."fire_department_sub_units" to "authenticated";

grant delete on table "public"."fire_department_sub_units" to "service_role";

grant insert on table "public"."fire_department_sub_units" to "service_role";

grant references on table "public"."fire_department_sub_units" to "service_role";

grant select on table "public"."fire_department_sub_units" to "service_role";

grant trigger on table "public"."fire_department_sub_units" to "service_role";

grant truncate on table "public"."fire_department_sub_units" to "service_role";

grant update on table "public"."fire_department_sub_units" to "service_role";

grant delete on table "public"."fire_department_users" to "anon";

grant insert on table "public"."fire_department_users" to "anon";

grant references on table "public"."fire_department_users" to "anon";

grant select on table "public"."fire_department_users" to "anon";

grant trigger on table "public"."fire_department_users" to "anon";

grant truncate on table "public"."fire_department_users" to "anon";

grant update on table "public"."fire_department_users" to "anon";

grant delete on table "public"."fire_department_users" to "authenticated";

grant insert on table "public"."fire_department_users" to "authenticated";

grant references on table "public"."fire_department_users" to "authenticated";

grant select on table "public"."fire_department_users" to "authenticated";

grant trigger on table "public"."fire_department_users" to "authenticated";

grant truncate on table "public"."fire_department_users" to "authenticated";

grant update on table "public"."fire_department_users" to "authenticated";

grant delete on table "public"."fire_department_users" to "service_role";

grant insert on table "public"."fire_department_users" to "service_role";

grant references on table "public"."fire_department_users" to "service_role";

grant select on table "public"."fire_department_users" to "service_role";

grant trigger on table "public"."fire_department_users" to "service_role";

grant truncate on table "public"."fire_department_users" to "service_role";

grant update on table "public"."fire_department_users" to "service_role";

grant delete on table "public"."fire_departments" to "anon";

grant insert on table "public"."fire_departments" to "anon";

grant references on table "public"."fire_departments" to "anon";

grant select on table "public"."fire_departments" to "anon";

grant trigger on table "public"."fire_departments" to "anon";

grant truncate on table "public"."fire_departments" to "anon";

grant update on table "public"."fire_departments" to "anon";

grant delete on table "public"."fire_departments" to "authenticated";

grant insert on table "public"."fire_departments" to "authenticated";

grant references on table "public"."fire_departments" to "authenticated";

grant select on table "public"."fire_departments" to "authenticated";

grant trigger on table "public"."fire_departments" to "authenticated";

grant truncate on table "public"."fire_departments" to "authenticated";

grant update on table "public"."fire_departments" to "authenticated";

grant delete on table "public"."fire_departments" to "service_role";

grant insert on table "public"."fire_departments" to "service_role";

grant references on table "public"."fire_departments" to "service_role";

grant select on table "public"."fire_departments" to "service_role";

grant trigger on table "public"."fire_departments" to "service_role";

grant truncate on table "public"."fire_departments" to "service_role";

grant update on table "public"."fire_departments" to "service_role";

create policy "rlsp_fire_department_addresses_delete"
on "public"."fire_department_addresses"
as permissive
for delete
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) = 'admin'::fire_department_user_role));


create policy "rlsp_fire_department_addresses_insert"
on "public"."fire_department_addresses"
as permissive
for insert
to authenticated
with check ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) = 'admin'::fire_department_user_role));


create policy "rlsp_fire_department_addresses_select"
on "public"."fire_department_addresses"
as permissive
for select
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) IS NOT NULL));


create policy "rlsp_fire_department_addresses_update"
on "public"."fire_department_addresses"
as permissive
for update
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) = 'admin'::fire_department_user_role));


create policy "rlsp_fire_department_sub_unit_addresses_delete"
on "public"."fire_department_sub_unit_addresses"
as permissive
for delete
to authenticated
using (check_fire_department_or_sub_unit_admin(( SELECT auth.uid() AS uid), fire_department_sub_unit_id));


create policy "rlsp_fire_department_sub_unit_addresses_insert"
on "public"."fire_department_sub_unit_addresses"
as permissive
for insert
to authenticated
with check (check_fire_department_or_sub_unit_admin(( SELECT auth.uid() AS uid), fire_department_sub_unit_id));


create policy "rlsp_fire_department_sub_unit_addresses_select"
on "public"."fire_department_sub_unit_addresses"
as permissive
for select
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), get_fire_department_id_from_sub_unit(fire_department_sub_unit_id)) IS NOT NULL));


create policy "rlsp_fire_department_sub_unit_addresses_update"
on "public"."fire_department_sub_unit_addresses"
as permissive
for update
to authenticated
using (check_fire_department_or_sub_unit_admin(( SELECT auth.uid() AS uid), fire_department_sub_unit_id));


create policy "rlsp_fire_department_sub_unit_users_delete"
on "public"."fire_department_sub_unit_users"
as permissive
for delete
to authenticated
using (((user_id = ( SELECT auth.uid() AS uid)) OR check_fire_department_or_sub_unit_admin(( SELECT auth.uid() AS uid), fire_department_sub_unit_id)));


create policy "rlsp_fire_department_sub_unit_users_insert"
on "public"."fire_department_sub_unit_users"
as permissive
for insert
to authenticated
with check (check_fire_department_or_sub_unit_admin(( SELECT auth.uid() AS uid), fire_department_sub_unit_id));


create policy "rlsp_fire_department_sub_unit_users_select"
on "public"."fire_department_sub_unit_users"
as permissive
for select
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), get_fire_department_id_from_sub_unit(fire_department_sub_unit_id)) IS NOT NULL));


create policy "rlsp_fire_department_sub_unit_users_update"
on "public"."fire_department_sub_unit_users"
as permissive
for update
to authenticated
using (check_fire_department_or_sub_unit_admin(( SELECT auth.uid() AS uid), fire_department_sub_unit_id));


create policy "rlsp_fire_department_sub_units_delete"
on "public"."fire_department_sub_units"
as permissive
for delete
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) = 'admin'::fire_department_user_role));


create policy "rlsp_fire_department_sub_units_insert"
on "public"."fire_department_sub_units"
as permissive
for insert
to authenticated
with check ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) = 'admin'::fire_department_user_role));


create policy "rlsp_fire_department_sub_units_select"
on "public"."fire_department_sub_units"
as permissive
for select
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) IS NOT NULL));


create policy "rlsp_fire_department_sub_units_update"
on "public"."fire_department_sub_units"
as permissive
for update
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) = 'admin'::fire_department_user_role));


create policy "rlsp_fire_department_users_delete"
on "public"."fire_department_users"
as permissive
for delete
to authenticated
using (((user_id = ( SELECT auth.uid() AS uid)) OR (get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) = 'admin'::fire_department_user_role)));


create policy "rlsp_fire_department_users_insert"
on "public"."fire_department_users"
as permissive
for insert
to authenticated
with check (false);


create policy "rlsp_fire_department_users_select"
on "public"."fire_department_users"
as permissive
for select
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) IS NOT NULL));


create policy "rlsp_fire_department_users_update"
on "public"."fire_department_users"
as permissive
for update
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), fire_department_id) = 'admin'::fire_department_user_role));


create policy "rlsp_fire_departments_delete"
on "public"."fire_departments"
as permissive
for delete
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), id) = 'admin'::fire_department_user_role));


create policy "rlsp_fire_departments_insert"
on "public"."fire_departments"
as permissive
for insert
to authenticated
with check (false);


create policy "rlsp_fire_departments_select"
on "public"."fire_departments"
as permissive
for select
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), id) IS NOT NULL));


create policy "rlsp_fire_departments_update"
on "public"."fire_departments"
as permissive
for update
to authenticated
using ((get_fire_department_user_role(( SELECT auth.uid() AS uid), id) = 'admin'::fire_department_user_role));



