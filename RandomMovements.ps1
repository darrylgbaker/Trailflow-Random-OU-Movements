#################################################################################
# RandomMovements.ps1 v.1                                                       #
#                                                                               #
#  RandomMovements.PS1 is intended to generate activity in Active Directory     #
#                                                                               #
#                     WRITTEN BY: Darryl G. Baker, CISSP, CCSP                  #
#                                     for                                       #
#                         ALSID for AD Sandbox Environments                     #
#################################################################################





Set-ExecutionPolicy Bypass


function MoveUsers{
    $user = Get-ADuser -Filter * -Properties * | Get-Random 
    $user | Move-ADObject -TargetPath "OU=Domain Controllers,DC=alsid,DC=corp"
    
    }


function MoveComputers{
    $computer = Get-ADComputer -Filter "name -ne 'dc-vm'" | Get-Random 
    $computer | Move-ADObject -TargetPath "CN=Users,DC=alsid,DC=corp"
    
    }


function MoveClean{
    Get-ADUser -SearchBase "OU=Domain Controllers,DC=alsid,DC=corp" -Filter * | Move-ADObject -TargetPath "OU=Alsid,DC=alsid,DC=corp"
    Get-ADComputer -SearchBase "CN=Users,DC=alsid,DC=corp" -Filter * | Move-ADObject -TargetPath "CN=Computers,DC=alsid,DC=corp"
    }

try{
    Get-ADComputer computer-50
    }
Catch
    {
     1..50 | %{New-ADComputer -Name ('computer-' + $_)
     Start-Sleep -Seconds 10
        }
    }

MoveClean

1..10 | %{
    MoveUsers
    Start-Sleep -Seconds 5
    MoveComputers
    }



