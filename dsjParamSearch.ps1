<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Datastage Parameter Search Tool
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$DS_Job_Parameter_Search         = New-Object system.Windows.Forms.Form
$DS_Job_Parameter_Search.ClientSize  = '400,600'
$DS_Job_Parameter_Search.text    = "Datastage Job Parameter Search"
$DS_Job_Parameter_Search.BackColor  = "#ffffff"
$DS_Job_Parameter_Search.TopMost  = $false

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Enter Engine Tier Hostname:"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(213,5)
$Label1.Font                     = 'Microsoft Sans Serif,10'

$InfoServerNameBox               = New-Object system.Windows.Forms.TextBox
$InfoServerNameBox.multiline     = $false
$InfoServerNameBox.width         = 175
$InfoServerNameBox.height        = 20
$InfoServerNameBox.location      = New-Object System.Drawing.Point(213,27)
$InfoServerNameBox.Font          = 'Microsoft Sans Serif,10'

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Project:"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(213,52)
$Label2.Font                     = 'Microsoft Sans Serif,10'

$ProjectsListBox                 = New-Object system.Windows.Forms.ComboBox
$ProjectsListBox.width           = 175
$ProjectsListBox.height          = 20
$ProjectsListBox.location        = New-Object System.Drawing.Point(213,72)
$ProjectsListBox.Font            = 'Microsoft Sans Serif,10'

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Username:"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(10,5)
$Label3.Font                     = 'Microsoft Sans Serif,10'

$UserNameBox                     = New-Object system.Windows.Forms.TextBox
$UserNameBox.multiline           = $false
$UserNameBox.width               = 100
$UserNameBox.height              = 20
$UserNameBox.location            = New-Object System.Drawing.Point(10,27)
$UserNameBox.Font                = 'Microsoft Sans Serif,10'

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "Password:"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(10,52)
$Label4.Font                     = 'Microsoft Sans Serif,10'

$PasswordBox                     = New-Object system.Windows.Forms.MaskedTextBox
$PasswordBox.multiline           = $false
$PasswordBox.width               = 100
$PasswordBox.height              = 20
$PasswordBox.visible             = $true
$PasswordBox.location            = New-Object System.Drawing.Point(10,72)
$PasswordBox.Font                = 'Microsoft Sans Serif,10'

$ConnectButton                   = New-Object system.Windows.Forms.Button
$ConnectButton.text              = "Connect"
$ConnectButton.width             = 65
$ConnectButton.height            = 60
$ConnectButton.location          = New-Object System.Drawing.Point(128,30)
$ConnectButton.Font              = 'Microsoft Sans Serif,10'

$Label5                          = New-Object system.Windows.Forms.Label
$Label5.text                     = "Parameter Name:"
$Label5.AutoSize                 = $true
$Label5.width                    = 25
$Label5.height                   = 10
$Label5.location                 = New-Object System.Drawing.Point(11,105)
$Label5.Font                     = 'Microsoft Sans Serif,10'

$ParamToSearchTextBox            = New-Object system.Windows.Forms.TextBox
$ParamToSearchTextBox.multiline  = $false
$ParamToSearchTextBox.width      = 257
$ParamToSearchTextBox.height     = 20
$ParamToSearchTextBox.location   = New-Object System.Drawing.Point(132,105)
$ParamToSearchTextBox.Font       = 'Microsoft Sans Serif,10'

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Search"
$Button2.width                   = 60
$Button2.height                  = 35
$Button2.location                = New-Object System.Drawing.Point(327,135)
$Button2.Font                    = 'Microsoft Sans Serif,10'

$JobsListBox                     = New-Object system.Windows.Forms.ListBox
$JobsListBox.text                = "listBox"
$JobsListBox.width               = 378
$JobsListBox.height              = 410
$JobsListBox.location            = New-Object System.Drawing.Point(11,180)

$UpdateButton                    = New-Object system.Windows.Forms.Button
$UpdateButton.text               = "Update Cache"
$UpdateButton.width              = 115
$UpdateButton.height             = 35
$UpdateButton.location           = New-Object System.Drawing.Point(200,135)
$UpdateButton.Font               = 'Microsoft Sans Serif,10'

