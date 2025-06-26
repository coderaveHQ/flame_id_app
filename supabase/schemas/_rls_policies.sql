/* 
 * Section: Row Level Security (RLS) Policy Definitions
 * Description: This script defines Row Level Security (RLS) policies for all tables in the public schema
 * to enforce fine-grained access control based on user roles, authentication status, and associated
 * fire department or sub-unit relationships. Policies are applied to regulate INSERT, SELECT, UPDATE,
 * and DELETE operations.
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
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), id) IS NOT NULL - Grants access
 *        only if the authenticated user's role for the specific fire department is defined,
 *        ensuring users can only view departments they are associated with.
 */
CREATE POLICY rlsp_fire_departments_select ON public.fire_departments
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), id) IS NOT NULL
    );

/* 
 * Policy: rlsp_fire_departments_update
 * Purpose: Restricts UPDATE operations on the 'fire_departments' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), id) = 'admin'::public.fire_department_user_role
 *        - Allows updates only for users with the 'admin' role for the specific fire department.
 */
CREATE POLICY rlsp_fire_departments_update ON public.fire_departments
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_departments_delete
 * Purpose: Restricts DELETE operations on the 'fire_departments' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), id) = 'admin'::public.fire_department_user_role
 *        - Allows deletion only for users with the 'admin' role for the specific fire department.
 */
CREATE POLICY rlsp_fire_departments_delete ON public.fire_departments
    FOR DELETE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), id) = 'admin'::public.fire_department_user_role
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
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) IS NOT NULL
 *        - Grants access only if the authenticated user has a defined role for the associated fire department.
 */
CREATE POLICY rlsp_fire_department_users_select ON public.fire_department_users
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) IS NOT NULL
    );

/* 
 * Policy: rlsp_fire_department_users_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_users' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
 *        - Allows updates only for users with the 'admin' role for the specific fire department.
 */
CREATE POLICY rlsp_fire_department_users_update ON public.fire_department_users
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_users_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_users' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: user_id = (SELECT auth.uid()) OR public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
 *        - Allows deletion either by the user themselves (matching user_id) or by an 'admin' for the department.
 */
CREATE POLICY rlsp_fire_department_users_delete ON public.fire_department_users
    FOR DELETE
    TO authenticated
    USING (
        user_id = (SELECT auth.uid())
        OR public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_addresses_insert
 * Purpose: Restricts INSERT operations on the 'fire_department_addresses' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
 *        - Allows inserts only for users with the 'admin' role for the associated fire department.
 */
CREATE POLICY rlsp_fire_department_addresses_insert ON public.fire_department_addresses
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_addresses_select
 * Purpose: Allows SELECT operations on the 'fire_department_addresses' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) IS NOT NULL
 *        - Grants access only if the authenticated user has a defined role for the associated fire department.
 */
CREATE POLICY rlsp_fire_department_addresses_select ON public.fire_department_addresses
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role(
            (SELECT auth.uid()),
            fire_department_id
        ) IS NOT NULL
    );

/* 
 * Policy: rlsp_fire_department_addresses_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_addresses' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
 *        - Allows updates only for users with the 'admin' role for the specific fire department.
 */
CREATE POLICY rlsp_fire_department_addresses_update ON public.fire_department_addresses
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_addresses_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_addresses' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
 *        - Allows deletion only for users with the 'admin' role for the specific fire department.
 */
CREATE POLICY rlsp_fire_department_addresses_delete ON public.fire_department_addresses
    FOR DELETE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_sub_units_insert
 * Purpose: Restricts INSERT operations on the 'fire_department_sub_units' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
 *        - Allows inserts only for users with the 'admin' role for the associated fire department.
 */
CREATE POLICY rlsp_fire_department_sub_units_insert ON public.fire_department_sub_units
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_sub_units_select
 * Purpose: Allows SELECT operations on the 'fire_department_sub_units' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) IS NOT NULL
 *        - Grants access only if the authenticated user has a defined role for the associated fire department.
 */
CREATE POLICY rlsp_fire_department_sub_units_select ON public.fire_department_sub_units
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) IS NOT NULL
    );

/* 
 * Policy: rlsp_fire_department_sub_units_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_sub_units' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
 *        - Allows updates only for users with the 'admin' role for the specific fire department.
 */
CREATE POLICY rlsp_fire_department_sub_units_update ON public.fire_department_sub_units
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_sub_units_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_sub_units' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
 *        - Allows deletion only for users with the 'admin' role for the specific fire department.
 */
