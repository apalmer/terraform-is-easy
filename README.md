Terraform the Easy Way
======================

Installing terraform is EASY
----------------------------

Terraform is a single executable, just download the executable and start using it!

https://www.terraform.io/downloads

I like to just download it from the PowerShell command line.

    Invoke-RestMethod -Uri https://releases.hashicorp.com/terraform/1.2.8/terraform_1.2.8_windows_amd64.zip -OutFile terraform.zip

No installer or other dependencies just unzip the downloaded archive to wherever you like and its ready to be used. I like to place it in a directly next to my terraform code because sometimes I am working on multiple projects which use different versions of terraform. 

    Expand-Archive .\terraform.zip -DestinationPath .

    Remove-Item .\terraform.zip

You also can just save the executable in one location on your computer, add it to your PATH environment variable and use the same executable for all your projects.

Using Terraform with Azure is kinda Easy
----------------------------------------

Terraform can configure basically anything with a REST API, here we are going to use it to configure Azure. 

So your going to need a few things...

1. An Azure Subscription
2. The Azure CLI
3. The AzureRM terraform provider

### The az CLI
Assuming you already have an Azure Subscription, the Azure CLI is the next step. Technically you don't need the Azure CLI we are just using it here to log into your Azure Subscription. There are other ways for terraform to authenticate with your Azure Subscription but this way is I think the simplest for getting started.

Just install the Azure CLI, here I am doing so using winget.

    winget install -e --id Microsoft.AzureCLI

Then log into your Azure Subscription.

    az login

The az login command launches a web browser, where you enter your Azure credentials, authenticating you for both the az CLI and the terraform executable.

### The AzureRM Provider

As mentioned before Terraform can be used to configure almost anything, so we have to tell terraform that we will be configuring Azure in this case. We do this by specifying the *provider* that terraform should use in a configuration file. 

Create a file called main.tf, and add the following content to the file.

    provider "azurerm" {
        features {}
    }

This tells terraform to use the *azurerm* provider and defaults the configuration for that provider.

Now we are ready to issue our first terraform command!

    .\terraform.exe init

This initializes terraform based on the configuration found in the current directory. In this case, terraform is initalized by downloading the azurerm provider plugin, and creating a terraform dependency lock file.

At this point we are ready to actual configure some Azure resources with terraform.

Creating Azure resources with terraform is EASY
-----------------------------------------------

Now lets create the simplest possible Azure resource with terraform. Every resource in Azure is contained within an Azure Resource Group except for an Azure Resource Group, so lets consider an Azure Resource Group the simplest possible Azure resource. 

The basic syntax for resources in terraform follows the following pattern:

    resource "type_of_resource" "name" {
        some_setting        = "value of some_setting"
        some_other_setting  = "value of some_other_setting"
    }

So following this pattern, add the following content to your main.tf configuration file to create a empty Azure resource group.

    resource "azurerm_resource_group" "my_resource_group" {
        name     = "rg-terraform-is-easy"
        location = "eastus2"
    }

This will create an empty Azure resource group named 'rg-terraform-is-easy' in the 'East US 2' Azure region.

Lets actually deploy this resource group using terraform.

    .\terraform.exe apply

When you run the terraform apply command terraform will create an execution plan which indicates what will change in your Azure subscription and then prompt you to type 'yes' if you would like to actually update your Azure subscription. 

Type 'yes' to deploy this resource group.

If you check in the Azure Portal you will now see a new resource group with the name 'rg-terraform-is-easy'. You can also verify by running the following az CLI command.

    az group show --resource-group rg-terraform-is-easy

A total of about 6 commands and a text file with 7 simple lines are all thats required to install terraform and deploy the simplest possible resource you can to Azure.

__that was easy__

Cleaning Up
-----------

Lets do 1 more command to clean up after ourselves. 

Now that we are done with this walkthrough lets remove whatever Azure resources terraform is managing. Terraform tracks the state of the resources it is managing. If you look at the directory where you executed terraform, you will see there is a file called terraform.tfstate which is a json file that contains information on the resources that terraform is managing. As a result terraform can easily clean up all the resources it creates with the destroy command.

    .\terraform.exe destroy

This will prompt you to type in 'yes' to actually delete your terraform managed Azure resources.

If you would like you could download a working version of this article with a PowerShell script that executes these commands from my github [here](https://github.com/apalmer/terraform-is-easy).

That's it, build and destroy.

EASY
====