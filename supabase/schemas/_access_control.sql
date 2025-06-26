/* 
 * Section: Access Control Definitions
 * Description: This script defines the access control settings for the public schema, including
 * revoking default permissions, and ensuring Row Level Security (RLS) is the primary access control mechanism.
 * Permissions are tailored for service_role (for backend operations).
 */

/* 
 * Block: Revoke Default Permissions on Tables
 * Purpose: Remove all default permissions from anon, authenticated, and public roles on all tables
 * to enforce access control exclusively through RLS policies. This prevents unauthorized direct
 * access to table data.
 */
REVOKE ALL ON TABLE public.fire_department_addresses FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_department_sub_unit_addresses FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_department_sub_unit_users FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_department_sub_units FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_department_users FROM authenticated, anon, public;
REVOKE ALL ON TABLE public.fire_departments FROM authenticated, anon, public;

/* 
 * Block: Revoke Default Permissions on Functions
 * Purpose: Remove all default permissions from anon, authenticated, and public roles on all functions
 * to ensure that only authorized roles (e.g., supabase_auth_admin, service_role) can execute them.
 * This enhances security by limiting function access.
 */
REVOKE ALL ON FUNCTION public.check_fire_department_or_sub_unit_admin(uuid, uuid) FROM authenticated, anon, public;
REVOKE ALL ON FUNCTION public.get_fire_department_id_from_sub_unit(uuid) FROM authenticated, anon, public;
REVOKE ALL ON FUNCTION public.get_fire_department_sub_unit_user_role(uuid, uuid) FROM authenticated, anon, public;
REVOKE ALL ON FUNCTION public.get_fire_department_user_role(uuid, uuid) FROM authenticated, anon, public;
REVOKE ALL ON FUNCTION public.handle_new_user() FROM authenticated, anon, public;

/* 
 * Block: Grant Permissions for Service Role
 * Purpose: Grant full permissions to the service_role for all tables and functions to support
 * backend operations, triggers (e.g., handle_new_user), and other automated processes.
 */
GRANT ALL ON TABLE public.fire_department_users TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_departments TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_department_addresses TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_department_sub_unit_addresses TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_department_sub_unit_users TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_department_sub_units TO service_role; -- Full control for backend management
GRANT ALL ON TABLE public.fire_departments TO service_role; -- Full control for backend management (duplicate grant, ensure intent)

GRANT EXECUTE ON FUNCTION public.check_fire_department_or_sub_unit_admin(uuid, uuid) TO service_role; -- Allows execution for RLS checks
GRANT EXECUTE ON FUNCTION public.get_fire_department_id_from_sub_unit(uuid) TO service_role; -- Allows execution for sub-unit to department mapping
GRANT EXECUTE ON FUNCTION public.get_fire_department_sub_unit_user_role(uuid, uuid) TO service_role; -- Allows execution for sub-unit role retrieval
GRANT EXECUTE ON FUNCTION public.get_fire_department_user_role(uuid, uuid) TO service_role; -- Allows execution for department role retrieval
GRANT EXECUTE ON FUNCTION public.handle_new_user() TO service_role; -- Allows execution for new user trigger

/* 
 * Block: Final Revoke of All Permissions
 * Purpose: Perform a comprehensive revoke of all permissions on all tables and functions in the
 * public schema from anon, authenticated, and public roles to enforce RLS as the sole access control
 * mechanism. This is a safety net to ensure no residual permissions remain.
 */
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM anon; -- Revokes all table permissions from anon
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM authenticated; -- Revokes all table permissions from authenticated
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM public; -- Revokes all table permissions from public
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM anon; -- Revokes all function permissions from anon
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM authenticated; -- Revokes all function permissions from authenticated
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM public; -- Revokes all function permissions from public