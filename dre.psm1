

function dre-add {
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $block

)



    function add-url {
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
        $title = node "$PSScriptRoot\GETtitle.js" $url
                    
        $title
    $Destination = "$home\links\$title.lnk"

    $sourcepath =$url 


    $WshShell = New-Object -comObject WScript.Shell

    $Shortcut = $WshShell.CreateShortcut("$Destination")

    $Shortcut.TargetPath = $sourcepath

    $Shortcut.save()

    }
    catch {
        $title = get-title
                    
        $Destination = "$home\LINKS\$title.lnk"

        $sourcepath =$url 


        $WshShell = New-Object -comObject WScript.Shell
        
        $Shortcut = $WshShell.CreateShortcut("$Destination")
        
        $Shortcut.TargetPath = $sourcepath
        
        $Shortcut.save()
        
    }

    }
    function add-file {
        [CmdletBinding()]
        param (
            [Parameter()]
            [string]
            $filepath
        )
           
        
       $newpath= Get-Item $filepath
               
               
       $name =$newpath.name
       $Destination ="$home\Favorites\$name.lnk"
       
       
       
       
       $WshShell = New-Object -comObject WScript.Shell
       
       $Shortcut = $WshShell.CreateShortcut("$Destination")
       
       $Shortcut.TargetPath = $filepath 
       
       $Shortcut.save()
       }
       if (
           $block -like "https://*" -or $block -like "http://*"
       ) {
           add-url -url $block
       }
       else {
           add-shortcut -filepath $block
       }
       
       }




<#【云】上传件笔记#>
function dre-note {
[CmdletBinding()]
param (
[Parameter()]
[string]
$note 


)

$api_dev_key = 'CB6ywkdkm88krsDsG1AIMuMJQG6o1apS'
$api_paste_code = $note
$api_option = 'paste'

$uri = "https://pastebin.com/api/api_post.php"

# Create the body for the POST request
$body = @{
    api_dev_key     = $api_dev_key
    api_paste_code  = $api_paste_code
    api_option      = $api_option
}

# Send the POST request
$response = Invoke-RestMethod -Uri $uri -Method Post -Body $body

# Output the response
$response




}

<#【云】上传文件云端#>
<#

## 发送信息到设备
function dre-text {
 [CmdletBinding()]
 param (
     [Parameter()]
     [psobject]
     $message
 )
    
 $path  = "$home\share"
 for (($id=0),($for=$true);$for;) {
     if (test-path "$home\share\history\txt\history($id).txt") {
      
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
 
   
   
  


  
New-Item  "$home\share\.newtxt.txt"
Add-Content "$home\share\.newtxt.txt"  $message 

}
#>
<#
发送文件到云端服务器，提供下载，分享
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
            if (test-path "$home\share\history\pic\history($id).png") {
             
            $id++
           
            }
            else {
            $for = $false   
    
            $name =  "history($id).png"
      
    
            try {
                Move-Item $home\share\.newpic.png $home\share\history\pic\$name
            }
            catch {
               
            }
    
      
     
    
           
    
    
            }
    
           
           }
    
           Move-Item $path $home\share\.newpic.png
     }   

     elseif ($path -like "*.jpg") {
        for (($id=0),($for=$true);$for;) {
            if (test-path "$home\share\history\pic\history($id).png") {
             
            $id++
           
            }
            else {
            $for = $false   
            $id
            $name =  "history($id).png"
      Move-Item $home\share\.newpic.png $home\share\history\pic\$name
            }
           }
        Move-Item $path $home\share\.newpic.png
        
        
    } Else {
    
    Move-Item $path $home\share\
    
    
    }

}

else {

    Write-Host 'dosent exist'
}
 
 }
#>

