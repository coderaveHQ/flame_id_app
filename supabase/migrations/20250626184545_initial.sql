/* 
 * Consolidated SQL Script for Fire Department Database Schema
 * Description: This script combines all definitions for types, tables, functions, triggers, policies,
 * and access controls for the fire department application. It is organized into sections for clarity
 * and follows PostgreSQL/Supabase conventions with detailed English comments.
 * Date: June 26, 2025
 */

/* 
 * Level: Enum Type Definitions
 * Description: Defines ENUM types to enforce data consistency for fire department categories,
 * user roles, ranks, and sub-unit roles.
 */

/* 
 * Create an ENUM type to categorize different types of fire departments.
 * The ENUM ensures that only predefined values can be used for the 'type' column in the fire_departments table.
 * Values include 'freiwillige_feuerwehr' (voluntary fire department), 'berufsfeuerwehr' (professional fire department),
 * 'pflichtfeuerwehr' (mandatory fire department), and 'other' for unspecified types.
 */
CREATE TYPE public.fire_department_type AS ENUM (
    'freiwillige_feuerwehr',
    'berufsfeuerwehr',
    'pflichtfeuerwehr',
    'other'
);

/* 
 * Create an ENUM type to define possible roles a user can have within a fire department.
 * The ENUM ensures that only 'admin' or 'user' values can be assigned to the 'role' column.
 * - 'admin': User with administrative privileges.
 * - 'user': Standard user with limited access.
 */
CREATE TYPE public.fire_department_user_role AS ENUM (
    'admin',
    'user'
);

/* 
 * Create an ENUM type to define the hierarchical ranks within a fire department.
 * The ENUM provides a comprehensive list of ranks, from trainee to director levels, including
 * 'other' and 'none' for flexibility. This ensures data consistency in the 'rank' column.
 */
CREATE TYPE public.fire_department_rank AS ENUM (
    'feuerwehrmann_anwaerter',
    'feuerwehrmann',
    'oberfeuerwehrmann',
    'hauptfeuerwehrmann',
    'loeschmeister',
    'oberloeschmeister',
    'hauptloeschmeister',
    'unterbrandmeister',
    'brandmeister_anwaerter',
    'brandmeister',
    'oberbrandmeister',
    'hauptbrandmeister',
    'hauptbrandmeister_mit_zulage',
    'gruppenfuehrer',
    'zugfuehrer',
    'kreisbrandmeister',
    'kreisbrandrat',
    'kreisbranddirektor',
    'brandinspektor',
    'brandoberinspektor',
    'stadtbrandinspektor',
    'brandamtmann',
    'brandamtsrat',
    'brandoberamtsrat',
    'brandreferendar',
    'brandrat',
    'oberbrandrat',
    'branddirektor',
    'leitender_branddirektor',
    'direktor_berufsfeuerwehr',
    'other',
    'none'
);

/* 
 * Create an ENUM type to categorize the various types of sub-units within a fire department.
 * The ENUM ensures that only predefined values can be used for the 'type' column in the
 * fire_department_sub_units table. This includes operational units (e.g., 'loescheinheit'),
 * youth groups (e.g., 'jugendfeuerwehr'), and support units (e.g., 'versorgungszug').
 */
CREATE TYPE public.fire_department_sub_unit_type AS ENUM (
    'loescheinheit',
    'jugendfeuerwehr',
    'kinderfeuerwehr',
    'iuk_einheit',
    'musik_versorgungszug',
    'technische_einsatzgruppe',
    'gefahrgutgruppe',
    'atemschutzgruppe',
    'drohneneinheit',
    'wasserrettungsgruppe',
    'hoehenrettungsgruppe',
    'sanitaetsgruppe',
    'fuehrungsgruppe',
    'musikzug',
    'versorgungszug',
    'alters_ehrenabteilung',
    'feuerwehrverein'
);

/* 
 * Create an ENUM type to define possible roles a user can have within a fire department sub-unit.
 * The ENUM ensures that only 'admin', 'representative_admin', or 'user' values can be assigned to the 'role' column.
 * - 'admin': User with full administrative privileges within the sub-unit.
 * - 'representative_admin': User with partial administrative privileges, representing the sub-unit.
 * - 'user': Standard user with limited access.
 */
CREATE TYPE public.fire_department_sub_unit_user_role AS ENUM (
    'admin',
    'representative_admin',
    'user'
);

