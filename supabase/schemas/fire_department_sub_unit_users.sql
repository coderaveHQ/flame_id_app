/* 
 * Section: Enum and Table Definitions for Fire Department Sub-Unit Users
 * Description: This script defines an ENUM type for roles within fire department sub-units
 * and creates the 'fire_department_sub_unit_users' table to link users to sub-units with specific roles.
 * Row Level Security (RLS) is enabled to enforce access control.
 */

/* 
 * Create an ENUM type to define possible roles a user can have within a fire department sub-unit.
 * The ENUM ensures that only 'admin', 'representative_admin', or 'user' values can be assigned to the 'role' column.
 * - 'admin': User with full administrative privileges within the sub-unit.
 * - 'representative_admin': User with partial administrative privileges, representing the sub-unit.
 * - 'user': Standard user with limited access.
 */
CREATE TYPE public.fire_department_sub_unit_user_role AS ENUM (
    'admin',
    'representative_admin',
    'user'
);

/* 
 * Create the 'fire_department_sub_unit_users' table to associate users with their roles in specific sub-units.
 * - 'fire_department_sub_unit_id': A UUID NOT NULL column referencing the fire_department_sub_units table, part of the composite primary key.
 * - 'user_id': A UUID NOT NULL column referencing the auth.users table, part of the composite primary key.
 * - 'role': A NOT NULL column using the fire_department_sub_unit_user_role ENUM to define the user's role within the sub-unit.
 * - 'pk_fire_department_sub_unit_users': A composite PRIMARY KEY constraint on (fire_department_sub_unit_id, user_id) to ensure uniqueness per sub-unit and user.
 * - 'fk_fire_department_sub_unit_users_fire_department_sub_unit': A FOREIGN KEY constraint linking to fire_department_sub_units(id).
 * - 'fk_fire_department_sub_unit_users_user': A FOREIGN KEY constraint linking to auth.users(id).
 */
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

/* 
 * Enable Row Level Security (RLS) on the 'fire_department_sub_unit_users' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role, sub-unit association, and auth.uid()) can view or modify user-sub-unit relationships.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_department_sub_unit_users
    ENABLE ROW LEVEL SECURITY;