/* 
 * Section: Trigger Definition for New User Creation
 * Description: This script creates a trigger that executes the 'handle_new_user' function
 * after a new user is inserted into the auth.users table, ensuring automatic population
 * of the fire_department_users table with user metadata.
 */

/* 
 * Create a trigger named 'on_auth_user_created' to handle new user creation in the auth.users table.
 * - 'AFTER INSERT': The trigger fires after a new row is inserted into auth.users.
 * - 'FOR EACH ROW': The trigger executes for each inserted row individually.
 * - 'EXECUTE FUNCTION public.handle_new_user()': Calls the handle_new_user function to process
 *   the new user data, typically to insert a corresponding entry into fire_department_users
 *   using metadata from the auth.users table.
 * Note: This trigger relies on the handle_new_user function being defined and assumes
 *       raw_user_meta_data contains the required fields (fire_department_id, role, rank, name).
 */
CREATE OR REPLACE TRIGGER on_auth_user_created
    AFTER INSERT
    ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();