/* 
 * Level: Table Definitions
 * Description: Defines the tables for fire departments, users, sub-units, and their addresses,
 * with primary and foreign key constraints, and enables Row Level Security (RLS).
 */

/* 
 * Create the 'fire_departments' table to store details of fire departments.
 * - 'id': A UUID primary key, automatically generated using gen_random_uuid() for uniqueness.
 * - 'type': A NOT NULL column referencing the fire_department_type ENUM to categorize the department.
 * - 'name': A NOT NULL TEXT column to store the name of the fire department.
 * - PRIMARY KEY constraint ensures 'id' is unique and serves as the table's primary key.
 */
CREATE TABLE public.fire_departments (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    type public.fire_department_type NOT NULL,
    name TEXT NOT NULL,
    CONSTRAINT pk_fire_departments PRIMARY KEY (id)
);

/* 
 * Enable Row Level Security (RLS) on the 'fire_departments' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role and auth.uid()) can view or modify data.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_departments
    ENABLE ROW LEVEL SECURITY;

/* 
 * Create the 'fire_department_users' table to associate users with their fire departments,
 * including their role, rank, and name.
 * - 'fire_department_id': A UUID NOT NULL column referencing the fire_departments table, part of the composite primary key.
 * - 'user_id': A UUID NOT NULL column referencing the auth.users table, part of the composite primary key.
 * - 'role': A NOT NULL column using the fire_department_user_role ENUM to define the user's role.
 * - 'rank': A NOT NULL column using the fire_department_rank ENUM to define the user's rank.
 * - 'name': A NOT NULL TEXT column to store the user's name.
 * - 'pk_fire_department_users': A composite PRIMARY KEY constraint on (fire_department_id, user_id) to ensure uniqueness.
 * - 'fk_fire_department_users_fire_department': A FOREIGN KEY constraint linking to fire_departments(id).
 * - 'fk_fire_department_users_user': A FOREIGN KEY constraint linking to auth.users(id).
 */
CREATE TABLE public.fire_department_users (
    fire_department_id UUID NOT NULL,
    user_id UUID NOT NULL,
    role public.fire_department_user_role NOT NULL,
    rank public.fire_department_rank NOT NULL,
    name TEXT NOT NULL,
    CONSTRAINT pk_fire_department_users PRIMARY KEY (fire_department_id, user_id),
    CONSTRAINT fk_fire_department_users_fire_department FOREIGN KEY (fire_department_id)
        REFERENCES public.fire_departments (id),
    CONSTRAINT fk_fire_department_users_user FOREIGN KEY (user_id)
        REFERENCES auth.users (id)
);

/* 
 * Enable Row Level Security (RLS) on the 'fire_department_users' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role and auth.uid()) can view or modify their own or administrable data.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_department_users
    ENABLE ROW LEVEL SECURITY;

/* 
 * Create the 'fire_department_sub_units' table to store information about sub-units within fire departments.
 * - 'id': A UUID primary key, automatically generated using gen_random_uuid() for uniqueness.
 * - 'fire_department_id': A UUID NOT NULL column referencing the fire_departments table, linking sub-units to their parent department.
 * - 'type': A NOT NULL column using the fire_department_sub_unit_type ENUM to categorize the sub-unit.
 * - 'name': A NOT NULL TEXT column to store the name of the sub-unit.
 * - 'pk_fire_department_sub_units': A PRIMARY KEY constraint on 'id' to ensure uniqueness.
 * - 'fk_fire_department_sub_units_fire_department': A FOREIGN KEY constraint linking to fire_departments(id).
 */
CREATE TABLE public.fire_department_sub_units (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    fire_department_id UUID NOT NULL,
    type public.fire_department_sub_unit_type NOT NULL,
    name TEXT NOT NULL,
    CONSTRAINT pk_fire_department_sub_units PRIMARY KEY (id),
    CONSTRAINT fk_fire_department_sub_units_fire_department FOREIGN KEY (fire_department_id)
        REFERENCES public.fire_departments (id)
);

