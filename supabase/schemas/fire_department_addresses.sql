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

ALTER TABLE public.fire_department_addresses
    ENABLE ROW LEVEL SECURITY;