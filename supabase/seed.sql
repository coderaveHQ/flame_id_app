DO $$
DECLARE
    user_data jsonb;
    user_list jsonb[] := ARRAY[
        '{"id": "f95c9e45-0b17-4e85-88db-e150ab486634", "email": "fleeser@coderave.dev", "password": "password", "name": "Florian Leeser", "role": "admin", "rank": "feuerwehrmann_anwaerter"}',
        '{"id": "e9eb6a38-47fc-4fbc-99f8-400fe90aaad3", "email": "aleickel@coderave.de", "password": "password", "name": "André Leickel", "role": "admin", "rank": "feuerwehrmann"}',
        '{"id": "05f9ef7e-23d8-4a4e-975e-3127f530572b", "email": "bduerholt@coderave.de", "password": "password", "name": "Benjamin Dürholt", "role": "admin", "rank": "brandmeister"}',

        '{"id": "660a1048-285a-496b-ac51-399099234feb", "email": "nkusenberg@coderave.de", "password": "password", "name": "Nick Kusenberg", "role": "supervisor", "rank": "feuerwehrmann"}',
        '{"id": "3467b6a6-3304-4ddc-8134-850f3cdc5abf", "email": "dbarth@coderave.de", "password": "password", "name": "Damian Barth", "role": "supervisor", "rank": "feuerwehrmann"}',
        '{"id": "934e59e6-1464-4165-876a-afaea4137745", "email": "erukundo@coderave.de", "password": "password", "name": "Emmanuel Rukundo", "role": "supervisor", "rank": "brandamtmann"}',
        '{"id": "41bfd91a-a0fe-418c-a8f7-d3f3721f27f5", "email": "cschmidt@coderave.de", "password": "password", "name": "Christoph Schmidt", "role": "supervisor", "rank": "brandamtmann"}',
        '{"id": "14772654-d3be-4ea5-aa2b-bd4a4e9b8ce5", "email": "hliebermann@coderave.de", "password": "password", "name": "Holger Liebermann", "role": "supervisor", "rank": "ltd_branddirektor"}',
        '{"id": "73dbf896-0219-472a-9e77-44c3162b45c7", "email": "fsteinert@coderave.de", "password": "password", "name": "Frank Steinert", "role": "supervisor", "rank": "direktor_berufsfeuerwehr"}',

        '{"id": "5f8d2bfa-9181-45c2-a17c-871340592bf8", "email": "amueller@coderave.de", "password": "password", "name": "Anna Müller", "role": "normal", "rank": "brandamtmann"}',
        '{"id": "2389d6d7-5805-48a4-921d-9a7b4324f2d3", "email": "bschneider@coderave.de", "password": "password", "name": "Bernd Schneider", "role": "normal", "rank": "feuerwehrmann"}',
        '{"id": "7d9faed1-67ac-4f55-ae56-3d2f6a5267cb", "email": "cfischer@coderave.de", "password": "password", "name": "Clara Fischer", "role": "normal", "rank": "hauptbrandmeister_z"}',
        '{"id": "682a9ed7-9dda-49c8-b819-51c3ba2a5b98", "email": "dwagner@tescoderavet.de", "password": "password", "name": "David Wagner", "role": "normal", "rank": "brandoberinspektor"}',
        '{"id": "9369d970-10a8-4e56-95e7-358d6781ce38", "email": "ebraun@coderave.de", "password": "password", "name": "Emma Braun", "role": "normal", "rank": "direktor_berufsfeuerwehr"}',
        '{"id": "864b71fc-0621-4773-9825-b1b4c8bf108c", "email": "fkeller@coderave.de", "password": "password", "name": "Felix Keller", "role": "normal", "rank": "feuerwehrmann"}',
        '{"id": "c7027f1f-4ea3-46fd-abe7-262ea609a606", "email": "gweber@coderave.de", "password": "password", "name": "Gina Weber", "role": "normal", "rank": "brandoberinspektor"}',
        '{"id": "7216a0fa-292c-4546-b734-aefb66596cd3", "email": "hmayer@coderave.de", "password": "password", "name": "Hannah Mayer", "role": "normal", "rank": "brandamtmann"}',
        '{"id": "65c13094-9175-4026-820e-774542cc5b47", "email": "ilehmann@coderave.de", "password": "password", "name": "Igor Lehmann", "role": "normal", "rank": "feuerwehrmann"}'
    ];
BEGIN
    FOREACH user_data IN ARRAY user_list
    LOOP
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
                'role', user_data->>'role',
                'rank', user_data->>'rank'
            ),
            current_timestamp,
            current_timestamp,
            '',
            '',
            '',
            ''
        );

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

DO $$
DECLARE
    vault_entry_data jsonb;
    vault_entry_list jsonb[] := ARRAY[
        '{"id": "120df762-9db5-493d-8f8b-c690edad6d56", "title": "Google", "uri": "https://google.com"}',
        '{"id": "cf271202-2f68-49d8-b89c-847ed0b923f3", "title": "Facebook", "uri": "https://facebook.com"}',
        '{"id": "08c25d60-5a0d-48be-9f85-b731be354dda", "title": "Instagram", "uri": "https://instagram.com"}',
        '{"id": "ddb56f8b-7076-4203-ae1f-fc6ca084abeb", "title": "YouTube", "uri": "https://youtube.com"}',
        '{"id": "32f5c956-4b50-440c-9467-decc85045271", "title": "Apple", "uri": "https://apple.com"}',
        '{"id": "9c17db31-f38e-4698-bf08-05a0cc6be6be", "title": "Samsung", "uri": "https://samsung.com"}'
    ];
BEGIN
    FOREACH vault_entry_data IN ARRAY vault_entry_list
    LOOP
        INSERT INTO public.vault_entries (
            id,
            title,
            uri
        )
        VALUES (
            (vault_entry_data->>'id')::UUID,
            (vault_entry_data->>'title')::TEXT,
            (vault_entry_data->>'uri')::TEXT
        );
    END LOOP;
END $$;

DO $$
DECLARE
    vault_content_data jsonb;
    vault_content_list jsonb[] := ARRAY[
        '{"vault_entry_id": "cf271202-2f68-49d8-b89c-847ed0b923f3", "user_id": "f95c9e45-0b17-4e85-88db-e150ab486634", "email": "fleeser@coderave.dev", "password": "password123"}',
        '{"vault_entry_id": "08c25d60-5a0d-48be-9f85-b731be354dda", "user_id": "f95c9e45-0b17-4e85-88db-e150ab486634", "email": "fleeser@coderave.dev", "password": "123password"}',
        '{"vault_entry_id": "ddb56f8b-7076-4203-ae1f-fc6ca084abeb", "user_id": "f95c9e45-0b17-4e85-88db-e150ab486634", "email": "fleeser@coderave.dev", "password": "!p!assword123"}',
        '{"vault_entry_id": "9c17db31-f38e-4698-bf08-05a0cc6be6be", "user_id": "f95c9e45-0b17-4e85-88db-e150ab486634", "email": "fleeser@coderave.dev", "password": "pass?word1?2?3"}'
    ];
BEGIN
    FOREACH vault_content_data IN ARRAY vault_content_list
    LOOP
        INSERT INTO public.vault_contents (
            vault_entry_id,
            user_id,
            email,
            password
        )
        VALUES (
            (vault_content_data->>'vault_entry_id')::UUID,
            (vault_content_data->>'user_id')::UUID,
            (vault_content_data->>'email')::TEXT,
            (vault_content_data->>'password')::TEXT
        );
    END LOOP;
END $$;