CREATE POLICY rlsp_fire_department_sub_units_delete ON public.fire_department_sub_units
    FOR DELETE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_users_insert
 * Purpose: Restricts INSERT operations on the 'fire_department_sub_unit_users' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: public.check_fire_department_or_sub_unit_admin((SELECT auth.uid()), fire_department_sub_unit_id)
 *        - Allows inserts only for users who are admins or representative_admins of the sub-unit or its parent department.
 */
CREATE POLICY rlsp_fire_department_sub_unit_users_insert ON public.fire_department_sub_unit_users
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_users_select
 * Purpose: Allows SELECT operations on the 'fire_department_sub_unit_users' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), public.get_fire_department_id_from_sub_unit(fire_department_sub_unit_id)) IS NOT NULL
 *        - Grants access only if the authenticated user has a defined role for the associated fire department.
 */
CREATE POLICY rlsp_fire_department_sub_unit_users_select ON public.fire_department_sub_unit_users
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role(
            (SELECT auth.uid()),
            public.get_fire_department_id_from_sub_unit(fire_department_sub_unit_id)
        ) IS NOT NULL
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_users_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_sub_unit_users' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.check_fire_department_or_sub_unit_admin((SELECT auth.uid()), fire_department_sub_unit_id)
 *        - Allows updates only for users who are admins or representative_admins of the sub-unit or its parent department.
 */
CREATE POLICY rlsp_fire_department_sub_unit_users_update ON public.fire_department_sub_unit_users
    FOR UPDATE
    TO authenticated
    USING (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_users_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_sub_unit_users' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: user_id = (SELECT auth.uid()) OR public.check_fire_department_or_sub_unit_admin((SELECT auth.uid()), fire_department_sub_unit_id)
 *        - Allows deletion either by the user themselves (matching user_id) or by admins/representative_admins of the sub-unit.
 */
CREATE POLICY rlsp_fire_department_sub_unit_users_delete ON public.fire_department_sub_unit_users
    FOR DELETE
    TO authenticated
    USING (
        user_id = (SELECT auth.uid())
        OR public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_addresses_insert
 * Purpose: Restricts INSERT operations on the 'fire_department_sub_unit_addresses' table.
 * Action: FOR INSERT
 * Role: authenticated
 * Check: public.check_fire_department_or_sub_unit_admin((SELECT auth.uid()), fire_department_sub_unit_id)
 *        - Allows inserts only for users who are admins or representative_admins of the sub-unit or its parent department.
 */
CREATE POLICY rlsp_fire_department_sub_unit_addresses_insert ON public.fire_department_sub_unit_addresses
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_addresses_select
 * Purpose: Allows SELECT operations on the 'fire_department_sub_unit_addresses' table for authenticated users.
 * Action: FOR SELECT
 * Role: authenticated
 * Using: public.get_fire_department_user_role((SELECT auth.uid()), public.get_fire_department_id_from_sub_unit(fire_department_sub_unit_id)) IS NOT NULL
 *        - Grants access only if the authenticated user has a defined role for the associated fire department.
 */
CREATE POLICY rlsp_fire_department_sub_unit_addresses_select ON public.fire_department_sub_unit_addresses
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role(
            (SELECT auth.uid()),
            public.get_fire_department_id_from_sub_unit(fire_department_sub_unit_id)
        ) IS NOT NULL
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_addresses_update
 * Purpose: Restricts UPDATE operations on the 'fire_department_sub_unit_addresses' table.
 * Action: FOR UPDATE
 * Role: authenticated
 * Using: public.check_fire_department_or_sub_unit_admin((SELECT auth.uid()), fire_department_sub_unit_id)
 *        - Allows updates only for users who are admins or representative_admins of the sub-unit or its parent department.
 */
CREATE POLICY rlsp_fire_department_sub_unit_addresses_update ON public.fire_department_sub_unit_addresses
    FOR UPDATE
    TO authenticated
    USING (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );

/* 
 * Policy: rlsp_fire_department_sub_unit_addresses_delete
 * Purpose: Restricts DELETE operations on the 'fire_department_sub_unit_addresses' table.
 * Action: FOR DELETE
 * Role: authenticated
 * Using: public.check_fire_department_or_sub_unit_admin((SELECT auth.uid()), fire_department_sub_unit_id)
 *        - Allows deletion only for users who are admins or representative_admins of the sub-unit or its parent department.
 */
CREATE POLICY rlsp_fire_department_sub_unit_addresses_delete ON public.fire_department_sub_unit_addresses
    FOR DELETE
    TO authenticated
    USING (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );