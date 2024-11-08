# Read the content of the certificate file
$certificateContent = Get-Content -Path "C:\Users\student\Desktop\p2scert.cer"

# Initialize variables to capture the certificate body
$insideCertificate = $false
$certificateBody = ""

# Loop through each line in the file
foreach ($line in $certificateContent) {
    if ($line -eq "-----BEGIN CERTIFICATE-----") {
        # Start capturing after the BEGIN marker
        $insideCertificate = $true
    } elseif ($line -eq "-----END CERTIFICATE-----") {
        # Stop capturing when reaching the END marker
        $insideCertificate = $false
    } elseif ($insideCertificate -and $line.Trim() -ne "") {
        # Append lines within the markers, removing any whitespace
        $certificateBody += $line.Trim()
    }
}

# Save the final single-line certificate body to a file (or display it if needed)
Set-Content -Path "C:\Users\student\Desktop\singleLineCertBody.txt" -Value $certificateBody -Force
