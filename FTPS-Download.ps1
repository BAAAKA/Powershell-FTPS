# WinSCP .NET assembly laden
Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"

# Config
$Username = $args[0]
$Password = $args[1]
$file = $args[2]
$ftpsource = "$file"
$ftpdest = "C:\WORK\TRANSFER\$file"


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
            # Connect
            $session.Open($sessionOptions)
            
            #List Dir


                $transferResult = $session.GetFiles($ftpSource, $ftpDest).Check()

         
            # Print results
            foreach ($transfer in $transferResult.Transfers)
                {
                    Write-Host  -foregroundcolor green ("Upload of {0} succeeded" -f $transfer.FileName)
                }
        }

finally{
    $session.Dispose()
}
