import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.50.0';
import type { SupabaseClient } from 'https://esm.sh/@supabase/supabase-js@2.50.0';

// Define interface for the sub-unit object in the array
interface SubUnit {
  fire_department_sub_unit_id: string;
  role: string;
}

// Define interface for the initial_data object in the request body
interface InitialData {
  role: string;
  rank: string;
  name: string;
  sub_units?: SubUnit[]; // Optional: Array of sub-units
}

// Define interface for the request body to make types explicit
interface InviteRequestBody {
  email: string;
  redirect_to: string;
  initial_data: InitialData;
}

// Define interface for the fire department user role data from Supabase
interface FireDepartmentUserRole {
  role: string;
}

// Define interface for the fire department sub-unit user role data from Supabase
interface FireDepartmentSubUnitUserRole {
  role: string;
}

// Define interface for the fire department sub-unit data (to check parent department)
interface FireDepartmentSubUnit {
  fire_department_id: string;
}

// Define interface for fetching the user's fire department ID
interface FireDepartmentUser {
  fire_department_id: string;
}

// Edge Function to send a user invitation via Supabase Admin API
// This function allows an admin of a fire department to invite a new user by email.
// The invitation includes user metadata required for the handle_new_user trigger.
// Only authenticated admins of the specified fire_department_id can invoke this, with restrictions:
// - If the caller is a fire department admin, they can invite anyone with any roles and sub-units.
// - If the caller is only a sub-unit admin (not fire department admin), they can only invite to sub-units they are part of,
//   the main role must be 'user', and sub_units must be provided.

