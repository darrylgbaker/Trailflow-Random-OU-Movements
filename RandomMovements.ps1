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




# SIG # Begin signature block
# MIIFjgYJKoZIhvcNAQcCoIIFfzCCBXsCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUVZNai6Hw4Nl4/EkwhdU27gGw
# kGigggMeMIIDGjCCAgKgAwIBAgIQJRUJqx092r9F03ou9FcfMzANBgkqhkiG9w0B
# AQsFADAlMSMwIQYDVQQDDBpEYXJyeWwgRyBCYWtlciwgQWxzaWQgMjAyMDAeFw0y
# MDEwMTYxODUxMjlaFw0yMTEwMTYxOTExMjlaMCUxIzAhBgNVBAMMGkRhcnJ5bCBH
# IEJha2VyLCBBbHNpZCAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
# AQEAwMsUQLKCunbDH8pizyB8/lNWGbp6FZhKzop8FYp4ABLnzMxxbdefH+cLeQzF
# 5CNaWqDq4lC5ONaizjTuEsIHCGjnyFsuByhoywDzIKtD4ZcdYxYbqf/B5q9tb5Sv
# bt+5Ct+ZLlBw2bGcPT1VHV5fiiZQUtEriIfmGW2hPN7vcFAK73xIK+vTH85+AvoA
# S96F6DmwpInk8B5Q1x2UFB5LvRT5tEz+JxxhUpb3eFfzAPs4dmfkR0oVU/mN4t/6
# D0UkHuW23GSlaV79QKIkv97kYqAhOMTGDW29ijZqVOh3Wc6iCY+w9ctvb0Pu0pd9
# 3KKSn7FgzycMphoWKrtSU9286QIDAQABo0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYD
# VR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0OBBYEFHssfTXcr1NvhPfvnM303H2uIkPA
# MA0GCSqGSIb3DQEBCwUAA4IBAQARBo4qQCDa7RiHFpIfHyjPKRf5XVFl9WvAP44c
# rjDu6D5ym7TycKLPD1tI1nL1l00K8XOERuga6RQpgtzcRE8R3z3sKCu/PuRf+602
# 9h7dTGMJmnZsnmSAOSBfNENEl642B9Y4/lAWfVMMRVgwvX6tbRHLHPSuKBUl7/sn
# acERSr6yKbUfC1b/DTP9EzYm6PDRXwX5d2T50kmASXLPv6thO6JCBC5f9Uj25EWo
# TLWPS6EhlAlZhL1Rw/huSd6LIh4OxzqgzFmLeNqRH17hAgTqp0IEwdDJWhoUud8p
# OXo06+PyeEBKesEo4cWEh4aC3QGdLdhPvQery78Xd0CSy/6OMYIB2jCCAdYCAQEw
# OTAlMSMwIQYDVQQDDBpEYXJyeWwgRyBCYWtlciwgQWxzaWQgMjAyMAIQJRUJqx09
# 2r9F03ou9FcfMzAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKA
# ADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYK
# KwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUP94D0OeUJC7+gYiRNO3ghrWqvJUw
# DQYJKoZIhvcNAQEBBQAEggEAmftTJq6YVm3obpAveKtzydMZXNf0/FuS46tL8H7E
# qOtnM2zJh/gDh/276uXLhmxk+SESL/9yGPGgOJbw1D8QmczedEH00vgCVRi49PDW
# kXlzE2pY+XUAse2wjt1kDdVVmqi/FnaU8V4RGvlv5VM4vPzL1KjpFLEwb3fQG61g
# UeXQKJy7ZbNmr0HPaTYRqYpwDN0GHDFvLbfDeqUupf91ltcN1eGG8TSwUT+MnUZv
# g1idvi1fxkMsc8q8pyamwWqi8KcZU86Depse92VojqJ+AuOE4urNBVxvHGKrGBDM
# l3yWw8EtdU6iQDGcRsoKA/fYab8kT0vTQKSfPO7AALHWlg==
# SIG # End signature block
