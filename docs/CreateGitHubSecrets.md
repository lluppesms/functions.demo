# Set up GitHub Secrets

The GitHub workflows in this project require several secrets set at the repository level.

---

## Azure Credentials

You need to set up the Azure Credentials secret in the GitHub Secrets at the Repository level before you do anything else.

See https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-github-actions for more info.

It should look something like this:

AZURE_CREDENTIALS:

``` bash
gh secret set AZURE_CLIENT_ID -b '<GUID>'
gh secret set AZURE_CLIENT_SECRET -b '<GUID>'
gh secret set AZURE_TENANT_ID -b '<GUID>'
gh secret set AZURE_SUBSCRIPTION_ID -b '<yourAzureSubscriptionId>'
```

---

## Bicep Configuration Values

These secrets are used by the Bicep templates to configure the resource names that are deployed.  
Make sure the App_Name variable is unique to your deploy. It will be used as the basis for the function name and for all the other Azure resources, which must be globally unique.
To create these additional secrets, customize and run this command:

Required Values:

``` bash
gh variable set RESOURCEGROUPPREFIX -b 'rg_function_cosmos_gha'
gh secret set APP_NAME -b '<yourInitials>-functiong'
gh secret set KEYVAULT_OWNER_USERID -b '<owner1SID>'
```

---

## References

[Deploying ARM Templates with GitHub Actions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-github-actions)
[GitHub Secrets CLI](https://cli.github.com/manual/gh_secret_set)
