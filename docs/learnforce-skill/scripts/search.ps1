param(
  [Parameter(Mandatory = $true)][string]$Query,
  [ValidateSet('keyword', 'semantic', 'hybrid')][string]$Mode = 'hybrid',
  [ValidateRange(1, 50)][int]$Limit = 10,
  [string]$EnvFile = ''
)

$ErrorActionPreference = 'Stop'
$baseUrl = 'https://bipsvhxsvfzfwzufucfg.supabase.co/functions/v1/courses-api/v1'

function Get-LearnForceKey {
  if ($env:LEARN_FORCE_API_KEY) { return $env:LEARN_FORCE_API_KEY }
  $resolvedEnvFile = if ($EnvFile) { $EnvFile } else { [IO.Path]::Combine($HOME, '.config', 'learnforce', '.env') }
  if (-not (Test-Path -LiteralPath $resolvedEnvFile)) {
    throw "LEARN_FORCE_API_KEY no está definida y no existe $resolvedEnvFile"
  }
  $line = Get-Content -LiteralPath $resolvedEnvFile | Where-Object { $_ -match '^LEARN_FORCE_API_KEY=' } | Select-Object -First 1
  if (-not $line) { throw "LEARN_FORCE_API_KEY no está definida en $resolvedEnvFile" }
  return ($line -split '=', 2)[1].Trim().Trim('"').Trim("'")
}

$key = Get-LearnForceKey
$headers = @{ 'X-API-Key' = $key; 'Content-Type' = 'application/json' }
$body = @{ query = $Query; limit = $Limit } | ConvertTo-Json
$result = Invoke-RestMethod -Method Post -Uri "$baseUrl/search/$Mode" -Headers $headers -Body $body

foreach ($item in @($result.data)) {
  $url = "https://learn.techforce.cl/#curso/$($item.course_id)/$($item.module_id)/clase/$($item.lesson_id)"
  $item | Add-Member -NotePropertyName ui_url -NotePropertyValue $url -Force
}

$result | ConvertTo-Json -Depth 20