Deno.serve(async (req: Request): Promise<Response> => {
  if (req.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), { status: 405 });
  }

  const supabaseUrl: string | undefined = Deno.env.get('SUPABASE_URL');
  const supabaseServiceKey: string | undefined = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');

  if (!supabaseUrl || !supabaseServiceKey) {
    return new Response(JSON.stringify({ error: 'Missing environment variables' }), { status: 500 });
  }

  const adminClient: SupabaseClient = createClient(supabaseUrl, supabaseServiceKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });

  // Extract JWT from Authorization header
  const authHeader: string | null = req.headers.get('Authorization');
  if (!authHeader) {
    return new Response(JSON.stringify({ error: 'No authorization header' }), { status: 401 });
  }

  const jwt: string = authHeader.replace('Bearer ', '');
  const { data: { user }, error: userError } = await adminClient.auth.getUser(jwt);

  if (userError || !user) {
    return new Response(JSON.stringify({ error: 'Invalid or expired token' }), { status: 401 });
  }

  const userId: string = user.id;

  // Fetch the caller's fire_department_id from fire_department_users
  const { data: userFireDepartmentData, error: fireDepartmentError } = await adminClient
    .from('fire_department_users')
    .select('fire_department_id')
    .eq('user_id', userId)
    .single<FireDepartmentUser>();

  if (fireDepartmentError || !userFireDepartmentData) {
    return new Response(JSON.stringify({ error: 'Unable to determine your fire department ID' }), { status: 403 });
  }

  const fire_department_id: string = userFireDepartmentData.fire_department_id;

  // Parse request body
  let body: InviteRequestBody;
  try {
    body = await req.json() as InviteRequestBody;
  } catch (_e: unknown) {
    return new Response(JSON.stringify({ error: 'Invalid JSON body' }), { status: 400 });
  }

  const { email, redirect_to, initial_data } = body;

  if (!email || !redirect_to || !initial_data) {
    return new Response(JSON.stringify({ error: 'Missing required fields: email, redirect_to, initial_data' }), { status: 400 });
  }

  const { role, rank, name, sub_units = [] }: InitialData = initial_data;

  if (!role || !rank || !name) {
    return new Response(JSON.stringify({ error: 'Missing required fields in initial_data: role, rank, name' }), { status: 400 });
  }

  // Validate role and rank against ENUMs (basic string check; full validation can be done in DB)
  const validRoles: string[] = ['admin', 'representative_admin', 'user'];
  const validRanks: string[] = [
    'feuerwehrmann_anwaerter', 'feuerwehrmann', 'oberfeuerwehrmann', 'hauptfeuerwehrmann',
    'loeschmeister', 'oberloeschmeister', 'hauptloeschmeister', 'unterbrandmeister',
    'brandmeister_anwaerter', 'brandmeister', 'oberbrandmeister', 'hauptbrandmeister',
    'hauptbrandmeister_mit_zulage', 'gruppenfuehrer', 'zugfuehrer', 'kreisbrandmeister',
    'kreisbrandrat', 'kreisbranddirektor', 'brandinspektor', 'brandoberinspektor',
    'stadtbrandinspektor', 'brandamtmann', 'brandamtsrat', 'brandoberamtsrat',
    'brandreferendar', 'brandrat', 'oberbrandrat', 'branddirektor', 'leitender_branddirektor',
    'direktor_berufsfeuerwehr', 'other', 'none'
  ];

  if (!validRoles.includes(role)) {
    return new Response(JSON.stringify({ error: 'Invalid role in initial_data' }), { status: 400 });
  }

  if (!validRanks.includes(rank)) {
    return new Response(JSON.stringify({ error: 'Invalid rank in initial_data' }), { status: 400 });
  }

  // Validate sub_units roles (if present)
  const validSubUnitRoles: string[] = ['admin', 'representative_admin', 'user'];
  for (const subUnit of sub_units) {
    if (!subUnit.fire_department_sub_unit_id || !subUnit.role || !validSubUnitRoles.includes(subUnit.role)) {
      return new Response(JSON.stringify({ error: 'Invalid fire_department_sub_unit_id or role in sub_units array' }), { status: 400 });
    }
  }

  // Check if the current user is an admin of the fire_department_id
  const { data: userRoleData, error: roleError } = await adminClient
    .from('fire_department_users')
    .select('role')
    .eq('fire_department_id', fire_department_id)
    .eq('user_id', userId)
    .single<FireDepartmentUserRole>();

  if (roleError) {
    console.error('Role error:', roleError);
    return new Response(JSON.stringify({ error: 'Error checking user role' }), { status: 500 });
  }

  const isFireDepartmentAdmin: boolean = userRoleData?.role === 'admin';

  // Authorization checks based on conditions
  if (!isFireDepartmentAdmin) {
    // If not fire department admin, enforce restrictions
    if (role !== 'user') {
      return new Response(JSON.stringify({ error: 'Unauthorized: Non-fire department admins can only set main role to "user"' }), { status: 403 });
    }

    if (sub_units.length === 0) {
      return new Response(JSON.stringify({ error: 'Unauthorized: Non-fire department admins must provide sub_units to invite' }), { status: 403 });
    }

    // For each sub-unit, check:
    // 1. The sub-unit belongs to the fire_department_id
    // 2. The caller is a member and admin/representative_admin of that sub-unit
    for (const subUnit of sub_units) {
      const subUnitId: string = subUnit.fire_department_sub_unit_id;

      // Check if sub-unit belongs to the fire department
      const { data: subUnitData, error: subUnitError } = await adminClient
        .from('fire_department_sub_units')
        .select('fire_department_id')
        .eq('id', subUnitId)
        .single<FireDepartmentSubUnit>();

      if (subUnitError || !subUnitData || subUnitData.fire_department_id !== fire_department_id) {
        return new Response(JSON.stringify({ error: `Unauthorized: Sub-unit ${subUnitId} does not belong to the fire department or does not exist` }), { status: 403 });
      }

      // Check caller's role in the sub-unit
      const { data: subUnitUserRoleData, error: subUnitRoleError } = await adminClient
        .from('fire_department_sub_unit_users')
        .select('role')
        .eq('fire_department_sub_unit_id', subUnitId)
        .eq('user_id', userId)
        .single<FireDepartmentSubUnitUserRole>();

      if (subUnitRoleError || !subUnitUserRoleData || (subUnitUserRoleData.role !== 'admin' && subUnitUserRoleData.role !== 'representative_admin')) {
        return new Response(JSON.stringify({ error: `Unauthorized: You must be an admin or representative_admin of sub-unit ${subUnitId} to invite to it` }), { status: 403 });
      }
    }
  } else {
    // If fire department admin, optionally check sub-units belong to the department (for consistency)
    for (const subUnit of sub_units) {
      const subUnitId: string = subUnit.fire_department_sub_unit_id;

      const { data: subUnitData, error: subUnitError } = await adminClient
        .from('fire_department_sub_units')
        .select('fire_department_id')
        .eq('id', subUnitId)
        .single<FireDepartmentSubUnit>();

      if (subUnitError || !subUnitData || subUnitData.fire_department_id !== fire_department_id) {
        return new Response(JSON.stringify({ error: `Invalid: Sub-unit ${subUnitId} does not belong to the fire department` }), { status: 400 });
      }
    }
  }

  // Send the invitation with metadata wrapped in initial_data
  const { data: inviteData, error: inviteError } = await adminClient.auth.admin.inviteUserByEmail(email, {
    data: {
      initial_data: {
        fire_department_id,
        role,
        rank,
        name,
        sub_units,
      },
    },
    redirectTo: redirect_to
  });

  if (inviteError) {
    console.error('Invite error:', inviteError);
    return new Response(JSON.stringify({ error: 'Failed to send invitation', details: inviteError.message }), { status: 500 });
  }

  return new Response(JSON.stringify({ success: true, message: 'Invitation sent successfully', inviteData }), { status: 200 });
});