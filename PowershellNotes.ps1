#Local Required Variables
$InfoServer = Read-Host 'Enter Hostname of your Engine tier server'
$Credentials = Get-Credential
$matchfolder = 'IBM\\InformationServer\\Server\\DSEngine\\bin\\'
$JobParamToSearch = Read-Host 'Enter the name of the parameter to search for' # APT_LASTDATEPROCESSED for example
$lstProjectsArg = "-lprojects"

#Variables Collected from Remote Server
$Drives = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock {(Get-PSDrive -PSProvider FileSystem).Root}
$dsjobPath = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($Drives,$matchfolder) foreach ($drive in $Drives){Get-ChildItem -Path $drive -Filter dsjob.exe -Recurse -ErrorAction SilentlyContinue -Force | Where-Object {$_.FullName -match $matchfolder} | % { $_.FullName}}} -ArgumentList $Drives,$matchfolder

#Get Projects List command str v1
$dsProjectsLst = invoke-command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath,$lstProjectsArg) & "$dsjobPath" $lstProjectsArg } -ArgumentList $dsjobPath,$lstProjectsArg -ErrorAction SilentlyContinue

#Get Jobs list command str -- $dsProject needs to be set by the WPF frame dropdown list that is populated by $dsProjectsLst
$dsJobsLst = invoke-command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath,$dsProject) & "$dsjobPath" -ljobs $dsProject } -ArgumentList $dsjobPath,$dsProject -ErrorAction SilentlyContinue

#Get params in given job str
$dsJobParams = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath,$dsProject,$dsJobs) & "$dsjobPath" -lparams $dsProject,$dsJobs } -ArgumentList $dsjobPath,$dsProject,$dsJobs -ErrorAction SilentlyContinue

#Check Jobs for Specific Parameter/Var
foreach ($dsJob in $dsJobsLst)
    {
        $dsJobParams = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath,$dsProject,$dsJob) & "$dsjobPath" -lparams $dsProject,$dsJob } -ArgumentList $dsjobPath,$dsProject,$dsJob -ErrorAction SilentlyContinue
        if ($dsJobParams -contains $JobParamToSearch)
            {
                Write-Host $dsJob
            }
        else {}
    }
