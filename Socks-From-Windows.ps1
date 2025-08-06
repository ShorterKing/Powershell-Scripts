# Variables
$remoteUser = "user"
$remoteHost = "172.24.169.235"
$remoteSocksPort = 1080
$localSocksPort = 1080

# Path to ssh
$sshExe = "ssh"

# Arguments as an array (comma-separated)
$arguments = @(
    "-N",
    "-o", "StrictHostKeyChecking=no",
    "-o", "GatewayPorts=yes",
    "-D", "$localSocksPort",
    "-R", "0.0.0.0:$remoteSocksPort:localhost:$localSocksPort",
    "$remoteUser@$remoteHost"
)

# Start SSH tunnel
Start-Process $sshExe -ArgumentList $arguments -NoNewWindow -Wait
