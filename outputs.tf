In Azure, an output can be defined in a resource template (like an ARM template) to capture properties such as the Storage Account ID and endpoint. Here’s a sample ARM template snippet that defines outputs for an Azure Storage Account to capture its ID and endpoint.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2021-02-01",
      "name": "[parameters('storageAccountName')]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "[parameters('skuName')]",
        "tier": "[parameters('skuTier')]"
      },
      "kind": "StorageV2",
      "properties": {}
    }
  ],
  "outputs": {
    "storageAccountId": {
      "type": "string",
      "value": "[resourceId('Microsoft.Storage/storageAccounts', parameters('storageAccountName'))]"
    },
    "storageAccountEndpoint": {
      "type": "string",
      "value": "[concat('https://', parameters('storageAccountName'), '.blob.core.windows.net')]"
    }
  },
  "parameters": {
    "storageAccountName": {
      "type": "string",
      "metadata": {
        "description": "Name of the storage account."
      }
    },
    "location": {
      "type": "string",
      "metadata": {
        "description": "Location for the storage account."
      }
    },
    "skuName": {
      "type": "string",
      "defaultValue": "Standard_LRS",
      "metadata": {
        "description": "SKU name for the storage account."
      }
    },
    "skuTier": {
      "type": "string",
      "defaultValue": "Standard",
      "metadata": {
        "description": "SKU tier for the storage account."
      }
    }
  }
}
```

### Explanation:
- **Outputs Section**: This is where you define outputs that can be retrieved after the deployment completes.
  - `storageAccountId`: This output captures the ID of the storage account using the `resourceId` function.
  - `storageAccountEndpoint`: This output constructs the endpoint URL