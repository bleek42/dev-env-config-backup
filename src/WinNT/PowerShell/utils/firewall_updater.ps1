<#
### * Get list of currently verified as active malicious botnet IP addresses from abuse.ch
### * https://sslbl.abuse.ch/blacklist/sslipblacklist.txt
### * Create & update firewall rules to block
### * inbound / outbound traffic to known botnets 
#>

$SSLBlackListTxt = Invoke-WebRequest -uri "https://sslbl.abuse.ch/blacklist/sslipblacklist.txt" | Select-Object -ExpandProperty Content
$FeodoTrackerTxt = Invoke-WebRequest -uri "https://feodotracker.abuse.ch/downloads/ipblocklist.txt" | Select-Object -ExpandProperty Content

[array] $SSLBlacklistIPAddrs = $SSLBlackListTxt -split '\r\n' | Select-String -Pattern '\d{1,3}\.+\d{1,3}\.+\d{1,3}\.+\d{1,3}' -AllMatches
[array] $FeodoTrackerIPAddrs = $FeodoTrackerTxt -split '\r\n' | Select-String -Pattern '\d{1,3}\.+\d{1,3}\.+\d{1,3}\.+\d{1,3}' -AllMatches

$HasSSLBlacklistRule = Get-NetFirewallRule -Name "BLOCK_INBOUND_BOTNETS_SSLBL" | Select-Object -ExpandProperty Name
$HasFeodoTrackerRule = Get-NetFirewallRule -Name "BLOCK_OUTBOUND_BOTNETS_FEODO" | Select-Object -ExpandProperty Name

<# 
### * Check if firewall rule with name "BLOCK_INBOUND_BOTNETS_SSL" OR "BLOCK_OUTBOUND_BOTNETS_C2" 
### * exists already and if it does, update the firewall rule 
### * with new Botnet IP addresses fetched from https://abuse.ch trackers 
#>

if ($HasSSLBlacklistRule) {
        Set-NetFirewallRule -Name "BLOCK_INBOUND_BOTNETS_SSLBL" -Direction Inbound -Action Block -RemoteAddress $SSLBlacklistIPAddrs
        Set-NetFirewallRule -Name "BLOCK_OUTBOUND_BOTNETS_SSLBL" -Direction Outbound -Action Block -RemoteAddress $FeodoTrackerIPAddrs
}
else {
        <### ? Else, create new firewall rules to block incoming & outgoing botnets with name == $name #>

        New-NetFirewallRule -Name "BLOCK_INBOUND_BOTNETS_SSLBL" -DisplayName "Block Inbound Botnet IP's (SSL Blacklist @ https://sslbl.abuse.ch)" -Description "Block all inbound traffic from verified active Botnet Command & Control (C2) server IP addresses per regularly updated trackers at https://sslbl.abuse.ch" -Direction Inbound -Action Block -RemoteAddress $SSLBlacklistIPAddrs

        New-NetFirewallRule -Name "BLOCK_OUTBOUND_BOTNETS_SSLBL" -DisplayName "Block Outbound Botnet IP's (SSL Blacklist @ https://sslbl.abuse.ch)" -Description "Block all outbound traffic from verified active Botnet Command & Control (C2) server IP addresses per regularly updated trackers at https://sslbl.abuse.ch" -Direction Outbound -Action Block -RemoteAddress $SSLBlacklistIPAddrs


        

}

if ($HasFeodoTrackerRule) {
        Set-NetFirewallRule -Name "BLOCK_INBOUND_BOTNETS_FEODO" -Direction Inbound -Action Block -RemoteAddress $FeodoTrackerIPAddrs
        Set-NetFirewallRule -Name "BLOCK_OUTBOUND_BOTNETS_FEODO" -Direction Outbound -Action Block -RemoteAddress $FeodoTrackerIPAddrs
}
else {
        New-NetFirewallRule -Name "BLOCK_INBOUND_BOTNETS_FEODO" -DisplayName "Block Outbound Botnet IP's (Feodo Tracker @ https://feodotracker.abuse.ch)" -Description "Block all inbound traffic from verified active Botnet Command & Control (C2) server IP addresses per regularly updated trackers at https://feodotracker.abuse.ch" -Direction Inbound -Action Block -RemoteAddress $FeodoTrackerIPAddrs

        New-NetFirewallRule -Name "BLOCK_OUTBOUND_BOTNETS_FEODO" -DisplayName "Block Outbound Botnet IP's (Feodo Tracker @ https://feodotracker.abuse.ch)" -Description "Block all outbound traffic from verified active Botnet Command & Control (C2) IP addresses per regularly updated trackers at https://feodotracker.abuse.ch" -Direction Outbound -Action Block -RemoteAddress $FeodoTrackerIPAddrs

}

