
# Format-SystemListQuery

## Synopsis
Takes a list of computer names and auto generates a query to use with a MECM device collection. 

## Parameters

Sets the file path to a text file of list of computer names. 

```
Path
```
Sets the file path to use to output the results to.

```
OutFile
```

Sets an array of computer names to use in query.

```
ComputerName
```

## Example

### Example 1
```
Format-SystemListQuery.ps1 -ComputerName COM1,COM2,COM3 -OutFile C:\Temp\SystemNameQuery.txt
```

### Example 2
```
Format-SystemListQuery.ps1 -Path C:\temp\computernames.txt -OutFile C:\Temp\SystemNameQuery.txt
```

