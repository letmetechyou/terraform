# Create a new shell application object
$shell = New-Object -ComObject "Shell.Application"

# Minimize all windows
$shell.MinimizeAll()

# Open the FolderBrowserDialog
Add-Type -AssemblyName System.Windows.Forms
$Path = New-Object System.Windows.Forms.FolderBrowserDialog
$Path.ShowDialog()

# Restore all windows
$shell.UndoMinimizeAll()


# Initialize Hashtable
$Module = @{}
$Module.Path = $Path.SelectedPath
$Module.Module = Read-Host "Module Name (azurerm_resource_group)"
$Module.Module = $Module.Module
$Module.Name = $Module.Module.split("_")[1..10] -join "_"
$Module.Foreach = "{ for key, value in var.$($Module.Name)_data : key => value if value.enabled }"
$Module.Resource = ""
$Module.Outputs = ""
$Module.Variables = ""
$Module.ModuleCall = ""
$Module.RootVariables = ""
$Module.url = "https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/main/website/docs/r/$($Module.Module.split("_")[1..10] -join "_").html.markdown"
$Module.response = Invoke-WebRequest -Uri $Module.url
# Define the patterns to search for
$Module.startPattern = "## Argument"
$Module.endPattern = "## Attribute"
# Use regex to extract the content between the patterns
$Module.Content = [Regex]::Matches($Module.response.Content, "(?s)$($Module.startPattern)(.*?)$($Module.endPattern)")

# Input: Documentation text
$Module.Arguments = @{}

$Module.All = $Module.Content.Groups[0].Value.Split("`n") | Out-GridView -OutputMode Multiple #Show-SingleEntryForm -WindowTitle "All"
$Module.Required =  $Module.All -split [Environment]::NewLine | Where-Object{$_ -like "*(Required)*" -and $_ -notlike "* block*"} | Out-GridView -OutputMode Multiple -Title 'Required'
$Module.RequiredBlocks =  $Module.All -split [Environment]::NewLine | Where-Object{$_ -like "*(Required)*" -and $_ -like "* block*"} | Out-GridView -OutputMode Multiple -Title 'RequiredBlocks'
$Module.Optional = $Module.All -split [Environment]::NewLine | Where-Object{$_ -like "*(Optional)*" -and $_ -notlike "* block*"} | Out-GridView -OutputMode Multiple -Title 'Optional'
$Module.OptionalBlocks =  $Module.All -split [Environment]::NewLine | Where-Object{$_ -like "*(Optional)*" -and $_ -like "* block*"} | Out-GridView -OutputMode Multiple -Title 'OptionalBlocks'

$Module.Arguments.Required = @{}
$Module.Arguments.Optional = @{}
$Module.Arguments.RequiredBlocks = @{}
$Module.Arguments.OptionalBlocks = @{}

# Process each line of the documentation
$Module.Required | ForEach-Object{
        $variable = ($_.Split('-', 3) | ForEach-Object { $_.Replace("*","").replace("``","").TrimEnd().TrimStart() })[0]
        $Module.Arguments.Required."$variable" = "each.value.$variable"
}

if($null -ne $Module.RequiredBlocks) {
        $Module.RequiredBlocks | ForEach-Object{
                $variable = ($_.Split('-', 3) | ForEach-Object { $_.Replace("*","").replace("``","").TrimEnd().TrimStart() })[0]
                $requiredblock = $Module.Content.Groups[0].Value.Split("`n") | Out-GridView -OutputMode Multiple -Title "$variable Block" 
                #Show-SingleEntryForm -WindowTitle "$variable Block Info"
                $requiredblock = $requiredblock -split [System.Environment]::NewLine
                $Module.Arguments.RequiredBlocks.$variable = @{}
                $requiredblock | Where-Object{$_ -like "*Required*"} | ForEach-Object{
                        $blockvariable = ($_.Split('-', 3) | ForEach-Object { $_.Replace("*","").replace("``","").TrimEnd().TrimStart() })[0]
                        $Module.Arguments.RequiredBlocks.$variable.$blockvariable = $True
                }
                $requiredblock | Where-Object{$_ -like "*Optional*"} | ForEach-Object{
                        $blockvariable = ($_.Split('-', 3) | ForEach-Object { $_.Replace("*","").replace("``","").TrimEnd().TrimStart() })[0]
                        $Module.Arguments.RequiredBlocks.$variable.$blockvariable = $false
                }
        }
}

if($null -ne $Module.Optional){
        $Module.Optional | ForEach-Object{
        $variable = ($_.Split('-', 3) | ForEach-Object { $_.Replace("*","").replace("``","").TrimEnd().TrimStart() })[0]
        $Module.Arguments.Optional."$variable" = "each.value.$variable"
        }
}