$Label6                          = New-Object system.Windows.Forms.Label
$Label6.text                     = "Last Updated:"
$Label6.AutoSize                 = $true
$Label6.width                    = 25
$Label6.height                   = 10
$Label6.location                 = New-Object System.Drawing.Point(11,135)
$Label6.Font                     = 'Microsoft Sans Serif,10'

$CacheDateText                   = New-Object system.Windows.Forms.Label
$CacheDateText.AutoSize          = $true
$CacheDateText.width             = 25
$CacheDateText.height            = 10
$CacheDateText.location          = New-Object System.Drawing.Point(105,135)
$CacheDateText.Font              = 'Microsoft Sans Serif,10'

$ConnectionStatus                = New-Object system.Windows.Forms.Label
$ConnectionStatus.text           = "status"
$ConnectionStatus.AutoSize       = $true
$ConnectionStatus.visible        = $false
$ConnectionStatus.width          = 25
$ConnectionStatus.height         = 10
$ConnectionStatus.location       = New-Object System.Drawing.Point(128,5)
$ConnectionStatus.Font           = 'Microsoft Sans Serif,10'
$ConnectionStatus.ForeColor      = "#ff0000"

$CacheProgressBar                = New-Object system.Windows.Forms.ProgressBar
$CacheProgressBar.width          = 177
$CacheProgressBar.height         = 11
$CacheProgressBar.value          = 0
$CacheProgressBar.location       = New-Object System.Drawing.Point(11,159)

$DS_Job_Parameter_Search.controls.AddRange(@($Label1,$InfoServerNameBox,$Label2,$ProjectsListBox,$Label3,$UserNameBox,$Label4,$PasswordBox,$ConnectButton,$Label5,$ParamToSearchTextBox,$Button2,$JobsListBox,$UpdateButton,$Label6,$CacheDateText,$ConnectionStatus,$CacheProgressBar))

$ConnectButton.Add_MouseClick({ Connect-Server($user,$PWord,$InfoServer) })
$ProjectsListBox.Add_SelectedValueChanged({ Get-Cache($cacheFile) })
$UpdateButton.Add_MouseClick({ Set-Cache($InfoServer,$Credentials,$dsjobPath,$dsProject) })
$Button2.Add_MouseClick({ Get-JobsWithParamMatch($dsJobsParameters,$JobParamToSearch) })

function Get-JobsWithParamMatch($dsJobsParameters,$JobParamToSearch) { }
#Form Corrections
$PasswordBox.PasswordChar = '*'


#Write your logic code here
#Static Variables
$matchfolder = 'IBM\\InformationServer\\Server\\DSEngine\\bin\\'


