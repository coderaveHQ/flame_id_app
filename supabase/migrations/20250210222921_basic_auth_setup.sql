CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TYPE public.user_role AS ENUM (
    'admin', 
    'supervisor',
    'normal'
);

CREATE TYPE public.user_rank AS ENUM (
    'feuerwehrmann_anwaerter',
    'feuerwehrmann',
    'oberfeuerwehrmann',
    'unterbrandmeister',
    'brandmeister',
    'oberbrandmeister',
    'hauptbrandmeister',
    'brandinspektor',
    'brandoberinspektor',
    'stadtbrandinspektor',
    'brandmeister_anwaerter',
    'hauptbrandmeister_z',
    'brandamtmann',
    'brandamtsrat',
    'brandoberamtsrat',
    'brandreferendar',
    'brandrat',
    'oberbrandrat',
    'branddirektor',
    'ltd_branddirektor',
    'direktor_berufsfeuerwehr'
);

CREATE TABLE public.user_roles (
    user_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    role public.user_role NOT NULL,
    CONSTRAINT user_roles_pkey PRIMARY KEY (user_id),
    CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users (id) ON UPDATE CASCADE ON DELETE CASCADE
);
COMMENT ON TABLE public.user_roles IS 'The users role.';

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_roles_select" 
ON "public"."user_roles"
AS permissive
FOR SELECT 
TO supabase_auth_admin 
USING (true);

CREATE TRIGGER update_user_roles_updated_at_trigger
AFTER UPDATE ON public.user_roles
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TABLE public.profiles (
    user_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    rank public.user_rank,
    name TEXT NOT NULL,
    CONSTRAINT profiles_pkey PRIMARY KEY (user_id),
    CONSTRAINT profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users (id) ON UPDATE CASCADE ON DELETE CASCADE
) TABLESPACE pg_default;

COMMENT ON TABLE public.profiles IS 'The users profiles.';

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE TRIGGER update_profiles_updated_at_trigger
AFTER UPDATE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE FUNCTION public.create_profile()
RETURNS TRIGGER 
LANGUAGE plpgsql 
SECURITY DEFINER
SET search_path = public AS $$
BEGIN
    INSERT INTO public.user_roles (
        user_id, 
        role
    )
    VALUES (
        NEW.id, 
        (NEW.raw_user_meta_data->>'role')::public.user_role
    );

    INSERT INTO public.profiles (
        user_id, 
        rank,
        name
    )
    VALUES (
        NEW.id, 
        (NEW.raw_user_meta_data->>'rank')::public.user_rank,
        NEW.raw_user_meta_data->>'name'
    );
    RETURN NEW;
END;
$$;

CREATE TRIGGER create_profile_for_new_user
AFTER INSERT 
ON auth.users 
FOR EACH ROW 
EXECUTE PROCEDURE public.create_profile();

CREATE OR REPLACE FUNCTION public.custom_access_token_hook(event JSONB)
RETURNS JSONB
LANGUAGE plpgsql
STABLE
AS $$
  DECLARE
    claims JSONB;
    user_role public.user_role;
  BEGIN
    SELECT role INTO user_role FROM public.user_roles WHERE user_id = (event->>'user_id')::UUID;
    claims := event->'claims';
    claims := jsonb_set(claims, '{user_role}', to_jsonb(user_role));
    event := jsonb_set(event, '{claims}', claims);
    RETURN event;
  end;
$$;

GRANT USAGE ON SCHEMA public TO supabase_auth_admin;

GRANT EXECUTE
ON FUNCTION public.custom_access_token_hook
TO supabase_auth_admin;

REVOKE EXECUTE
ON FUNCTION public.custom_access_token_hook
FROM authenticated, anon, public;

GRANT ALL
ON TABLE public.user_roles
TO supabase_auth_admin;

REVOKE ALL 
ON TABLE public.user_roles
FROM authenticated, anon, public;