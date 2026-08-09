param([switch]$ClipboardOnly)

$ErrorActionPreference = 'Stop'
$config = [IO.Path]::Combine($HOME, '.config', 'learnforce')
New-Item -ItemType Directory -Force -Path $config | Out-Null

$key = $null
if ($ClipboardOnly) {
  try {
    $candidate = (Get-Clipboard -Raw -ErrorAction Stop).Trim()
    if ($candidate -match '^lf_agent_\S{16,}$') { $key = $candidate }
  } catch {
    $key = $null
  }
  if (-not $key) {
    Write-Output 'No hay una API key válida de LearnForce en el portapapeles.'
    return
  }
}

if (-not $key) { $key = Read-Host 'Pega tu API key de LearnForce' }
if ([string]::IsNullOrWhiteSpace($key)) { throw 'La API key no puede estar vacía.' }
if ($key -notmatch '^lf_agent_\S{16,}$') { throw 'La API key de LearnForce no tiene un formato válido.' }

Set-Content -LiteralPath (Join-Path $config '.env') -Value "LEARN_FORCE_API_KEY=$key" -Encoding UTF8
Remove-Variable key
Write-Output 'API key de LearnForce guardada.'
