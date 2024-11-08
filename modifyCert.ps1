 # Read the content of the certificate file
$certificateContent = Get-Content -Path "C:\Users\student\Desktop\p2scert.cer"

# Process the content to remove newlines within the certificate body
$beginMarker = "-----BEGIN CERTIFICATE-----"
$endMarker = "-----END CERTIFICATE-----"

# Initialize variables to capture the certificate body
$insideCertificate = $false
$certificateBody = ""

# Loop through each line in the file
foreach ($line in $certificateContent) {
    if ($line -eq $beginMarker) {
        # Start capturing after the BEGIN marker
        $insideCertificate = $true
    } elseif ($line -eq $endMarker) {
        # Stop capturing when reaching the END marker
        $insideCertificate = $false
    } elseif ($insideCertificate -and $line.Trim() -ne "") {
        # Collect lines within the markers, removing any extra spaces
        $certificateBody += $line.Trim()
    }
}

# Combine the markers and single-line body
$singleLineCertificate = "$beginMarker`n$certificateBody`n$endMarker"

# Overwrite the existing .cer file
$singleLineCertificate | Set-Content -Path "C:\Users\student\Desktop\p2scert.cer" -Force 
