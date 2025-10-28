Certainly! Below is an example of a Terraform variables configuration for creating an Azure Storage Account. This configuration includes various parameters that influence the creation of the storage account, such as the name, resource group, location, replication type, and access tier.

### `variables.tf`

```hcl
variable "storage_account_name" {
  description = "The name of the storage account. Must be globally unique."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "location" {
  description = "The Azure region where the storage account will be created."
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "sku" {
  description = "The SKU for the storage account."
  type        = string
  default     = "Standard_LRS" # Example: Standard_LRS, Premium_LRS, etc.
}

variable "kind" {
  description = "The kind of the storage account."
  type        = string
  default     = "StorageV2" # Example: Storage, StorageV2, BlobStorage, etc.
}

variable "enable_https_traffic_only" {
  description = "Specifies whether HTTPS traffic is required for the storage account."
  type        = bool
  default     = true
}

variable "access_tier" {
  description = "The access tier for Blob storage."
  type        = string
  default     = "Hot" # Options: Hot, Cool, Archive, etc.
}
```

### Example Usage in `main.tf`

Here's how you might reference these variables in your main Terraform configuration file, `main.tf`, to create the Azure Storage Account:

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier            = lower(var.sku) == "premium_lrs