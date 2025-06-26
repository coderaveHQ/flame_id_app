/* 
 * Section: Function Definitions for User and Role Management
 * Description: This script defines a set of PostgreSQL functions to handle new user creation,
 * retrieve user roles, and check administrative privileges within fire departments and sub-units.
 * All functions are defined with SECURITY DEFINER to ensure secure execution with elevated privileges.
 */

/* 
 * Function: handle_new_user
 * Purpose: Automatically inserts a new user into the fire_department_users table when a user is created
 *          in the auth.users table, using metadata from the authentication event.
 * Parameters: Trigger context (implicit via RETURNS TRIGGER).
 * Returns: TRIGGER - Returns the new row to complete the trigger operation.
 * Security: SECURITY DEFINER ensures the function runs with the privileges of the role that created it,
 *           typically supabase_auth_admin, to access auth.users.
 * Note: Relies on raw_user_meta_data containing 'fire_department_id', 'role', 'rank', and 'name'.
 */
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    INSERT INTO public.fire_department_users (
        fire_department_id,
        user_id,
        role,
        rank,
        name
    )
    VALUES (
        (NEW.raw_user_meta_data->>'fire_department_id')::UUID, -- Casts the fire_department_id from JSON to UUID
        NEW.id, -- The user_id from the auth.users table
        (NEW.raw_user_meta_data->>'role')::public.fire_department_user_role, -- Casts role to the defined ENUM
        (NEW.raw_user_meta_data->>'rank')::public.fire_department_rank, -- Casts rank to the defined ENUM
        (NEW.raw_user_meta_data->>'name')::TEXT -- Casts name to TEXT
    );
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
CREATE FUNCTION public.check_fire_department_or_sub_unit_admin(p_user_id uuid, p_fire_department_sub_unit_id uuid)
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
CREATE FUNCTION public.get_fire_department_id_from_sub_unit(p_fire_department_sub_unit_id uuid)
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