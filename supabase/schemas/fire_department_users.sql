CREATE TYPE public.fire_department_user_role AS ENUM (
    'admin',
    'user'
);

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

ALTER TABLE public.fire_department_users
    ENABLE ROW LEVEL SECURITY;