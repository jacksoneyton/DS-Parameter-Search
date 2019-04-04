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
$ConnectButton.location          = New-Object System.Drawing.Point(128,27)
$ConnectButton.Font              = 'Microsoft Sans Serif,10'

$Label5                          = New-Object system.Windows.Forms.Label
$Label5.text                     = "Parameter Name:"
$Label5.AutoSize                 = $true
$Label5.width                    = 25
$Label5.height                   = 10
$Label5.location                 = New-Object System.Drawing.Point(11,105)
$Label5.Font                     = 'Microsoft Sans Serif,10'

$TextBox3                        = New-Object system.Windows.Forms.TextBox
$TextBox3.multiline              = $false
$TextBox3.width                  = 257
$TextBox3.height                 = 20
$TextBox3.location               = New-Object System.Drawing.Point(132,105)
$TextBox3.Font                   = 'Microsoft Sans Serif,10'

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Search"
$Button2.width                   = 60
$Button2.height                  = 30
$Button2.location                = New-Object System.Drawing.Point(328,130)
$Button2.Font                    = 'Microsoft Sans Serif,10'

$ListBox1                        = New-Object system.Windows.Forms.ListBox
$ListBox1.text                   = "listBox"
$ListBox1.width                  = 378
$ListBox1.height                 = 410
$ListBox1.location               = New-Object System.Drawing.Point(11,180)

$DS_Job_Parameter_Search.controls.AddRange(@($Label1,$InfoServerNameBox,$Label2,$ProjectsListBox,$Label3,$UserNameBox,$Label4,$PasswordBox,$ConnectButton,$Label5,$TextBox3,$Button2,$ListBox1))

$ProjectsListBox.Add_MouseClick({ Get-ProjectsList($InfoServer,$Credentials,$dsjobPath) })
$ConnectButton.Add_MouseClick({ Connect-Server($user,$PWord,$InfoServer) })

#Form Corrections
$PasswordBox.PasswordChar = '*'


#Write your logic code here
#Static Variables
$matchfolder = 'IBM\\InformationServer\\Server\\DSEngine\\bin\\'


#Functions
Function Connect-Server($user,$PWord,$InfoServer)
    {
        $user = $env:USERDOMAIN + '\' + $UserNameBox.text
        $PWord = ConvertTo-SecureString -String $PasswordBox.text -AsPlainText -Force
        $InfoServer = $InfoServerNameBox.text
        $GLOBAL:Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
        $Connection = IF(Test-WSMan -ComputerName $InfoServer -Credential $Credentials -Authentication default -ErrorAction SilentlyContinue){$True}else{$False}
        IF($Connection)
            {
                $ConnectButton.BackColor = "#7ed321"
                $ConnectButton.text = "Success"
            }
        ELSE
            {
                $ConnectButton.BackColor = "#ff0000"
                $ConnectButton.text = "Failed"
            }
    }

#TO DO
Function Get-ProjectsList($InfoServer,$Credentials,$dsjobPath)
    {
        $InfoServer = $InfoServerNameBox.text
        $Credentials = $GLOBAL:Credentials
        $Drives = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock {(Get-PSDrive -PSProvider FileSystem).Root}
        $dsjobPath = Invoke-Command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($Drives,$matchfolder) foreach ($drive in $Drives){Get-ChildItem -Path $drive -Filter dsjob.exe -Recurse -ErrorAction SilentlyContinue -Force | Where-Object {$_.FullName -match $matchfolder} | % { $_.FullName}}} -ArgumentList $Drives,$matchfolder
        $GLOBAL:dsProjectsLst = invoke-command -ComputerName $InfoServer -Credential $Credentials -ScriptBlock { param ($dsjobPath) & "$dsjobPath" -lprojects } -ArgumentList $dsjobPath -ErrorAction SilentlyContinue
        foreach($item in ($dsProjectsLst | Get-Member -MemberType Property))
            {
                $ProjectsListBox.Items.Add($item)
            }
    }
[void]$DS_Job_Parameter_Search.ShowDialog()
