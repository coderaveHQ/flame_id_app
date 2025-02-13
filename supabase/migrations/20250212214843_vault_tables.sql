CREATE TABLE public.vault_entries (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    title TEXT NOT NULL,
    uri TEXT NOT NULL,
    CONSTRAINT vault_entries_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE public.vault_entries IS 'The vaults entries.';

ALTER TABLE public.vault_entries ENABLE ROW LEVEL SECURITY;

CREATE POLICY "vault_entries_select" 
ON "public"."vault_entries"
FOR SELECT 
TO authenticated 
USING (true);

CREATE POLICY "vault_entries_update" 
ON "public"."vault_entries"
FOR UPDATE 
TO authenticated
USING (
    (
        SELECT ur.role 
        FROM public.user_roles ur 
        WHERE ur.user_id = auth.uid()
    ) = 'admin'::public.user_role
);

CREATE POLICY "vault_entries_delete" 
ON "public"."vault_entries"
FOR DELETE 
TO authenticated
USING (
    (
        SELECT ur.role 
        FROM public.user_roles ur 
        WHERE ur.user_id = auth.uid()
    ) = 'admin'::public.user_role
);

CREATE POLICY "vault_entries_insert" 
ON "public"."vault_entries"
FOR INSERT 
TO authenticated
WITH CHECK (
    (
        SELECT ur.role 
        FROM public.user_roles ur 
        WHERE ur.user_id = auth.uid()
    ) = 'admin'::public.user_role
);

CREATE TRIGGER update_vault_entries_updated_at_trigger
AFTER UPDATE ON public.vault_entries
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TABLE public.vault_contents(
    vault_entry_id UUID NOT NULL,
    user_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    CONSTRAINT vault_contents_pkey PRIMARY KEY (vault_entry_id, user_id),
    CONSTRAINT vault_contents_vault_entry_id_fkey FOREIGN KEY (vault_entry_id) REFERENCES public.vault_entries (id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vault_contents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users (id) ON UPDATE CASCADE ON DELETE CASCADE
);
COMMENT ON TABLE public.vault_entries IS 'The vaults contents per user.';

ALTER TABLE public.vault_contents ENABLE ROW LEVEL SECURITY;

CREATE POLICY "vault_contents_select" 
ON "public"."vault_contents"
FOR SELECT 
TO authenticated 
USING (
    (
        (
            SELECT ur.role 
            FROM public.user_roles ur 
            WHERE ur.user_id = auth.uid()
        ) IN ('admin'::public.user_role, 'supervisor'::public.user_role)
    ) OR user_id = auth.uid()
);

CREATE POLICY "vault_contents_update" 
ON "public"."vault_contents"
FOR UPDATE 
TO authenticated
USING (
    (
        (
            SELECT ur.role 
            FROM public.user_roles ur 
            WHERE ur.user_id = auth.uid()
        ) IN ('admin'::public.user_role, 'supervisor'::public.user_role)
    ) OR user_id = auth.uid()
);

CREATE POLICY "vault_contents_delete" 
ON "public"."vault_contents"
FOR DELETE 
TO authenticated
USING (
    (
        (
            SELECT ur.role 
            FROM public.user_roles ur 
            WHERE ur.user_id = auth.uid()
        ) IN ('admin'::public.user_role, 'supervisor'::public.user_role)
    ) OR user_id = auth.uid()
);

CREATE POLICY "vault_contents_insert" 
ON "public"."vault_contents"
FOR INSERT 
TO authenticated
WITH CHECK (
    (
        (
            SELECT ur.role 
            FROM public.user_roles ur 
            WHERE ur.user_id = auth.uid()
        ) IN ('admin'::public.user_role, 'supervisor'::public.user_role)
    ) OR user_id = auth.uid()
);

CREATE TRIGGER update_vault_contents_updated_at_trigger
AFTER UPDATE ON public.vault_contents
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();