CREATE TYPE public.fire_department_type AS ENUM (
    'freiwillige_feuerwehr',
    'berufsfeuerwehr',
    'pflichtfeuerwehr',
    'other'
);

CREATE TABLE public.fire_departments (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    type public.fire_department_type NOT NULL,
    name TEXT NOT NULL,
    CONSTRAINT pk_fire_departments PRIMARY KEY (id)
);

ALTER TABLE public.fire_departments
    ENABLE ROW LEVEL SECURITY;