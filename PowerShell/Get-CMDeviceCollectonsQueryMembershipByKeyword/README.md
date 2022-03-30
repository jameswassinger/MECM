# Get-CMDeviceCollectonsQueryMembershipByKeyword

## Synopsis
Get device collections with Query Expressions containing a keyword. 

## Parameters

```
SiteCode
```

Site code for MECM

```
ProviderMachineName
```

Server name for MECM

```
QueryKeyword
```

Keyword to search for within the QueryExpression

```
CollectionKeyword
```

Filter the device collections by keyword

## Examples

### Example 1

```
Get-CMDeviceCollectonsQueryMembershipByKeyword.ps1 -SiteCode ABC -ProviderMachineName contoso1 -QueryKeyword "SystemOUName"
```

### Example 2

```
Get-CMDeviceCollectonsQueryMembershipByKeyword.ps1 -SiteCode ABC -ProviderMachineName contoso1 -QueryKeyword "SystemOUName" -CollectionKeyword "XYZ"
```

