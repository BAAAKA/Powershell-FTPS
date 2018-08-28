# WinSCP .NET assembly laden
Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"
# Config
$Username = $args[0]
$Password = $args[1]
$file = $args[2]
$source = "C:\WORK\TRANSFER\$file"
$dest = "$file"


# Sitzungsoptionen konfigurieren
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Ftp
    HostName = ""
    PortNumber = 22
    UserName = "$Username"
    Password = "$Password"
    FtpSecure = [WinSCP.FtpSecure]::Explicit
    TlsHostCertificateFingerprint = ""
}

$session = New-Object WinSCP.Session

try{
    # Verbinden
    $session.Open($sessionOptions)

    # Ihr Codes
    
    # Upload files
    $transferOptions = New-Object WinSCP.TransferOptions
    $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary

    $transferResult =
    $session.PutFiles("$source", "$dest", $False, $transferOptions)

    # Throw on any error
    $transferResult.Check()

    # Print results
    foreach ($transfer in $transferResult.Transfers)
    {
        Write-Host ("Upload of {0} succeeded" -f $transfer.FileName)
    }
    
}
finally
{
    $session.Dispose()
}