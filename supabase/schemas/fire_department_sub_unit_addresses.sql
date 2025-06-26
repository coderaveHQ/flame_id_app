/* 
 * Section: Table Definition for Fire Department Sub-Unit Addresses
 * Description: This script creates the 'fire_department_sub_unit_addresses' table to store address details
 * for fire department sub-units, linked to the fire_department_sub_units table. Row Level Security (RLS)
 * is enabled to enforce access control.
 */

/* 
 * Create the 'fire_department_sub_unit_addresses' table to store address information for fire department sub-units.
 * - 'id': A UUID primary key, automatically generated using gen_random_uuid() for uniqueness.
 * - 'fire_department_sub_unit_id': A UUID NOT NULL column referencing the fire_department_sub_units table,
 *   linking each address to a specific sub-unit.
 * - 'street': A NOT NULL TEXT column to store the street name of the address.
 * - 'postal_code': A NOT NULL TEXT column to store the postal code.
 * - 'city': A NOT NULL TEXT column to store the city name.
 * - 'pk_fire_department_sub_unit_addresses': A PRIMARY KEY constraint on 'id' to ensure uniqueness.
 * - 'fk_fire_department_sub_unit_addresses_fire_department_sub_unit': A FOREIGN KEY constraint linking to
 *   fire_department_sub_units(id), enforcing referential integrity.
 */
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

/* 
 * Enable Row Level Security (RLS) on the 'fire_department_sub_unit_addresses' table.
 * RLS allows fine-grained access control based on policies, ensuring that only authorized users
 * (based on their role, sub-unit association, and auth.uid()) can view or modify address data.
 * Policies must be defined separately to specify the access rules.
 */
ALTER TABLE public.fire_department_sub_unit_addresses
    ENABLE ROW LEVEL SECURITY;