/* 
 * Enable Row Level Security (RLS) on the 'fire_department_sub_units' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role and association with the fire department) can view or modify sub-unit data.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_department_sub_units
    ENABLE ROW LEVEL SECURITY;

/* 
 * Create the 'fire_department_sub_unit_users' table to associate users with their roles in specific sub-units.
 * - 'fire_department_sub_unit_id': A UUID NOT NULL column referencing the fire_department_sub_units table, part of the composite primary key.
 * - 'user_id': A UUID NOT NULL column referencing the auth.users table, part of the composite primary key.
 * - 'role': A NOT NULL column using the fire_department_sub_unit_user_role ENUM to define the user's role within the sub-unit.
 * - 'pk_fire_department_sub_unit_users': A composite PRIMARY KEY constraint on (fire_department_sub_unit_id, user_id) to ensure uniqueness per sub-unit and user.
 * - 'fk_fire_department_sub_unit_users_fire_department_sub_unit': A FOREIGN KEY constraint linking to fire_department_sub_units(id).
 * - 'fk_fire_department_sub_unit_users_user': A FOREIGN KEY constraint linking to auth.users(id).
 */
CREATE TABLE public.fire_department_sub_unit_users (
    fire_department_sub_unit_id UUID NOT NULL,
    user_id UUID NOT NULL,
    role public.fire_department_sub_unit_user_role NOT NULL,
    CONSTRAINT pk_fire_department_sub_unit_users PRIMARY KEY (fire_department_sub_unit_id, user_id),
    CONSTRAINT fk_fire_department_sub_unit_users_fire_department_sub_unit FOREIGN KEY (fire_department_sub_unit_id)
        REFERENCES public.fire_department_sub_units (id),
    CONSTRAINT fk_fire_department_sub_unit_users_user FOREIGN KEY (user_id)
        REFERENCES auth.users (id)
);

/* 
 * Enable Row Level Security (RLS) on the 'fire_department_sub_unit_users' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role, sub-unit association, and auth.uid()) can view or modify user-sub-unit relationships.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_department_sub_unit_users
    ENABLE ROW LEVEL SECURITY;

/* 
 * Create the 'fire_department_sub_unit_addresses' table to store address information for fire department sub-units.
 * - 'id': A UUID primary key, automatically generated using gen_random_uuid() for uniqueness.
 * - 'fire_department_sub_unit_id': A UUID NOT NULL column referencing the fire_department_sub_units table,
 *   linking each address to a specific sub-unit.
 * - 'street': A NOT NULL TEXT column to store the street name of the address.
 * - 'postal_code': A NOT NULL TEXT column to store the postal code.
 * - 'city': A NOT NULL TEXT column to store the city name.
 * - 'pk_fire_department_sub_unit_addresses': A PRIMARY KEY constraint on 'id' to ensure uniqueness.
 * - 'fk_fire_department_sub_unit_addresses_fire_department_sub_unit': A FOREIGN KEY constraint linking to
 *   fire_department_sub_units(id), enforcing referential integrity.
 */
CREATE TABLE public.fire_department_sub_unit_addresses (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    fire_department_sub_unit_id UUID NOT NULL,
    street TEXT NOT NULL,
    postal_code TEXT NOT NULL,
    city TEXT NOT NULL,
    CONSTRAINT pk_fire_department_sub_unit_addresses PRIMARY KEY (id),
    CONSTRAINT fk_fire_department_sub_unit_addresses_fire_department_sub_unit FOREIGN KEY (fire_department_sub_unit_id)
        REFERENCES public.fire_department_sub_units (id)
);

/* 
 * Enable Row Level Security (RLS) on the 'fire_department_sub_unit_addresses' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role, sub-unit association, and auth.uid()) can view or modify address data.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_department_sub_unit_addresses
    ENABLE ROW LEVEL SECURITY;

/* 
 * Create the 'fire_department_addresses' table to store address information for fire departments.
 * - 'id': A UUID primary key, automatically generated using gen_random_uuid() for uniqueness.
 * - 'fire_department_id': A UUID NOT NULL column referencing the fire_departments table,
 *   linking each address to a specific fire department.
 * - 'street': A NOT NULL TEXT column to store the street name of the address.
 * - 'postal_code': A NOT NULL TEXT column to store the postal code.
 * - 'city': A NOT NULL TEXT column to store the city name.
 * - 'pk_fire_department_addresses': A PRIMARY KEY constraint on 'id' to ensure uniqueness.
 * - 'fk_fire_department_addresses_fire_department': A FOREIGN KEY constraint linking to
 *   fire_departments(id), enforcing referential integrity.
 */
CREATE TABLE public.fire_department_addresses (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    fire_department_id UUID NOT NULL,
    street TEXT NOT NULL,
    postal_code TEXT NOT NULL,
    city TEXT NOT NULL,
    CONSTRAINT pk_fire_department_addresses PRIMARY KEY (id),
    CONSTRAINT fk_fire_department_addresses_fire_department FOREIGN KEY (fire_department_id)
        REFERENCES public.fire_departments (id)
);

