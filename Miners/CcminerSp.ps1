﻿using module ..\Include.psm1

$Path = ".\Bin\NVIDIA-SP\ccminer.exe"
$Uri = "https://github.com/sp-hash/ccminer/releases/download/1.5.81/release81.7z"

$Commands = [PSCustomObject]@{
    #"bitcore" = "" #Bitcore
    #"blake2s" = "" #Blake2s
    #"blakecoin" = "" #Blakecoin
    #"vanilla" = "" #BlakeVanilla
    #"c11" = "" #C11 ccmineralexis78 better
    #"cryptonight" = "" #CryptoNight
    #"decred" = "" #Decred
    #"equihash" = "" #Equihash
    #"ethash" = "" #Ethash
    #"groestl" = "" #Groestl
    #"hmq1725" = "" #HMQ1725
    #"jha" = "" #JHA
    #"keccak" = "" #Keccak
    #"lbry" = "" #Lbry
    #"lyra2v2" = "" #Lyra2RE2
    #"lyra2z" = "" #Lyra2z
    #"myr-gr" = "" #MyriadGroestl
    #"neoscrypt" = "" #NeoScrypt
    #"nist5" = "" #Nist5
    #"pascal" = "" #Pascal
    #"phi" = "" #PHI
    #"sib" = "" #Sib
    "skein" = "" #Skein
    #"skunk" = "" #Skunk
    #"timetravel" = "" #Timetravel
    #"tribus" = "" #Tribus
    #"veltor" = "" #Veltor
    #"x11evo" = "" #X11evo
    #"x17" = " -i 20" #X17 ccmineralexis78 better
    #"yescrypt" = "" #Yescrypt
    #"xevan" = "" #Xevan
}

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | Where-Object {$Pools.(Get-Algorithm $_).Protocol -eq "stratum+tcp" <#temp fix#>} | ForEach-Object {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "-a $_ -o $($Pools.(Get-Algorithm $_).Protocol)://$($Pools.(Get-Algorithm $_).Host):$($Pools.(Get-Algorithm $_).Port) -u $($Pools.(Get-Algorithm $_).User) -p $($Pools.(Get-Algorithm $_).Pass) -b 4068$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm $_) = $Stats."$($Name)_$(Get-Algorithm $_)_HashRate".Week}
        API = "Ccminer"
        Port = 4068
        URI = $Uri
    }
}
