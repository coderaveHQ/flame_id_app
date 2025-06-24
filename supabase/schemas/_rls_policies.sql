CREATE POLICY rlsp_fire_departments_insert ON public.fire_departments
    FOR INSERT
    TO authenticated
    WITH CHECK (
        false
    );

CREATE POLICY rlsp_fire_departments_select ON public.fire_departments
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), id) IS NOT NULL
    );

CREATE POLICY rlsp_fire_departments_update ON public.fire_departments
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_departments_delete ON public.fire_departments
    FOR DELETE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_department_users_insert ON public.fire_department_users
    FOR INSERT
    TO authenticated
    WITH CHECK (
        false
    );

CREATE POLICY rlsp_fire_department_users_select ON public.fire_department_users
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) IS NOT NULL
    );

CREATE POLICY rlsp_fire_department_users_update ON public.fire_department_users
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_department_users_delete ON public.fire_department_users
    FOR DELETE
    TO authenticated
    USING (
        user_id = (SELECT auth.uid())
        OR public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_department_addresses_insert ON public.fire_department_addresses
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_department_addresses_select ON public.fire_department_addresses
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role(
            (SELECT auth.uid()),
            fire_department_id
        ) IS NOT NULL
    );

CREATE POLICY rlsp_fire_department_addresses_update ON public.fire_department_addresses
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_department_addresses_delete ON public.fire_department_addresses
    FOR DELETE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_department_sub_units_insert ON public.fire_department_sub_units
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_department_sub_units_select ON public.fire_department_sub_units
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) IS NOT NULL
    );

CREATE POLICY rlsp_fire_department_sub_units_update ON public.fire_department_sub_units
    FOR UPDATE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_department_sub_units_delete ON public.fire_department_sub_units
    FOR DELETE
    TO authenticated
    USING (
        public.get_fire_department_user_role((SELECT auth.uid()), fire_department_id) = 'admin'::public.fire_department_user_role
    );

CREATE POLICY rlsp_fire_department_sub_unit_users_insert ON public.fire_department_sub_unit_users
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );

CREATE POLICY rlsp_fire_department_sub_unit_users_select ON public.fire_department_sub_unit_users
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role(
            (SELECT auth.uid()),
            public.get_fire_department_id_from_sub_unit(fire_department_sub_unit_id)
        ) IS NOT NULL
    );

CREATE POLICY rlsp_fire_department_sub_unit_users_update ON public.fire_department_sub_unit_users
    FOR UPDATE
    TO authenticated
    USING (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );

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

CREATE POLICY rlsp_fire_department_sub_unit_addresses_insert ON public.fire_department_sub_unit_addresses
    FOR INSERT
    TO authenticated
    WITH CHECK (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );

CREATE POLICY rlsp_fire_department_sub_unit_addresses_select ON public.fire_department_sub_unit_addresses
    FOR SELECT
    TO authenticated
    USING (
        public.get_fire_department_user_role(
            (SELECT auth.uid()),
            public.get_fire_department_id_from_sub_unit(fire_department_sub_unit_id)
        ) IS NOT NULL
    );

CREATE POLICY rlsp_fire_department_sub_unit_addresses_update ON public.fire_department_sub_unit_addresses
    FOR UPDATE
    TO authenticated
    USING (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );

CREATE POLICY rlsp_fire_department_sub_unit_addresses_delete ON public.fire_department_sub_unit_addresses
    FOR DELETE
    TO authenticated
    USING (
        public.check_fire_department_or_sub_unit_admin(
            (SELECT auth.uid()),
            fire_department_sub_unit_id
        )
    );