/* 
 * Enable Row Level Security (RLS) on the 'fire_department_addresses' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role, department association, and auth.uid()) can view or modify address data.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_department_addresses
    ENABLE ROW LEVEL SECURITY;

/* 
 * Level: Function Definitions
 * Description: Defines PostgreSQL functions to manage user creation, role retrieval, and
 * administrative privilege checks, supporting RLS policies.
 */

/* 
 * Function: handle_new_user
 * Purpose: Automatically inserts a new user into the fire_department_users table when a user is created
 *          in the auth.users table, using metadata from the authentication event. Additionally, if an optional
 *          'sub_units' array is provided in the metadata, it inserts corresponding entries into the 
 *          fire_department_sub_unit_users table for each sub-unit.
 * Parameters: Trigger context (implicit via RETURNS TRIGGER).
 * Returns: TRIGGER - Returns the new row to complete the trigger operation.
 * Security: SECURITY DEFINER ensures the function runs with the privileges of the role that created it,
 *           typically supabase_auth_admin, to access auth.users.
 * Note: Relies on raw_user_meta_data containing an 'initial_data' object with 'fire_department_id', 'role', 'rank', and 'name'. 
 *       Optionally, 'sub_units' can be an array of objects within 'initial_data', each with 'fire_department_sub_unit_id' (UUID) 
 *       and 'role' (matching fire_department_sub_unit_user_role ENUM).
 */
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    sub_unit jsonb; -- Temporary variable for each array element (as jsonb for better handling)
BEGIN
    -- Core insert into fire_department_users (always executed)
    INSERT INTO public.fire_department_users (
        fire_department_id,
        user_id,
        role,
        rank,
        name
    )
    VALUES (
        (NEW.raw_user_meta_data->'initial_data'->>'fire_department_id')::UUID, -- Casts the fire_department_id from JSON to UUID
        NEW.id, -- The user_id from the auth.users table
        (NEW.raw_user_meta_data->'initial_data'->>'role')::public.fire_department_user_role, -- Casts role to the defined ENUM
        (NEW.raw_user_meta_data->'initial_data'->>'rank')::public.fire_department_rank, -- Casts rank to the defined ENUM
        (NEW.raw_user_meta_data->'initial_data'->>'name')::TEXT -- Casts name to TEXT
    );

    -- Optional insert for sub-units: Only if 'sub_units' exists and is an array within 'initial_data'
    IF (NEW.raw_user_meta_data->'initial_data' ? 'sub_units') AND jsonb_typeof(NEW.raw_user_meta_data->'initial_data'->'sub_units') = 'array' THEN
        FOR sub_unit IN SELECT * FROM jsonb_array_elements(NEW.raw_user_meta_data->'initial_data'->'sub_units')
        LOOP
            INSERT INTO public.fire_department_sub_unit_users (
                fire_department_sub_unit_id,
                user_id,
                role
            )
            VALUES (
                (sub_unit->>'fire_department_sub_unit_id')::UUID, -- Casts to UUID (adjusted key)
                NEW.id, -- The user_id from the auth.users table
                (sub_unit->>'role')::public.fire_department_sub_unit_user_role -- Casts to ENUM
            );
        END LOOP;
    END IF;

    RETURN NEW; -- Returns the newly created row to complete the trigger
END;
$$;

/* 
 * Function: get_fire_department_user_role
 * Purpose: Retrieves the role of a user within a specific fire department.
 * Parameters:
 *   - p_user_id (uuid): The ID of the user to check.
 *   - p_fire_department_id (uuid): The ID of the fire department to check.
 * Returns: public.fire_department_user_role - The role ('admin' or 'user') or NULL if not found.
 * Security: SECURITY DEFINER ensures the function can access the fire_department_users table securely.
 * Note: Uses LIMIT 1 to return the first matching role, assuming a unique constraint exists.
 */
CREATE OR REPLACE FUNCTION public.get_fire_department_user_role(p_user_id uuid, p_fire_department_id uuid)
RETURNS public.fire_department_user_role
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN (
        SELECT role
        FROM public.fire_department_users
        WHERE fire_department_id = p_fire_department_id
        AND user_id = p_user_id
        LIMIT 1 -- Ensures only one row is returned, relying on the primary key constraint
    );
END;
$$;

