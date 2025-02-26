# Specify the resource group and virtual network name
$resourceGroupName = ""
$virtualNetworkName = ""

# Get the virtual network
$virtualNetwork = Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $virtualNetworkName

# Get the subnets
$subnets = $virtualNetwork.Subnets

# Display the subnets
$subnets | ForEach-Object {
    [PSCustomObject]@{
        VnetName    = $virtualNetwork.Name
        VNetCIDR    = $virtualNetwork.AddressSpace.AddressPrefixes
        SubnetName  = $_.Name
        SubnetCIDR  = $_.AddressPrefix
    }
}