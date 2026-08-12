-- ============================================================================
--  "Conecta a tu agente" habilitado por usuario.
--
--  El permiso vive en auth.users.raw_app_meta_data->>'agent_access' (app_metadata,
--  NO user_metadata: este ultimo lo puede editar el propio usuario). Se eligio
--  app_metadata en vez de una tabla nueva porque courses-api ya resuelve el
--  usuario en cada request y lee el claim sin una consulta extra.
--
--  Regla: un admin siempre puede; un alumno solo con agent_access = true.
--
--  Backfill: quien ya tiene al menos una API key vigente conserva el acceso,
--  asi nadie pierde lo que estaba usando al aplicar esta migracion.
-- ============================================================================

update auth.users u
set raw_app_meta_data = coalesce(u.raw_app_meta_data, '{}'::jsonb)
                        || '{"agent_access": true}'::jsonb
where exists (
    select 1
    from public.agent_api_keys k
    where k.user_id = u.id
      and k.revoked_at is null
  )
  and coalesce(u.raw_app_meta_data ->> 'agent_access', '') <> 'true';
