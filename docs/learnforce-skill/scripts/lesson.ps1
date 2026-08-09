param(
  [Parameter(Mandatory = $true)][string]$CourseId,
  [Parameter(Mandatory = $true)][string]$ModuleId,
  [Parameter(Mandatory = $true)][string]$LessonId,
  [string]$EnvFile = ''
)

$ErrorActionPreference = 'Stop'
$baseUrl = 'https://bipsvhxsvfzfwzufucfg.supabase.co/functions/v1/courses-api/v1'

function Get-LearnForceKey {
  if ($env:LEARN_FORCE_API_KEY) { return $env:LEARN_FORCE_API_KEY }
  $resolvedEnvFile = if ($EnvFile) { $EnvFile } else { [IO.Path]::Combine($HOME, '.config', 'learnforce', '.env') }
  if (-not (Test-Path -LiteralPath $resolvedEnvFile)) { throw "LEARN_FORCE_API_KEY no está definida y no existe $resolvedEnvFile" }
  $line = Get-Content -LiteralPath $resolvedEnvFile | Where-Object { $_ -match '^LEARN_FORCE_API_KEY=' } | Select-Object -First 1
  if (-not $line) { throw "LEARN_FORCE_API_KEY no está definida en $resolvedEnvFile" }
  return ($line -split '=', 2)[1].Trim().Trim('"').Trim("'")
}

$key = Get-LearnForceKey
$uri = "$baseUrl/courses/$CourseId/modules/$ModuleId/lessons/$LessonId"
$result = Invoke-RestMethod -Method Get -Uri $uri -Headers @{ 'X-API-Key' = $key }
$result.data | Add-Member -NotePropertyName ui_url -NotePropertyValue "https://learn.techforce.cl/#curso/$CourseId/$ModuleId/clase/$LessonId" -Force
$result | ConvertTo-Json -Depth 30
