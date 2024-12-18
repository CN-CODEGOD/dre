$origEncoding = [Console]::OutputEncoding
try {
   
 $title = node "C:\Users\Adminnistrator\my-modules\dre\GETtitle3.js" "https://www.bilibili.com/"
}
finally {
    [Console]::OutputEncoding = $origEncoding
}

$title
