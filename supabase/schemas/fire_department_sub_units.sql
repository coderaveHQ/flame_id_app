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

CREATE TABLE public.fire_department_sub_units (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    fire_department_id UUID NOT NULL,
    type public.fire_department_sub_unit_type NOT NULL,
    name TEXT NOT NULL,
    CONSTRAINT pk_fire_department_sub_units PRIMARY KEY (id),
    CONSTRAINT fk_fire_department_sub_units_fire_department FOREIGN KEY (fire_department_id)
        REFERENCES public.fire_departments (id)
);

ALTER TABLE public.fire_department_sub_units
    ENABLE ROW LEVEL SECURITY;