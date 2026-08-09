param(
  [Parameter(Mandatory = $true)][string]$CourseId,
  [Parameter(Mandatory = $true)][string]$ModuleId,
  [string]$EnvFile = 'C:\github\learn-force\.env'
)

$ErrorActionPreference = 'Stop'
$baseUrl = 'https://bipsvhxsvfzfwzufucfg.supabase.co/functions/v1/courses-api/v1'

function Get-LearnForceKey {
  if ($env:LEARN_FORCE_API_KEY) { return $env:LEARN_FORCE_API_KEY }
  if (-not (Test-Path -LiteralPath $EnvFile)) { throw "LEARN_FORCE_API_KEY no está definida y no existe $EnvFile" }
  $line = Get-Content -LiteralPath $EnvFile | Where-Object { $_ -match '^LEARN_FORCE_API_KEY=' } | Select-Object -First 1
  if (-not $line) { throw "LEARN_FORCE_API_KEY no está definida en $EnvFile" }
  return ($line -split '=', 2)[1].Trim().Trim('"').Trim("'")
}

$key = Get-LearnForceKey
$uri = "$baseUrl/courses/$CourseId/modules/$ModuleId/lessons"
$result = Invoke-RestMethod -Method Get -Uri $uri -Headers @{ 'X-API-Key' = $key }

foreach ($item in @($result.data)) {
  $lessonId = if ($item.id) { $item.id } else { $item.lesson_id }
  $item | Add-Member -NotePropertyName ui_url -NotePropertyValue "https://learn.techforce.cl/#curso/$CourseId/$ModuleId/clase/$lessonId" -Force
}

$result | ConvertTo-Json -Depth 20
