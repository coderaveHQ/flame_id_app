/* 
 * Section: Seed Data Script
 * Description: This script populates the fire_departments and auth.users tables with initial data,
 * including fire department entries and user accounts with associated metadata. It uses a DO block
 * with a FOREACH loop to insert multiple users and their identities into the authentication system.
 * The script assumes the schema (tables, types, and triggers) is already created.
 */

/* 
 * Insert initial fire department data into the fire_departments table.
 * - 'id': Predefined UUIDs for each fire department.
 * - 'name': Human-readable names of the fire departments.
 * - 'type': ENUM values from fire_department_type to categorize the departments.
 * This provides a starting set of fire departments for the application.
 */
INSERT INTO fire_departments (id, name, type) VALUES 
    ('6ba7b810-9dad-11d1-80b4-00c04fd430c8', 'Freiwillige Feuerwehr Solingen', 'freiwillige_feuerwehr'),
    ('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'Berufsfeuerwehr Solingen', 'berufsfeuerwehr'),
    ('123e4567-e89b-12d3-a456-426614174000', 'Pflichtfeuerwehr Solingen', 'pflichtfeuerwehr');

/* 
 * DO Block: Automates the creation of multiple user accounts and their identities.
 * Purpose: Uses a PL/pgSQL block with a FOREACH loop to insert users into auth.users and
 *          auth.identities tables, leveraging JSONB arrays for batch processing.
 * Note: Assumes the handle_new_user trigger will populate fire_department_users automatically.
 */
DO $$
DECLARE
    /* 
     * Declare variables for the loop.
     * - user_data (jsonb): Holds the current user's JSON data during each iteration.
     * - user_list (jsonb[]): An array of JSON objects, each representing a user with id, email,
     *                        password, name, rank, role, and fire_department_id.
     */
    user_data jsonb;
    user_list jsonb[] := ARRAY[
        '{"id": "a3bb189e-7c1d-4b2e-9f6b-1234567890ab", "email": "fleeser@coderave.dev", "password": "password", "name": "Florian Leeser", "rank": "feuerwehrmann_anwaerter", "role": "admin", "fire_department_id": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"}',
        '{"id": "f5c2e9a1-8d4f-4c7a-b3e2-9876543210ba", "email": "sroepges@coderave.dev", "password": "password", "name": "Stefan Röpges", "rank": "feuerwehrmann", "role": "admin", "fire_department_id": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"}',
        '{"id": "7d9a1c3b-2e5f-4968-a1d4-abcdef123456", "email": "dgross@coderave.dev", "password": "password", "name": "Damian Groß", "rank": "oberfeuerwehrmann", "role": "user", "fire_department_id": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"}',
        '{"id": "e6b4f2c8-9a3d-4e1b-8c5a-456789abcdef", "email": "gsalanitro@coderave.dev", "password": "password", "name": "Giuseppe Salanitro", "rank": "hauptfeuerwehrmann", "role": "user", "fire_department_id": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"}',
        '{"id": "b1d8e7a4-3c6f-4a2e-9b7d-fedcba987654", "email": "sschneider@coderave.dev", "password": "password", "name": "Sebastian Schneider", "rank": "loeschmeister", "role": "user", "fire_department_id": "6ba7b810-9dad-11d1-80b4-00c04fd430c8"}',

        '{"id": "c9f3a2e5-1b8d-4f6c-a4e3-3216549870ab", "email": "dleeser@coderave.dev", "password": "password", "name": "Dennis Leeser", "rank": "unterbrandmeister", "role": "admin", "fire_department_id": "f47ac10b-58cc-4372-a567-0e02b2c3d479"}',
        '{"id": "4a7b9e2d-6c3f-4d1a-8e5b-7890abcdef12", "email": "rleeser@coderave.dev", "password": "password", "name": "Robin Leeser", "rank": "brandmeister_anwaerter", "role": "user", "fire_department_id": "f47ac10b-58cc-4372-a567-0e02b2c3d479"}',
        '{"id": "d2e6f1c9-5a4b-4e8d-9c3a-4561237890ba", "email": "cschneider@coderave.dev", "password": "password", "name": "Chantal Schneider", "rank": "brandmeister", "role": "user", "fire_department_id": "f47ac10b-58cc-4372-a567-0e02b2c3d479"}',
        '{"id": "8b3c7a1e-2f9d-4b6c-a5e4-abcdef456789", "email": "dschloesser@coderave.dev", "password": "password", "name": "David Schlößer", "rank": "oberbrandmeister", "role": "user", "fire_department_id": "f47ac10b-58cc-4372-a567-0e02b2c3d479"}',
        '{"id": "f9a4e3b7-1c8f-4a2e-9d6b-9873216540ab", "email": "ldiekmann@coderave.dev", "password": "password", "name": "Leonie Diekmann", "rank": "hauptbrandmeister", "role": "user", "fire_department_id": "f47ac10b-58cc-4372-a567-0e02b2c3d479"}',

        '{"id": "6c2b8e5a-3d7f-4e9c-a1d4-123789abcdef", "email": "mgoetz@coderave.dev", "password": "password", "name": "Marius Götz", "rank": "hauptbrandmeister_mit_zulage", "role": "admin", "fire_department_id": "123e4567-e89b-12d3-a456-426614174000"}',
        '{"id": "e1d9f4c3-5a2b-4f8e-9c7a-fedcba123456", "email": "jdietz@coderave.dev", "password": "password", "name": "Jan Dietz", "rank": "gruppenfuehrer", "role": "user", "fire_department_id": "123e4567-e89b-12d3-a456-426614174000"}',
        '{"id": "a7e3b9f2-4c1d-4a6e-8b5d-3214567890ab", "email": "nkusenberg@coderave.dev", "password": "password", "name": "Nick Kusenberg", "rank": "zugfuehrer", "role": "user", "fire_department_id": "123e4567-e89b-12d3-a456-426614174000"}',
        '{"id": "b4f1c8e6-9a3d-4e2b-9c7a-456789123abc", "email": "pbarz@coderave.dev", "password": "password", "name": "Patrick Barz", "rank": "kreisbrandmeister", "role": "user", "fire_department_id": "123e4567-e89b-12d3-a456-426614174000"}',
        '{"id": "d8a2e7b1-6c4f-4b9e-a3d5-abcdef789012", "email": "ddiekmann@coderave.dev", "password": "password", "name": "Dirk Diekmann", "rank": "kreisbrandrat", "role": "user", "fire_department_id": "123e4567-e89b-12d3-a456-426614174000"}'
    ];
BEGIN
    /* 
     * Loop through each user in the user_list array to insert them into the auth.users and auth.identities tables.
     * The FOREACH loop iterates over the JSONB array, processing one user at a time.
     */
    FOREACH user_data IN ARRAY user_list
    LOOP
        /* 
         * Insert a new user into the auth.users table with predefined and dynamically generated data.
         * - 'instance_id': A default UUID for the Supabase instance (placeholder).
         * - 'id': User ID from the JSON data, cast to UUID.
         * - 'aud': Audience, set to 'authenticated' as the default role.
         * - 'role': Set to 'authenticated' to match Supabase conventions.
         * - 'email': User email from the JSON data.
         * - 'encrypted_password': Password hashed using crypt with Blowfish (bf) salt for security.
         * - 'email_confirmed_at', 'recovery_sent_at', 'last_sign_in_at': Set to current timestamp for initial setup.
         * - 'raw_app_meta_data': JSONB with provider information.
         * - 'raw_user_meta_data': JSONB with user-specific metadata (name, rank, role, fire_department_id).
         * - 'created_at', 'updated_at': Set to current timestamp.
         * - Other fields (e.g., tokens) are initialized as empty strings.
         */
        INSERT INTO auth.users (
            instance_id,
            id,
            aud,
            role,
            email,
            encrypted_password,
            email_confirmed_at,
            recovery_sent_at,
            last_sign_in_at,
            raw_app_meta_data,
            raw_user_meta_data,
            created_at,
            updated_at,
            confirmation_token,
            email_change,
            email_change_token_new,
            recovery_token
        )
        VALUES (
            '00000000-0000-0000-0000-000000000000',
            (user_data->>'id')::UUID,
            'authenticated',
            'authenticated',
            user_data->>'email',
            crypt(user_data->>'password', gen_salt('bf')),
            current_timestamp,
            current_timestamp,
            current_timestamp,
            '{"provider":"email","providers":["email"]}',
            json_build_object(
                'name', user_data->>'name',
                'rank', user_data->>'rank',
                'role', user_data->>'role',
                'fire_department_id', user_data->>'fire_department_id'
            ),
            current_timestamp,
            current_timestamp,
            '',
            '',
            '',
            ''
        );

        /* 
         * Insert a corresponding identity record into the auth.identities table for each user.
         * - 'id': A new UUID generated using uuid_generate_v4().
         * - 'user_id': Matches the id from auth.users.
         * - 'provider_id': Matches the user_id for simplicity (could be adjusted).
         * - 'identity_data': JSONB with sub and email, formatted from user data.
         * - 'provider': Set to 'email' as the authentication provider.
         * - 'last_sign_in_at', 'created_at', 'updated_at': Set to current timestamp.
         * Note: This ensures each user has an identity record for email-based authentication.
         */
        INSERT INTO auth.identities (
            id,
            user_id,
            provider_id,
            identity_data,
            provider,
            last_sign_in_at,
            created_at,
            updated_at
        )
        SELECT
            uuid_generate_v4(),
            id,
            id,
            format('{"sub":"%s","email":"%s"}', id::text, email)::jsonb,
            'email',
            current_timestamp,
            current_timestamp,
            current_timestamp
        FROM auth.users
        WHERE email = user_data->>'email';
    END LOOP;
END $$;