#Functions
function Connect-Server($user,$PWord,$InfoServer)
    {
        $user = $env:USERDOMAIN + '\' + $UserNameBox.text
        $PWord = ConvertTo-SecureString -String $PasswordBox.text -AsPlainText -Force
        $InfoServer = $InfoServerNameBox.text
        $GLOBAL:Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
        $Connection = IF(Test-WSMan -ComputerName $InfoServer -Credential $Credentials -Authentication default -ErrorAction SilentlyContinue){$True}else{$False}
        $JobsListBox.Items.Clear()
        IF($Connection)
            {
                $ConnectionStatus.ForeColor = "#7ed321"
                $ConnectionStatus.text = "Connected"
                $ConnectionStatus.visible = $true
                $GLOBAL:InstallPath = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock {(Get-ItemProperty -Path 'HKLM:\Software\Wow6432Node\IBM\InformationServer\CurrentVersion\' -Name ASBHome).ASBHome -replace "ASBNode","Server\DSEngine\bin" -replace '\\','\\'}
                $GLOBAL:dsjobPath = $InstallPath+"\\dsjob.exe"
                Get-ProjectsList($InfoServer,$Credentials,$dsjobPath)
            }
        ELSE
            {
                $ConnectionStatus.ForeColor = "#ff0000"
                $ConnectionStatus.text = "Failed"
                $ConnectionStatus.visible = $true
            }
    }

function Get-Cache($cacheFile) 
    {
        $dsProject = $ProjectsListBox.SelectedItem
        $cacheFile = $env:TEMP+'\'+$dsProject+'_dsJobsParameters.xml'
        If (Test-Path $cacheFile)
            {
                $GLOBAL:dsJobsParameters = Import-Clixml $cacheFile
                $cacheFileDetails = Get-Item $cacheFile
                $CacheDateText.text = $cacheFileDetails.LastWriteTime.ToString("M/d/yyyy HH:MM")
                foreach ($jName in ($dsJobsParameters.Keys | Sort-Object))
                    {
                        $JobsListBox.Items.Add($jName)
                    }
            }
        Else
            {
                $GLOBAL:dsJobsParameters = @{}
                $CacheDateText.text = ""
                $JobsListBox.Items.Clear()
            }
    }

function Set-Cache($InfoServer,$Credentials,$dsjobPath,$dsProject)
    {
        $InfoServer = $InfoServerNameBox.text
        $Credentials = $GLOBAL:Credentials
        $dsjobPath = $GLOBAL:dsjobPath
        $dsProject = $ProjectsListBox.SelectedItem
        $GLOBAL:cacheFile = $env:TEMP+'\'+$dsProject+'_dsJobsParameters.xml'
        $GLOBAL:dsJobsParameters = @{}
        $GLOBAL:dsJobsLst = invoke-command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath,$dsProject) & "$dsjobPath" -ljobs $dsProject } -ArgumentList $dsjobPath,$dsProject -ErrorAction SilentlyContinue
        $CacheProgressBar.value = 0
        $CacheProgressBar.Minimum = 0
        $CacheProgressBar.Maximum = $dsJobsLst.count
        $CacheDateText.text = "Updating..."
        foreach ($dsJob in $dsJobsLst)
            {
                $dsJobParams = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath,$dsProject,$dsJob) & "$dsjobPath" -lparams $dsProject,$dsJob } -ArgumentList $dsjobPath,$dsProject,$dsJob -ErrorAction SilentlyContinue
                
                $dsJobsParameters[$dsJob]=$dsJobParams
                $CacheProgressBar.value ++
            }
        Export-Clixml -InputObject $dsJobsParameters -Path $cacheFile -Force
        $cacheFileDetails = Get-Item $cacheFile
        $CacheDateText.text = $cacheFileDetails.LastWriteTime.ToString("M/d/yyyy HH:MM")
        $CacheProgressBar.value = 0
        $JobsListBox.Items.Clear()
        foreach ($jName in ($dsJobsParameters.Keys | Sort-Object))
                    {
                        $JobsListBox.Items.Add($jName)
                    }
    }
    
function Get-JobsWithParamMatch($dsJobsParameters,$JobParamToSearch)
    {
        $dsJobsParameters = $GLOBAL:dsJobsParameters
        $JobParamToSearch = $ParamToSearchTextBox.text
        $JobsListBox.Items.Clear()
        if ($JobParamToSearch -eq "")
            {
                Get-Cache($cacheFile)
            }
        else
            {
                foreach ($jName in ($dsJobsParameters.Keys | Sort-Object))
                {
                    if($dsJobsParameters.$jName -Contains $JobParamToSearch)
                        {
                            $JobsListBox.Items.Add($jName)
                        }
                    else {}
                }
            }

    }


function Get-ProjectsList($InfoServer,$Credentials,$dsjobPath)
    {
        $InfoServer = $InfoServerNameBox.text
        $dsjobPath = $GLOBAL:dsjobPath
        $Credentials = $GLOBAL:Credentials
        $GLOBAL:dsProjectsLst = invoke-command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath) & "$dsjobPath" -lprojects } -ArgumentList $dsjobPath -ErrorAction SilentlyContinue
        $ProjectsListBox.Items.Clear()
        $ProjectsListBox.Text = ""
        foreach($item in $dsProjectsLst)
            {
                $ProjectsListBox.Items.Add($item.ToString())
            }
    }

    
#TO DO
[void]$DS_Job_Parameter_Search.ShowDialog()
