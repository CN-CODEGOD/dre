

function dre-add  {
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $inputwtk
)

class type {
    [string]$inputwtk


    static [string] get_type([string]$inputwtk) {

        if ($inputwtk -like "https://*") {
            
return "url"


        }

   elseif ($inputwtk -like "http://*"
   )
   {

    return "url"
   }


   else {

    return "shortcut"
   }
   


    }

    
}

function shortcut  {
 [CmdletBinding()]
 param (
     [Parameter(mandatory)]
     [string]
     $path
   
    )
    
    
    
    
    
        
    $newpath= Get-Item $path
        
        
    $name =$newpath.name
    $Destination ="C:\Users\Administrator\Favorites\$name.lnk"

    
    
    
    $WshShell = New-Object -comObject WScript.Shell
    
    $Shortcut = $WshShell.CreateShortcut("$Destination")
    
    $Shortcut.TargetPath = $path 
    
    $Shortcut.save()
 


    
}

        function url  {
            [CmdletBinding()]
            param ( 
                [Parameter()]
                [string]
                $url
                )

                function get-title {
            [CmdletBinding()]
            param (
                [Parameter(Mandatory)]
                [string]
                $title
            )
                    $title
                }
                try {
                    $title = node "C:\Users\Administrator\dre\dre\GETtitle.js" $url
                    $title=$title[1]  
                $Destination = "C:\Users\Administrator\favorites\$title.lnk"
        
                $sourcepath =$url 
    
    
                $WshShell = New-Object -comObject WScript.Shell
                
                $Shortcut = $WshShell.CreateShortcut("$Destination")
                
                $Shortcut.TargetPath = "$sourcepath"
                
                $Shortcut.save()
                
        
                }
                catch {
                  $title = get-title
                  
                  $Destination = "C:\Users\Administrator\favorites\$title.lnk"
        
                  $sourcepath =$url 
      
      
                  $WshShell = New-Object -comObject WScript.Shell
                  
                  $Shortcut = $WshShell.CreateShortcut("$Destination")
                  
                  $Shortcut.TargetPath = "$sourcepath"
                  
                  $Shortcut.save()
                  
                }
     
            

        }

switch ([type]::get_type($inputwtk)) {
    url { url -url $inputwtk  }
    shortcut {shortcut -path $inputwtk}
}


    

}



function dre-wallpaper {

[CmdletBinding()]
param (
[Parameter()]
[string]
$path 



)

$newpath= Get-ChildItem $path
$name = $newpath.name

$Destination ="c:\Users\Administrator\Favorites\$name.lnk"

$sourcepath =  "D:\Program Files\steam\steamapps\common\wallpaper_engine\wallpaper64.exe"


$WshShell = New-Object -comObject WScript.Shell

$Shortcut = $WshShell.CreateShortcut("$Destination")

$Shortcut.TargetPath = "$sourcepath"
$Shortcut.Arguments ="-control openWallpaper -file `"$path`""
$Shortcut.save()



}






function dre-note {
[CmdletBinding()]
param (
[Parameter()]
[string]
$note 

)





}


function dre-share {
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Path 


)
try {
    Move-Item $path $HOME\share 
}
catch {
    Write-Host "error ,incorrect or repeat"

}
}

function dre-text {
 [CmdletBinding()]
 param (
     [Parameter()]
     [psobject]
     $message
 )
    
 $path  = "C:\Users\Administrator\share"
 for (($id=0),($for=$true);$for;) {
     if (test-path "C:\Users\Administrator\share\history\txt\history($id).txt") {
      
     $id++
    
     }
     else {
     $for = $false   
 $id
     $name =  "history($id).txt"
         rename-Item $path\.newtxt.txt $name
    Move-Item $path\$name $path\history\txt 
     }
    }
 
   
   
  


  
New-Item  "C:\Users\Administrator\share\.newtxt.txt"
Add-Content "C:\Users\Administrator\share\.newtxt.txt"  $message 

}
function dre-share {
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $path

)

if (Test-Path $path) 
{

    if ($path -like "*.png") {

        for (($id=0),($for=$true);$for;) {
            if (test-path "C:\Users\Administrator\share\history\pic\history($id).png") {
             
            $id++
           
            }
            else {
            $for = $false   
    
            $name =  "history($id).png"
      
    
            try {
                Move-Item C:\Users\Administrator\share\.newpic.png C:\Users\Administrator\share\history\pic\$name
            }
            catch {
               
            }
    
      
     
    
           
    
    
            }
    
           
           }
    
           Move-Item $path C:\Users\Administrator\share\.newpic.png
     }   

     elseif ($path -like "*.jpg") {
        for (($id=0),($for=$true);$for;) {
            if (test-path "C:\Users\Administrator\share\history\pic\history($id).png") {
             
            $id++
           
            }
            else {
            $for = $false   
            $id
            $name =  "history($id).png"
      Move-Item C:\Users\Administrator\share\.newpic.png C:\Users\Administrator\share\history\pic\$name
            }
           }
        Move-Item $path C:\Users\Administrator\share\.newpic.png
        
        
    } Else {
    
    Move-Item $path C:\Users\Administrator\share\
    
    
    }

}

else {

    Write-Host 'dosent exist'
}
 
 }