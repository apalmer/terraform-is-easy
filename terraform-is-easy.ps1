Invoke-RestMethod -Uri https://releases.hashicorp.com/terraform/1.2.8/terraform_1.2.8_windows_amd64.zip -OutFile terraform.zip

Expand-Archive .\terraform.zip -DestinationPath . -Force

Remove-Item .\terraform.zip    

winget install -e --id Microsoft.AzureCLI   

az login       

Set-Content -Path main.tf -Value @"
provider "azurerm" {
    features {}
}
  
resource "azurerm_resource_group" "my_resource_group" {
    name     = "rg-terraform-is-easy"
    location = "eastus2"
}
"@

.\terraform.exe init

.\terraform.exe apply

#uncomment to clean up resources
.\terraform.exe destroy