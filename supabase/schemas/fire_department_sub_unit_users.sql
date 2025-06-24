CREATE TYPE public.fire_department_sub_unit_user_role AS ENUM (
    'admin',
    'representative_admin',
    'user'
);

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

ALTER TABLE public.fire_department_sub_unit_users
    ENABLE ROW LEVEL SECURITY;