# Configuration
$remoteUser = "user"
$remoteHost = "172.24.169.235"
$remoteSocksPort = 1080
$localSocksPort = 1080
$sshExe = "ssh"

# SSH Arguments
$arguments = @(
    "-N",
    "-o", "StrictHostKeyChecking=no",
    "-o", "GatewayPorts=yes",
    "-o", "ServerAliveInterval=60",          # Optional: sends keep-alive packets
    "-o", "ServerAliveCountMax=3",           # Optional: fails after 3 missed responses
    "-D", "$localSocksPort",
    "-R", "0.0.0.0:$remoteSocksPort:localhost:$localSocksPort",
    "$remoteUser@$remoteHost"
)

# Infinite loop to monitor and restart SSH connection
while ($true) {
    Write-Host "[*] Starting SSH tunnel..."
    
    # Start SSH as background process and capture the process object
    $sshProcess = Start-Process -FilePath $sshExe -ArgumentList $arguments -NoNewWindow -PassThru

    # Wait for the SSH process to exit
    $sshProcess.WaitForExit()

    # Log that the process died
    Write-Warning "[!] SSH tunnel terminated. Restarting in 5 seconds..."

    # Optional: Sleep before restart to avoid tight loop
    Start-Sleep -Seconds 5
}
