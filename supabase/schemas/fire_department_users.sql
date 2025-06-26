/* 
 * Section: Enum and Table Definitions for Fire Department Users
 * Description: This script defines ENUM types for user roles and ranks within a fire department,
 * and creates the 'fire_department_users' table to link users to their departments with roles and ranks.
 * Row Level Security (RLS) is enabled to enforce access control.
 */

/* 
 * Create an ENUM type to define possible roles a user can have within a fire department.
 * The ENUM ensures that only 'admin' or 'user' values can be assigned to the 'role' column.
 * - 'admin': User with administrative privileges.
 * - 'user': Standard user with limited access.
 */
CREATE TYPE public.fire_department_user_role AS ENUM (
    'admin',
    'user'
);

/* 
 * Create an ENUM type to define the hierarchical ranks within a fire department.
 * The ENUM provides a comprehensive list of ranks, from trainee to director levels, including
 * 'other' and 'none' for flexibility. This ensures data consistency in the 'rank' column.
 */
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

/* 
 * Create the 'fire_department_users' table to associate users with their fire departments,
 * including their role, rank, and name.
 * - 'fire_department_id': A UUID NOT NULL column referencing the fire_departments table, part of the composite primary key.
 * - 'user_id': A UUID NOT NULL column referencing the auth.users table, part of the composite primary key.
 * - 'role': A NOT NULL column using the fire_department_user_role ENUM to define the user's role.
 * - 'rank': A NOT NULL column using the fire_department_rank ENUM to define the user's rank.
 * - 'name': A NOT NULL TEXT column to store the user's name.
 * - 'pk_fire_department_users': A composite PRIMARY KEY constraint on (fire_department_id, user_id) to ensure uniqueness.
 * - 'fk_fire_department_users_fire_department': A FOREIGN KEY constraint linking to fire_departments(id).
 * - 'fk_fire_department_users_user': A FOREIGN KEY constraint linking to auth.users(id).
 */
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

/* 
 * Enable Row Level Security (RLS) on the 'fire_department_users' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role and auth.uid()) can view or modify their own or administrable data.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_department_users
    ENABLE ROW LEVEL SECURITY;