/* 
 * Function: get_fire_department_sub_unit_user_role
 * Purpose: Retrieves the role of a user within a specific fire department sub-unit.
 * Parameters:
 *   - p_user_id (uuid): The ID of the user to check.
 *   - p_fire_department_sub_unit_id (uuid): The ID of the sub-unit to check.
 * Returns: public.fire_department_sub_unit_user_role - The role ('admin', 'representative_admin', or 'user') or NULL if not found.
 * Security: SECURITY DEFINER ensures the function can access the fire_department_sub_unit_users table securely.
 * Note: Uses LIMIT 1 to return the first matching role, assuming a unique constraint exists.
 */
CREATE OR REPLACE FUNCTION public.get_fire_department_sub_unit_user_role(p_user_id uuid, p_fire_department_sub_unit_id uuid)
RETURNS public.fire_department_sub_unit_user_role
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN (
        SELECT role
        FROM public.fire_department_sub_unit_users
        WHERE fire_department_sub_unit_id = p_fire_department_sub_unit_id
        AND user_id = p_user_id
        LIMIT 1 -- Ensures only one row is returned, relying on the primary key constraint
    );
END;
$$;

/* 
 * Function: check_fire_department_or_sub_unit_admin
 * Purpose: Checks if a user has administrative privileges (admin or representative_admin) for a specific sub-unit,
 *          either directly or through their fire department role.
 * Parameters:
 *   - p_user_id (uuid): The ID of the user to check.
 *   - p_fire_department_sub_unit_id (uuid): The ID of the sub-unit to check.
 * Returns: boolean - True if the user is an admin or representative_admin, False otherwise.
 * Security: SECURITY DEFINER ensures the function can access related functions and tables securely.
 * Note: Combines results from get_fire_department_user_role and get_fire_department_sub_unit_user_role.
 */
CREATE OR REPLACE FUNCTION public.check_fire_department_or_sub_unit_admin(p_user_id uuid, p_fire_department_sub_unit_id uuid)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
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
$$;

/* 
 * Function: get_fire_department_id_from_sub_unit
 * Purpose: Retrieves the fire department ID associated with a specific sub-unit.
 * Parameters:
 *   - p_fire_department_sub_unit_id (uuid): The ID of the sub-unit to check.
 * Returns: uuid - The fire_department_id or NULL if not found.
 * Security: SECURITY DEFINER ensures the function can access the fire_department_sub_units table securely.
 * Note: Uses LIMIT 1 to return the first matching ID, assuming a unique constraint exists.
 */
CREATE OR REPLACE FUNCTION public.get_fire_department_id_from_sub_unit(p_fire_department_sub_unit_id uuid)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN (
        SELECT fire_department_id
        FROM public.fire_department_sub_units
        WHERE id = p_fire_department_sub_unit_id
        LIMIT 1 -- Ensures only one row is returned, relying on the primary key constraint
    );
END;
$$;

/* 
 * Function: get_sub_units_of_users_fire_department
 * Purpose: Retrieves all sub-units (with ID, type, and name) associated with the fire department 
 *          of which the calling authenticated user is a member. 
 *          This function uses the authenticated user's ID (auth.uid()) to determine their 
 *          fire department and returns matching sub-units.
 * Parameters: None (uses auth.uid() implicitly).
 * Returns: TABLE (id UUID, type public.fire_department_sub_unit_type, name TEXT) - A table of sub-unit IDs, types, and names.
 * Security: SECURITY DEFINER ensures the function runs with the privileges of the creator,
 *           allowing access to necessary tables while respecting RLS policies.
 * Note: Assumes the calling user is authenticated and has an entry in fire_department_users.
 *       If the user is not associated with any fire department, an empty result is returned.
 *       Expose this function as an RPC in Supabase for client-side calls.
 */
CREATE OR REPLACE FUNCTION public.get_sub_units_of_users_fire_department()
RETURNS TABLE (id UUID, type public.fire_department_sub_unit_type, name TEXT)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN QUERY
    SELECT su.id, su.type, su.name
    FROM public.fire_department_sub_units su
    JOIN public.fire_department_users fu ON su.fire_department_id = fu.fire_department_id
    WHERE fu.user_id = auth.uid();
END;
$$;

/* 
 * Level: Trigger Definition
 * Description: Defines a trigger to automate user creation in the fire_department_users table
 * when new users are added to auth.users.
 */

/* 
 * Create a trigger named 'on_auth_user_created' to handle new user creation in the auth.users table.
 * - 'AFTER INSERT': The trigger fires after a new row is inserted into auth.users.
 * - 'FOR EACH ROW': The trigger executes for each inserted row individually.
 * - 'EXECUTE FUNCTION public.handle_new_user()': Calls the handle_new_user function to process
 *   the new user data, typically to insert a corresponding entry into fire_department_users
 *   using metadata from the auth.users table.
 * Note: This trigger relies on the handle_new_user function being defined and assumes
 *       raw_user_meta_data contains the required fields (fire_department_id, role, rank, name).
 */
CREATE OR REPLACE TRIGGER on_auth_user_created
    AFTER INSERT
    ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();

/* 
 * Level: Row Level Security (RLS) Policy Definitions
 * Description: Defines RLS policies for all tables in the public schema to enforce fine-grained
 * access control based on user roles, authentication status, and associated fire department
 * or sub-unit relationships. Policies use out-sourced functions to avoid repetition.
 */

/* 
 * Policy: rlsp_fire_departments_insert
 * Purpose: Restricts INSERT operations on the 'fire_departments' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: WITH CHECK (false) - Prevents any INSERT operations, ensuring no new fire departments
 *        can be added directly by authenticated users. This might be intended to enforce
 *        creation through a specific process or trigger.
 */
CREATE POLICY rlsp_fire_departments_insert ON public.fire_departments
    FOR INSERT
    TO authenticated
    WITH CHECK (
        false
    );

/* 
 * Policy: rlsp_fire_departments_select
 * Purpose: Allows SELECT operations on the 'fire_departments' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: EXISTS subquery to check if the user is associated with the fire department via fire_department_users.
 *        This out-sources the check to avoid repetition and ensures users can only view departments they are associated with.
 */
CREATE POLICY rlsp_fire_departments_select ON public.fire_departments
    FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM public.fire_department_users fu
            WHERE fu.fire_department_id = fire_departments.id
            AND fu.user_id = auth.uid()
        )
    );

/* 
 * Policy: rlsp_fire_departments_update
 * Purpose: Restricts UPDATE operations on the 'fire_departments' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.get_fire_department_user_role(auth.uid(), id) = 'admin' - Allows updates only for admins of the department.
 */
CREATE POLICY rlsp_fire_departments_update ON public.fire_departments
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role(auth.uid(), id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_departments_delete
 * Purpose: Restricts DELETE operations on the 'fire_departments' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: public.get_fire_department_user_role(auth.uid(), id) = 'admin' - Allows deletion only for admins of the department.
 */
CREATE POLICY rlsp_fire_departments_delete ON public.fire_departments
    FOR DELETE
    TO authenticated
    USING (
        public.get_fire_department_user_role(auth.uid(), id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_users_insert
 * Purpose: Restricts INSERT operations on the 'fire_department_users' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: WITH CHECK (false) - Prevents any INSERT operations, likely intended to enforce
 *        creation through the handle_new_user trigger rather than direct inserts.
 */
CREATE POLICY rlsp_fire_department_users_insert ON public.fire_department_users
    FOR INSERT
    TO authenticated
    WITH CHECK (
        false
    );

/* 
 * Policy: rlsp_fire_department_users_select
 * Purpose: Allows SELECT operations on the 'fire_department_users' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: EXISTS subquery to check if the user is associated with the fire department or is viewing their own record.
 *        This allows users to see their own data or data within their department.
 */
CREATE POLICY rlsp_fire_department_users_select ON public.fire_department_users
    FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM public.fire_department_users fu_inner
            WHERE fu_inner.fire_department_id = fire_department_users.fire_department_id
            AND fu_inner.user_id = auth.uid()
        ) OR user_id = auth.uid()
    );

/* 
 * Policy: rlsp_fire_department_users_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_users' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin' - Allows updates only for admins of the department.
 */
CREATE POLICY rlsp_fire_department_users_update ON public.fire_department_users
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_users_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_users' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: user_id = auth.uid() OR admin in department - Allows deletion by self or admin.
 */
CREATE POLICY rlsp_fire_department_users_delete ON public.fire_department_users
    FOR DELETE
    TO authenticated
    USING (
        user_id = auth.uid()
        OR public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_addresses_insert
 * Purpose: Restricts INSERT operations on the 'fire_department_addresses' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin' - Allows inserts only for admins of the department.
 */
CREATE POLICY rlsp_fire_department_addresses_insert ON public.fire_department_addresses
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_addresses_select
 * Purpose: Allows SELECT operations on the 'fire_department_addresses' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: EXISTS subquery to check association with the fire department.
 */
CREATE POLICY rlsp_fire_department_addresses_select ON public.fire_department_addresses
    FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM public.fire_department_users fu
            WHERE fu.fire_department_id = fire_department_addresses.fire_department_id
            AND fu.user_id = auth.uid()
        )
    );

/* 
 * Policy: rlsp_fire_department_addresses_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_addresses' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin' - Allows updates only for admins.
 */
CREATE POLICY rlsp_fire_department_addresses_update ON public.fire_department_addresses
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_addresses_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_addresses' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin' - Allows deletion only for admins.
 */
CREATE POLICY rlsp_fire_department_addresses_delete ON public.fire_department_addresses
    FOR DELETE
    TO authenticated
    USING (
        public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_sub_units_insert
 * Purpose: Restricts INSERT operations on the 'fire_department_sub_units' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin' - Allows inserts only for admins of the department.
 */
CREATE POLICY rlsp_fire_department_sub_units_insert ON public.fire_department_sub_units
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_sub_units_select
 * Purpose: Allows SELECT operations on the 'fire_department_sub_units' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: EXISTS subquery to check association with the parent fire department.
 */
CREATE POLICY rlsp_fire_department_sub_units_select ON public.fire_department_sub_units
    FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM public.fire_department_users fu
            WHERE fu.fire_department_id = fire_department_sub_units.fire_department_id
            AND fu.user_id = auth.uid()
        )
    );

/* 
 * Policy: rlsp_fire_department_sub_units_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_sub_units' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin' - Allows updates only for admins.
 */
CREATE POLICY rlsp_fire_department_sub_units_update ON public.fire_department_sub_units
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_sub_units_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_sub_units' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin' - Allows deletion only for admins.
 */
CREATE POLICY rlsp_fire_department_sub_units_delete ON public.fire_department_sub_units
    FOR DELETE
    TO authenticated
    USING (
        public.get_fire_department_user_role(auth.uid(), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_users_insert
 * Purpose: Restricts INSERT operations on the 'fire_department_sub_unit_users' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id) - Allows inserts for admins/representative_admins.
 */
CREATE POLICY rlsp_fire_department_sub_unit_users_insert ON public.fire_department_sub_unit_users
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id)
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_users_select
 * Purpose: Allows SELECT operations on the 'fire_department_sub_unit_users' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: EXISTS subquery to check association with the parent fire department via get_fire_department_id_from_sub_unit.
 */
CREATE POLICY rlsp_fire_department_sub_unit_users_select ON public.fire_department_sub_unit_users
    FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM public.fire_department_users fu
            WHERE fu.fire_department_id = public.get_fire_department_id_from_sub_unit(fire_department_sub_unit_users.fire_department_sub_unit_id)
            AND fu.user_id = auth.uid()
        )
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_users_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_sub_unit_users' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id) - Allows updates for admins/representative_admins.
 */
CREATE POLICY rlsp_fire_department_sub_unit_users_update ON public.fire_department_sub_unit_users
    FOR UPDATE
    TO authenticated
    USING (
        public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id)
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_users_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_sub_unit_users' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: user_id = auth.uid() OR admin/representative_admin - Allows deletion by self or admins.
 */
CREATE POLICY rlsp_fire_department_sub_unit_users_delete ON public.fire_department_sub_unit_users
    FOR DELETE
    TO authenticated
    USING (
        user_id = auth.uid()
        OR public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id)
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_addresses_insert
 * Purpose: Restricts INSERT operations on the 'fire_department_sub_unit_addresses' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id) - Allows inserts for admins/representative_admins.
 */
CREATE POLICY rlsp_fire_department_sub_unit_addresses_insert ON public.fire_department_sub_unit_addresses
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id)
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_addresses_select
 * Purpose: Allows SELECT operations on the 'fire_department_sub_unit_addresses' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: EXISTS subquery to check association with the parent fire department via get_fire_department_id_from_sub_unit.
 */
CREATE POLICY rlsp_fire_department_sub_unit_addresses_select ON public.fire_department_sub_unit_addresses
    FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM public.fire_department_users fu
            WHERE fu.fire_department_id = public.get_fire_department_id_from_sub_unit(fire_department_sub_unit_addresses.fire_department_sub_unit_id)
            AND fu.user_id = auth.uid()
        )
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_addresses_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_sub_unit_addresses' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id) - Allows updates for admins/representative_admins.
 */
