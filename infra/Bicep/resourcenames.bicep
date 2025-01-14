// --------------------------------------------------------------------------------
// Bicep file that builds all the resource names used by other Bicep templates
// --------------------------------------------------------------------------------
param appName string = ''
@allowed(['azd','gha','azdo','dev','demo','qa','stg','ct','prod'])
param environmentCode string = 'azd'

param functionStorageNameSuffix string = 'func'
param dataStorageNameSuffix string = 'data'

param functionName string = ''

// --------------------------------------------------------------------------------
var lowerAppName = replace(toLower(appName), ' ', '')
var sanitizedAppName = replace(replace(lowerAppName, '-', ''), '_', '')
var sanitizedEnvironment = toLower(environmentCode)

// --------------------------------------------------------------------------------
// other resource names can be changed if desired, but if using the "azd deploy" command it expects the
// function name to be exactly "{appName}function" so don't change the functionAppName format if using azd
var functionAppName = environmentCode == 'azd' ? '${lowerAppName}function' : toLower('${lowerAppName}-${functionName}-${sanitizedEnvironment}')
var baseStorageName = toLower('${sanitizedAppName}${sanitizedEnvironment}str')

// --------------------------------------------------------------------------------
output logAnalyticsWorkspaceName string =  toLower('${lowerAppName}-${sanitizedEnvironment}-logworkspace')
output functionAppName string            = functionAppName
output functionAppServicePlanName string = '${functionAppName}-appsvc'
output functionInsightsName string       = '${functionAppName}-insights'

output cosmosAccountName string = '${sanitizedAppName}-cosmos-${sanitizedEnvironment}'
output serviceBusName string =    '${sanitizedAppName}-svcbus-${sanitizedEnvironment}'

// Key Vaults and Storage Accounts can only be 24 characters long
output keyVaultName string               = take(toLower('${sanitizedAppName}${sanitizedEnvironment}vault'), 24)
output functionStorageName string        = take('${baseStorageName}${functionStorageNameSuffix}${uniqueString(resourceGroup().id)}', 24)
output dataStorageName string            = take('${baseStorageName}${dataStorageNameSuffix}${uniqueString(resourceGroup().id)}', 24)
