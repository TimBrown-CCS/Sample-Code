﻿# Username and password for Autotask
$ATurl = "https://webservices.autotask.net/ATServices/1.5/atws.wsdl" # To use Version 1.6 change to "https://webservices.autotask.net/ATServices/1.6/atws.wsdl"
$ATusername = "USERNAME"
$ATpassword = ConvertTo-SecureString "PASSWORD" -AsPlainText -Force
$ATcredentials = New-Object System.Management.Automation.PSCredential($ATusername,$ATpassword)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$atws = New-WebServiceProxy -URI $ATUrl -Credential $ATcredentials 
$zoneInfo = $atws.getZoneInfo($ATusername)
$ATurl = $zoneInfo.URL.Replace(".asmx",".wsdl")
$atws = New-WebServiceProxy -URI $ATurl -Credential $ATcredentials -Namespace ‘Autotask’ -Class ‘API’ 
# Uncomment the following lines for version 1.6
#$integrationsValue = New-Object -TypeName Autotask.AutotaskIntegrations
#$integrationsValue.IntegrationCode = "[Insert Tracking Identifier Here]"
#$atws.AutotaskIntegrationsValue = $integrationsValue
$ATnamespace = $atws.GetType().Namespace

$Result = $atws.getThresholdAndUsageInfo()
Write-Host $Result.EntityReturnInfoResults[0].Message