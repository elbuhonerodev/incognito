$headers = @{
    "apikey" = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImloempidG1kb3RkYWdoYmpqemlrIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3OTczNjI2NywiZXhwIjoyMDk1MzEyMjY3fQ.qDVy2ETAI0FnIS1agWrEl0LiZsMPqcA9fZq2X9IjX8Y"
    "Authorization" = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImloempidG1kb3RkYWdoYmpqemlrIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3OTczNjI2NywiZXhwIjoyMDk1MzEyMjY3fQ.qDVy2ETAI0FnIS1agWrEl0LiZsMPqcA9fZq2X9IjX8Y"
    "Content-Type" = "application/json"
    "Prefer" = "return=representation"
}
$body = '[{"key_hash":"INCOGNITO-TEST123456","creada_por":7250986566,"estado":"DISPONIBLE","expira_en":"2026-12-31T23:59:59Z"}]'
try {
    $result = Invoke-RestMethod -Uri "https://ihzjbtmdotdaghbjjzik.supabase.co/rest/v1/keys_generadas" -Method Post -Headers $headers -Body $body
    $result | ConvertTo-Json
    Write-Host "INJECTION_SUCCESS"
} catch {
    Write-Host "INJECTION_FAILED"
    Write-Host $_.Exception.Message
}
