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
        (NEW.raw_user_meta_data->>'fire_department_id')::UUID,
        NEW.id,
        (NEW.raw_user_meta_data->>'role')::public.fire_department_user_role,
        (NEW.raw_user_meta_data->>'rank')::public.fire_department_rank,
        (NEW.raw_user_meta_data->>'name')::TEXT
    );
    RETURN NEW;
END;
$$;

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
        LIMIT 1
    );
END;
$$;

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
        LIMIT 1
    );
END;
$$;

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
        LIMIT 1
    );
END;
$$;