### * #########################################################################################################################
### * Get frequently updated & widely-trusted list of active & malicious IP addresses from https://abuse.ch/				###
### * Initially creates, updates Windows Advanced Firewall with rules that block these remote IP addresses.					###
### * inbound / outbound traffic from the current list of threat actors IP's (active botnets, malware distributors, etc.)   ###
### * #########################################################################################################################

$fwGroup = "Blocked"

$basenameSSLBL = "BOTNETS_SSLBL"
$basenameFeodo = "BOTNETS_FEODO"

$suffixInbound = "_INBOUND"
$suffixOutbound = "_OUTBOUND"

## ? append to new variables with these strings to form names for firewall rules
$inboundSSLBL = $basenameSSLBL + $suffixInbound
$inboundFeodo = $basenameFeodo + $suffixInbound

$outboundSSLBL = $basenameSSLBL + $suffixOutbound
$outboundFeodo = $basenameFeodo + $suffixOutbound

$displaySSLBL = "Blocked IP Addresses - SSL BlackList @ https://sslbl.abuse.ch)"
$displayFeodo = "Blocked IP Addresses - Feodo Tracker @ https://feodotracker.abuse.ch)"

$descFeodo = "Block remote IP addresses from network connections that have been confirmed as currently active, malicious threat actors, such as botnet command & control (C2) servers, malware distributors, etc. Provided by highly credible, frequently updated, and widely-trusted tracker lists provided by: https://feodotracker.abuse.ch"
$descSSLBL = "Block remote IP addresses from network connections that have been confirmed as currently active, malicious threat actors, such as botnet command & control (C2) servers, malware distributors, etc. Provided by highly credible, frequently updated, and widely-trusted tracker lists provided by: https://sslbl.abuse.ch"

$rules = @(
	@{
		Name          = $inboundSSLBL
		DisplayName   = $displaySSLBL
		Description   = $descSSLBL
		Direction     = 'Inbound'
		Action        = 'Block'
		RemoteAddress = $ipdAddrsSSLBL
	},
	@{
		Name          = $outboundSSLBL
		DisplayName   = $displaySSLBL
		Description   = $descSSLBL
		Direction     = 'Outbound'
		Action        = 'Block'
		RemoteAddress = $ipdAddrsSSLBL
	},
	@{
		Name          = $inboundFeodo
		DisplayName   = $displayFeodo
		Description   = $descFeodo
		Direction     = 'Inbound'
		Action        = 'Block'
		RemoteAddress = $ipAddrsFeodo
	},
	@{
		Name          = $outboundFeodo
		DisplayName   = $displayFeodo
		Description   = $descFeodo
		Direction     = 'Outbound'
		Action        = 'Block'
		RemoteAddress = $ipAddrsFeodo
	}
)

try {

	[string] $SSLBLTxt = Invoke-WebRequest -uri "https://sslbl.abuse.ch/blacklist/sslipblacklist.txt" | Select-Object -ExpandProperty Content
	[string] $FeodoTxt = Invoke-WebRequest -uri "https://feodotracker.abuse.ch/downloads/ipblocklist.txt" | Select-Object -ExpandProperty Content

	[array] $ipdAddrsSSLBL = $SSLBLTxt -split '\r\n' | Select-String -Pattern '\d{1,3}\.+\d{1,3}\.+\d{1,3}\.+\d{1,3}' -AllMatches
	[array] $ipAddrsFeodo = $FeodoTxt -split '\r\n' | Select-String -Pattern '\d{1,3}\.+\d{1,3}\.+\d{1,3}\.+\d{1,3}' -AllMatches

	### * ##########################################################################
	### * ##########################################################################
	### * Loop through array of firewall rule objects, if firewall rule          ###
	### * with property NAME with VALUE "BOTNETS_SSLBL" or "BOTNETS_FEODO"       ###
	### * followed by "_INBOUND" or "_OUTBOUND" appended at the end              ###
	### * Check if rule exists in firewall and if it does, update corresponding  ###
	### * rule with new block lists or else create new firewall rule with        ###
	### * current list of known confirmed active threat actor IP addresses       ###
	### * protecting your Windows client / server from being compromised	     ###
	### * by botnets, malware, etc. (SEE: https://abuse.ch)   					 ###
	### * ##########################################################################
	### * ##########################################################################

	foreach ($rule in $rules) {

		$existingRule =	Get-NetFirewallRule -Name $rule.Name -ErrorAction SilentlyContinue

		## * Set firewall rule if there is an existing rule with same name
		if ($existingRule.Name -eq $rule.Name) {
			Set-NetFirewallRule -Name $rule.Name -RemoteAddress $rule.RemoteAddress
		}

		else {
			$rule.Add('Group', $fwGroup)
			New-NetFirewallRule $rule
		}

	}
}

catch {
	<## ! Do this if a terminating exception happens ##>
	$errorMessage = $_.Exception.Message
	Write-Error -Category InvalidOperation -Message "Error: $errorMessage"
	# -	Write-Error -Category FromStdErr -ErrorAction Stop -Message "Error: $($_.Exception.Message)"
}