CREATE POLICY rlsp_fire_department_sub_unit_addresses_update ON public.fire_department_sub_unit_addresses
    FOR UPDATE
    TO authenticated
    USING (
        public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id)
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_addresses_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_sub_unit_addresses' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id) - Allows deletion for admins/representative_admins.
 */
CREATE POLICY rlsp_fire_department_sub_unit_addresses_delete ON public.fire_department_sub_unit_addresses
    FOR DELETE
    TO authenticated
    USING (
        public.check_fire_department_or_sub_unit_admin(auth.uid(), fire_department_sub_unit_id)
    );

/* 
 * Level: Access Control Definitions
 * Description: Defines access control settings to enforce Row Level Security (RLS) as the primary
 * access control mechanism, with specific grants for service_role and authenticated for function execution.
 */

/* 
 * Block: Revoke Default Permissions on Tables
 * Purpose: Remove all default permissions from anon, authenticated, and public roles on all tables
 * to enforce access control exclusively through RLS policies. This prevents unauthorized direct
 * access to table data.
 */
REVOKE ALL ON TABLE public.fire_department_addresses FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_department_sub_unit_addresses FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_department_sub_unit_users FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_department_sub_units FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_department_users FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_departments FROM authenticated, anon, public;

/* 
 * Block: Revoke Default Permissions on Functions
 * Purpose: Remove all default permissions from anon and public roles on all functions
 * to ensure that only authorized roles (e.g., authenticated, supabase_auth_admin, service_role) can execute them.
 * This enhances security by limiting function access.
 */
REVOKE ALL ON FUNCTION public.check_fire_department_or_sub_unit_admin(uuid, uuid) FROM anon, public;
REVOKE ALL ON FUNCTION public.get_fire_department_id_from_sub_unit(uuid) FROM anon, public;
REVOKE ALL ON FUNCTION public.get_fire_department_sub_unit_user_role(uuid, uuid) FROM anon, public;
REVOKE ALL ON FUNCTION public.get_fire_department_user_role(uuid, uuid) FROM anon, public;
REVOKE ALL ON FUNCTION public.handle_new_user() FROM anon, public;

/* 
 * Block: Grant Permissions for Service Role
 * Purpose: Grant full permissions to the service_role for all tables and functions to support
 * backend operations, triggers (e.g., handle_new_user), and other automated processes.
 */
GRANT ALL ON TABLE public.fire_department_users TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_departments TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_department_addresses TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_department_sub_unit_addresses TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_department_sub_unit_users TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_department_sub_units TO service_role; -- Full control for backend management

GRANT EXECUTE ON FUNCTION public.check_fire_department_or_sub_unit_admin(uuid, uuid) TO service_role; -- Allows execution for RLS checks
GRANT EXECUTE ON FUNCTION public.get_fire_department_id_from_sub_unit(uuid) TO service_role; -- Allows execution for sub-unit to department mapping
GRANT EXECUTE ON FUNCTION public.get_fire_department_sub_unit_user_role(uuid, uuid) TO service_role; -- Allows execution for sub-unit role retrieval
GRANT EXECUTE ON FUNCTION public.get_fire_department_user_role(uuid, uuid) TO service_role; -- Allows execution for department role retrieval
GRANT EXECUTE ON FUNCTION public.handle_new_user() TO service_role; -- Allows execution for new user trigger

/* 
 * Block: Grant Execute Permissions for Authenticated on Functions
 * Purpose: Grant EXECUTE permissions to authenticated users on functions used in RLS policies
 * to allow policy evaluation without permission denied errors, while maintaining security through RLS.
 */
GRANT EXECUTE ON FUNCTION public.check_fire_department_or_sub_unit_admin(uuid, uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_fire_department_id_from_sub_unit(uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_fire_department_sub_unit_user_role(uuid, uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_fire_department_user_role(uuid, uuid) TO authenticated;

/* 
 * Block: Final Revoke of All Permissions
 * Purpose: Perform a comprehensive revoke of all permissions on all tables and functions in the
 * public schema from anon, authenticated, and public roles to enforce RLS as the sole access control
 * mechanism. This is a safety net to ensure no residual permissions remain. Note: EXECUTE grants for functions are preserved.
 */
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM anon; -- Revokes all table permissions from anon
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM authenticated; -- Revokes all table permissions from authenticated
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM public; -- Revokes all table permissions from public
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM anon; -- Revokes all function permissions from anon
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM public; -- Revokes all function permissions from public