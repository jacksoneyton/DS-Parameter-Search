#Local Required Variables
$InfoServer = Read-Host 'Enter Hostname of your Engine tier server'
$Credentials = Get-Credential
$matchfolder = 'IBM\\InformationServer\\Server\\DSEngine\\bin\\'
$JobParamToSearch = Read-Host 'Enter the name of the parameter to search for' # APT_LASTDATEPROCESSED for example
$lstProjectsArg = "-lprojects"

#Variables Collected from Remote Server
$Drives = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock {(Get-PSDrive -PSProvider FileSystem).Root}
$dsjobPath = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($Drives,$matchfolder) foreach ($drive in $Drives){Get-ChildItem -Path $drive -Filter dsjob.exe -Recurse -ErrorAction SilentlyContinue -Force | Where-Object {$_.FullName -match $matchfolder} | % { $_.FullName}}} -ArgumentList $Drives,$matchfolder

#Sample Remote Execution Command
invoke-command -ComputerName Computer1 -Credential Get-Credential -ScriptBlock { & 'C:\Program Files\program.exe' -something "myArgValue" } 
invoke-command -ComputerName Computer1 -ScriptBlock { param ($myarg) & 'C:\Program Files\program.exe' -something $myarg } -ArgumentList "myArgValue"
start-process -filepath C:\folder\app.exe -argumentlist "/xC:\folder\file.txt"


#Get Projects List command str v1
$dsProjectsLst = invoke-command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath,$lstProjectsArg) & "$dsjobPath" $lstProjectsArg } -ArgumentList $dsjobPath,$lstProjectsArg -ErrorAction SilentlyContinue

#FAILED# #Get Projects List command str v2
#$dsProjectsLst = invoke-command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath) Start-Process -FilePath $dsjobPath -ArgumentList "-lprojects" } -ArgumentList $dsjobPath

#Get Jobs list command str -- $dsProject needs to be set by the WPF frame dropdown list that is populated by $dsProjectsLst
$dsJobsLst = invoke-command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath,$dsProject) & "$dsjobPath" -ljobs $dsProjectsLst } -ArgumentList $dsjobPath,$dsProject -ErrorAction SilentlyContinue
