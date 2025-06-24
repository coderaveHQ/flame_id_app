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

ALTER TABLE public.fire_department_sub_unit_addresses
    ENABLE ROW LEVEL SECURITY;