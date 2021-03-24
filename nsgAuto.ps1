$azSubs = Get-AzSubscription
foreach ( $azSub in $azSubs ) {
    Set-AzContext -Subscription $azSub | Out-Null
    $azSubName = $azSub.Name

    $azNsgs = Get-AzNetworkSecurityGroup
foreach ( $azNsg in $azNsgs ) {

Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $azNsg | `
            Select-Object @{label = 'NSG Name'; expression = { $azNsg.Name } }, `
            @{label = 'NSG Location'; expression = { $azNsg.Location } }, `
            @{label = 'Rule Name'; expression = { $_.Name } }, `
            @{label = 'Source'; expression = { $_.SourceAddressPrefix } }, `
            @{label = 'Source Port Range'; expression = { $_.SourcePortRange } }, Access, Priority, Direction, `
            @{label = 'Destination'; expression = { $_.DestinationAddressPrefix } }, `
            @{label = 'Destination Port Range'; expression = { $_.DestinationPortRange } }, `
            @{label = 'Resource Group Name'; expression = { $azNsg.ResourceGroupName } } | `
            Export-Csv -Path "$($home)\clouddrive\$azSubName-nsg-rules.csv" -NoTypeInformation -Append –force

   }
}

