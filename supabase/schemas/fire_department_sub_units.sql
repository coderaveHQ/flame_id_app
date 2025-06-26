/* 
 * Section: Enum and Table Definitions for Fire Department Sub-Units
 * Description: This script defines an ENUM type for different types of fire department sub-units
 * and creates the 'fire_department_sub_units' table to store sub-unit details, linked to fire departments.
 * Row Level Security (RLS) is enabled to enforce access control.
 */

/* 
 * Create an ENUM type to categorize the various types of sub-units within a fire department.
 * The ENUM ensures that only predefined values can be used for the 'type' column in the
 * fire_department_sub_units table. This includes operational units (e.g., 'loescheinheit'),
 * youth groups (e.g., 'jugendfeuerwehr'), and support units (e.g., 'versorgungszug').
 */
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

/* 
 * Create the 'fire_department_sub_units' table to store information about sub-units within fire departments.
 * - 'id': A UUID primary key, automatically generated using gen_random_uuid() for uniqueness.
 * - 'fire_department_id': A UUID NOT NULL column referencing the fire_departments table, linking sub-units to their parent department.
 * - 'type': A NOT NULL column using the fire_department_sub_unit_type ENUM to categorize the sub-unit.
 * - 'name': A NOT NULL TEXT column to store the name of the sub-unit.
 * - 'pk_fire_department_sub_units': A PRIMARY KEY constraint on 'id' to ensure uniqueness.
 * - 'fk_fire_department_sub_units_fire_department': A FOREIGN KEY constraint linking to fire_departments(id).
 */
CREATE TABLE public.fire_department_sub_units (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    fire_department_id UUID NOT NULL,
    type public.fire_department_sub_unit_type NOT NULL,
    name TEXT NOT NULL,
    CONSTRAINT pk_fire_department_sub_units PRIMARY KEY (id),
    CONSTRAINT fk_fire_department_sub_units_fire_department FOREIGN KEY (fire_department_id)
        REFERENCES public.fire_departments (id)
);

/* 
 * Enable Row Level Security (RLS) on the 'fire_department_sub_units' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role and association with the fire department) can view or modify sub-unit data.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_department_sub_units
    ENABLE ROW LEVEL SECURITY;