if($null -ne $Module.OptionalBlocks) {
        $Module.OptionalBlocks | ForEach-Object{
                $variable = ($_.Split('-', 3) | ForEach-Object { $_.Replace("*","").replace("``","").TrimEnd().TrimStart() })[0]
                $optionalblock = $Module.Content.Groups[0].Value.Split("`n") | Out-GridView -OutputMode Multiple -Title "$variable Block"
                #Show-SingleEntryForm -WindowTitle "$variable Block Info"
                $optionalblock = $optionalblock -split [System.Environment]::NewLine
                $Module.Arguments.OptionalBlocks.$variable = @{}
                $optionalblock | Where-Object{$_ -like "*Required*"} | ForEach-Object{
                        $blockvariable = ($_.Split('-', 3) | ForEach-Object { $_.Replace("*","").replace("``","").TrimEnd().TrimStart() })[0]
                        $Module.Arguments.OptionalBlocks.$variable.$blockvariable = $True
                }
                $optionalblock | Where-Object{$_ -like "*Optional*"} | ForEach-Object{
                        $blockvariable = ($_.Split('-', 3) | ForEach-Object { $_.Replace("*","").replace("``","").TrimEnd().TrimStart() })[0]
                        $Module.Arguments.OptionalBlocks.$variable.$blockvariable = $false
                }
        }
}

$Module.Resource = @"
resource "$($Module.Module)" "$($Module.Name)" {
        for_each = $($Module.Foreach)

        # Required Arguments
        $(
        $max = [math]::Ceiling(($Module.Arguments.Required.Keys.Length | Sort-Object -Descending)[0] / 8) * 8
        $Module.Arguments.Required.GetEnumerator() | ForEach-Object{
                $tab = [math]::Ceiling(($max - $_.Key.Length) / 8)
                $tabs = "`t" * ($tab)
                "$($_.key)$tabs= $($_.value)`r`n"
        }
        )
        
        # Required Blocks `r`n
        $(
        $Module.Arguments.RequiredBlocks.GetEnumerator() | ForEach-Object{
                $BlockVar = $_.Name
                "$($_.Name) {`r`n"
                "# Required`r`n"
                $Module.Arguments.RequiredBlocks.$BlockVar.GetEnumerator() | Where-Object{$_.value -eq $True} | ForEach-Object{
                "`t`t$($_.key) = each.value.$Blockvar.$($_.key)`r`n"
                }
                "`t`t# Optional`r`n"
                $Module.Arguments.RequiredBlocks.$BlockVar.GetEnumerator() | Where-Object{$_.value -eq $false} | ForEach-Object{
                "`t`t$($_.key) = each.value.$Blockvar.$($_.key)`r`n"
                }
                "}`r`n"
                }
        )

        # Optional Arguments
        $(
        if(($Module.Arguments.Optional).Count -gt 0){
        $max = [math]::Ceiling(($Module.Arguments.Optional.Keys.Length | Sort-Object -Descending)[0] / 8) * 8
        $Module.Arguments.Optional.GetEnumerator() | ForEach-Object{
                $tab = [math]::Ceiling(($max - $_.Key.Length) / 8)
                $tabs = "`t" * ($tab)
                "$($_.key)$tabs= $($_.value)`r`n"
        }
        }
        )

        # Optional Dynamic Blocks
        $(
        $Module.Arguments.OptionalBlocks.GetEnumerator() | ForEach-Object {
                "dynamic `"$($_.key)`" {
                        $($dynamic = $_.key)
                        for_each = each.value.$($_.key) != null ? range(length(each.value.$($_.key))) : []
                    
                        content {
                                # Required
                                $($Module.Arguments.OptionalBlocks.$dynamic.GetEnumerator() | Where-Object{$_.value -eq $True} | ForEach-Object{
                                        
                                "$($_.key)`t= each.value.$dynamic[$dynamic.key].$($_.key)`r`n`t"
                                }
                                )
                                # Optional
                                $($Module.Arguments.OptionalBlocks.$dynamic.GetEnumerator() | Where-Object{$_.value -eq $False} | ForEach-Object{
                                
                                "$($_.key)`t= each.value.$dynamic[$dynamic.key].$($_.key)`r`n`t"
                                }
                                )}
                        }
  
                "
        }
        )

        lifecycle {
                prevent_destroy = false
        }
}
"@

$Module.Outputs = @"
output "$($Module.Name)_output" {
	value = zipmap(values($($Module.Module).$($Module.Name))[*].name, values($($Module.Module).$($Module.Name))[*])
}

output "$($Module.Name)_output_names" {
        value = { for key, value in $($Module.Module).$($Module.Name) : value.name => value }
}
"@

$Module.Variables = @"
variable $($Module.Name)_data {}
"@

$Module.ModuleCall = @"
module "$($Module.Name)" {
	source = "../Modules/$($Module.Name)"

	$($Module.Name)_data = var.$($Module.Name)_data
}
"@

$Module.Readme = @"
### $($Module.Name.ToUpper()) MODULE

# $($Module.Name.ToUpper())_DATA.TFVARS EXAMPLE
``````

``````

# $($Module.Name.ToUpper()) MAIN.TF MODULE REFERENCE
``````
module "$($Module.Name)" {
        source = "./Modules/$($Module.Name)"

        $($Module.Name)_data = var.$($Module.Name)_data
}
``````

# $($Module.Name.ToUpper()) ROOT VARIABLES.TF
``````

``````
"@

$Module.Resource | Out-File -FilePath "$($Module.Path)\$($Module.name).resource.tf" -Encoding utf8
$Module.Outputs | Out-File -FilePath "$($Module.Path)\$($Module.name).outputs.tf" -Encoding utf8
$Module.Variables | Out-File -FilePath "$($Module.Path)\$($Module.name).variables.tf" -Encoding utf8
$Module.Readme | Out-File -FilePath "$($Module.Path)\README.md" -Encoding utf8

terraform fmt $Module.Path