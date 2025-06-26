/* 
 * Section: Enum and Table Definitions for Fire Departments
 * Description: This script defines an ENUM type for fire department categories and creates the 'fire_departments' table
 * to store information about fire departments. Row Level Security (RLS) is enabled to control access.
 */

/* 
 * Create an ENUM type to categorize different types of fire departments.
 * The ENUM ensures that only predefined values can be used for the 'type' column in the fire_departments table.
 * Values include 'freiwillige_feuerwehr' (voluntary fire department), 'berufsfeuerwehr' (professional fire department),
 * 'pflichtfeuerwehr' (mandatory fire department), and 'other' for unspecified types.
 */
CREATE TYPE public.fire_department_type AS ENUM (
    'freiwillige_feuerwehr',
    'berufsfeuerwehr',
    'pflichtfeuerwehr',
    'other'
);

/* 
 * Create the 'fire_departments' table to store details of fire departments.
 * - 'id': A UUID primary key, automatically generated using gen_random_uuid() for uniqueness.
 * - 'type': A NOT NULL column referencing the fire_department_type ENUM to categorize the department.
 * - 'name': A NOT NULL TEXT column to store the name of the fire department.
 * - PRIMARY KEY constraint ensures 'id' is unique and serves as the table's primary key.
 */
CREATE TABLE public.fire_departments (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    type public.fire_department_type NOT NULL,
    name TEXT NOT NULL,
    CONSTRAINT pk_fire_departments PRIMARY KEY (id)
);

/* 
 * Enable Row Level Security (RLS) on the 'fire_departments' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * can view or modify data according to their roles and authentication status.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_departments
    ENABLE ROW LEVEL SECURITY;