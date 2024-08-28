#element class for point coordinate



class placecoordinate {
    [int]$x
    [int]$y
    [int]$z

    static [void]validate ([array]$coordinate){
        if ($coordinate.count -ne 3) {
            throw "the coordinate is valid,please input a (x,y,z),coordinate"
        }

        
    }
    placecoordinate([array]$placecoordinate){
        [placecoordinate]::validate($placecoordinate)
        $this.x=$placecoordinate[0]
        $this.y=$placecoordinate[1]
        $this.z=$placecoordinate[2]
    }
}
#element class for 
class roadcoordinate {
[int]$x
[int]$y
[int]$z
[int]$x1    
[int]$y1
[int]$z1
roadcoordinate([array]$roadcoordinate){

    $this.x=$roadcoordinate[0]
    $this.y=$roadcoordinate[1]
    $this.z=$roadcoordinate[2]
    $this.x1=$roadcoordinate[3]
    $this.y1=$roadcoordinate[4]
    $this.z1=$roadcoordinate[5]
}
}


class road {

   [roadcoordinate]$roadcoordinate
    [string]$name
    [dimention]$dimention
    [int]$id
static [void]validate([road]$road){

    $roads =Import-clixml c:\ex-sys\xml\roads.xml
$roads| foreach-object { 


if (($_.roadcoordinate.x..$_.roadcoordinate.x1).contains($road.roadcoordinate.x) -and ($_.roadcoordinate.x..$_.roadcoordinate.x1).contains($road.roadcoordinate.x1) -and ($_.roadcoordinate.y..$_.roadcoordinate.y1).contains($road.roadcoordinate.y) -and ($_.roadcoordinate.y..$_.roadcoordinate.y1).contains($road.roadcoordinate.y1) -and ($_.roadcoordinate.z..$_.roadcoordinate.z1).contains($road.roadcoordinate.z) -and ($_.roadcoordinate.z..$_.roadcoordinate.z1).contains($road.roadcoordinate.z1)) 
{
throw "路线重叠"
}   

}

    
}

## parameter class construct for add-place -road
    road (

 
    
    [roadcoordinate]$roadcoordinate
    ,   
    [dimention]$dimention
    ,
    [string]$name="无名路"
    )
    {
 $this.roadcoordinate=$roadcoordinate
    $this.dimention=$dimention
    $this.name=$name


0    }

    #paramter class construct for find-place -road and road-route -road


    road ([dimention]$dimention)
    {
        $this.dimention =$dimention

    }
    
## parameter class construct for remove-place -road
    road ([int]$id){
        $this.id =$id
    }
    

}

##  wynncraft_place class 
class wynncraft_place {
    [placecoordinate]$placecoordinate
    [int]$id
    [place_type]$type

    
    ##validate method for repeat adding
static [void]validate ([wynncraft_place]$wynncraft_place,[int]$distance_limit){

$wynncraft_places=Import-clixml c:\ex-sys\wynncraft_places.xml|Where-Object {$_.type -like $wynncraft_place.type}

$wynncraft_places|foreach-object {

    
}
$distance = [main]::calc($wynncraft_place,$_)

    if ($distance -gt $distance_limit) {
        throw "重复坐标"
    }




}   
## parameter class construct for add-place -wynncraft_place
wynncraft_place ([placecoordinate]$placecoordinate,[place_type]$type) {

    $this.placecoordinate=$placecoordinate
    $this.type =$type
}
## parameter class construct for find-place -wynncraft_place
wynncraft_place ([place_type]$type)
{
    $this.type =$type

}

## parameter class construct for remove-place -wynncraft_place


wynncraft_place ([int]$id){
    $this.id =$id
}
}

##class for survival_place
class survival_place {
  [placecoordinate]$placecoordinate
    [dimention]$dimention
    [place_type]$type
    [int]$id
#validation mathod for repeat adding
   static [void]validate ([survival_place]$survival_place,[int]$distance_limit){
        $survival_places = Import-clixml c:\ex-sys\xml\survival_places.xml|Where-Object {$_.type -like $survival_place.type -and $_.dimention -like $survival_place.dimention}
    
      $survival_places|foreach-object {
       $distance= [main]::calc($survival_place,$_)
        if ($distance -lt $distance_limit) {
            throw "坐标重复"
        }
        
      }


    }
    ## parameter class construct for add-place -survival_place
survival_place (
[placecoordinate]$placecoordinate
,
[dimention]$dimention
,
[place_type]$type

)


{

    $this.placecoordinate=$placecoordinate
    $this.dimention=$dimention
    $this.type=$type 
}

## parameter class construct for find-place -survival_place 
survival_place (
    [dimention]$dimention
    ,
    [place_type]$type
)
{
    $this.dimention=$dimention
    $this.type=$type

}
## parameter class construct for remove-place -survival_place 

survival_place ([int]$id){
    $this.id =$id
}

}
class teleportation_place {
  [placecoordinate]$placecoordinate
    [int]$id
    [string]$name
    #validate method for repeat adding
   static [void] validate([teleportation_place]$teleportation_place,[int]$distance_limit) 
    
    {

        $teleportation_places=Import-clixml c:\ex-sys\xml\teleportation_places.xml
        $distance_limit=50
  
        $teleportation_places| foreach-object {


            $distance=[main]::calc($teleportation_place,$_)


            if ($distance -gt $distance_limit) {
                throw "坐标重复"
            }
        }

       
    }
    ## parameter class construct for add-place -teleportation_place
    teleportation_place (
   [placecoordinate]$placecoordinate
        ,
    [string]$name
    ) {
       $this.placecoordinate=$placecoordinate
        $this.name=$name
    
    }
    ## parameter class construct for remove-place -teleportation_place 

    
    teleportation_place ([int]$id){
        $this.id =$id
    }

}
##class holder maplist for parameter 

Class maplist : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $maplist = (get-childitem c:\ex-sys\xml\gps ).basename
        return [string[]] $maplist
  }
}




##enum holder  placetype for parameter 

enum place_type {
    potion_merchant
    blackSmith
    scroll_merchant
    farm
    fishing
    tool_merchant
    
    mine
    identifier
    bank
    chest
    powder_master
    housing
 
    boat 
    woodland_mansion
    ocean_mountain
    pillager_outpost
    village
    portal
    fortress
    slime_chunk
    ravine
    ocean_ruins
    fossil
    Trail_Ruins
    roads
    stronghold
    Ancient_City
    Desert_Temple
    lgloo
    Biomes
    mineshaft
    shipwreck
    cave
    lava_pool
    Geode
    apple
    ore_veins
    Derset_wellwitch_hut
    nether_portal
}
   











#dimention parameter enum holder 
enum dimention{ 
nether
the_end
overworld

}



class main {

    #method for calc distance bewteen A and B
    static [int]calc (  
        [psobject]$place1,

    [psobject]$place2)

        
        
        {
        
            return [math]::sqrt(($place1.x-$place2.x )*($place1.x-$place2.x)+($place1.y-$place2.y)*($place1.y-$place2.y)+($place1.z-$place2.z)*($place1.z-$place2.z))
        }



##calc method for calc the teleportation route between destination and teleportation places
static [array]calcroute (
[placecoordinate]$mycoordinate
,
[teleportation_place]$teleportation_place
)
{

    $distance = [main]::calc($mycoordinate,$teleportation_place)
    

    return ($teleportation_place.name,$distance )


}
## calc method for calc road route between destination and road 
static [array]calcroute (
[placecoordinate]$mycoordinate
,
[roadcoordinate]$roadcoordinate


)
{ 
    



    
    $a = @{
        x=$roadcoordinate.x
        y=$roadcoordinate.y
        z=$roadcoordinate.z
    }
    $b = @{x= $roadcoordinate.x1
        y=$roadcoordinate.y1
        z=$roadcoordinate.z1
    }
    $p = $mycoordinate

$OP = [System.Numerics.Vector3]::new($p.x,$p.y,$p.z)
$v = [System.Numerics.Vector3]::new($b.x-$a.x,$b.y-$a.y,$b.z-$a.z)
$u= [System.Numerics.Vector3]::new($p.x-$a.x,$p.y-$a.y,$p.z-$a.z)

$oa =[System.Numerics.Vector3]::new($a.x,$a.y,$a.z)

$pp1 = [System.Numerics.Vector3]::new(-$v[2],$v[1],$v[0])

$distance = [math]::abs([System.Numerics.Vector3]::dot($u,$pp1))/$pp1.length()



$projectedpoint= $oa+$v*[system.Numerics.Vector3]::dot($v,$u)/[system.Numerics.Vector3]::dot($v,$v)


$distance= [main]::calc($projectedpoint,$mycoordinate) 



return ($roadcoordinate,$projectedpoint,$distance)
}



##find method for finding place near player

static[psobject] findplace(
[placecoordinate]$mycoordinate,
[wynncraft_place]$wynncraft_place


)

{ 

    
   $distance = [main]::calc($mycoordinate,$wynncraft_place.placecoordinate)

return @{

   x=$wynncraft_place.placecoordinate.x
   y=$wynncraft_place.placecoordinate.y
   z=$wynncraft_place.placecoordinate.z
   distance=$distance
   type=$wynncraft_place.type
}
}

static[psobject] findplace(
[placecoordinate]$mycoordinate,
[survival_place]$survival_place


)

{ 

    
   $distance = [main]::calc($mycoordinate,$survival_place.placecoordinate)

return @{

   x=$survival_place.placecoordinate.x
   y=$survival_place.placecoordinate.y
   z=$survival_place.placecoordinate.z
   distance=$distance
   type=$survival_place.type
   dimention=$survival_place.dimention
}
}
static[psobject] findplace(
[placecoordinate]$mycoordinate
,
[road]$road


)
{ 

    
    return([main]::calcroute($mycoordinate,$road.roadcoordinate),$road.name)

}
}


#main GPS parameter holder class


function find-place {


        <#
.SYNOPSIS
find-place 
-wynncraft_place (placetype) -mycoordinate ()

-survival_place (dimention,type) -mycoordinate

-road (dimention) -mycoordinate ()
.DESCRIPTION
GPS module function find-place 
find the structure near around you
.PARAMETER Path
.
.PARAMETER LiteralPath
.
.EXAMPLE
 find-place -wynncraft_place "bank" -mycoordinate (1,2,3)
.NOTES
placetype :
    potion_merchant
    blackSmith
    scroll_merchant
    farm
    fishing
    tool_merchant
    
    mine
    identifier
    bank
    chest
    powder_master
    housing
 
    boat 
    woodland_mansion
    ocean_mountain
    pillager_outpost
    village
    portal
    fortress
    slime_chunk
    ravine
    ocean_ruins
    fossil
    Trail_Ruins
    roads
    stronghold
    Ancient_City
    Desert_Temple
    lgloo
    Biomes
    mineshaft
    shipwreck
    cave
    lava_pool
    Geode
    apple
    ore_veins
    Derset_wellwitch_hut

    Dimention:
    nether
    the_end
    overworld

    Author: CN_CODEGOD
    Date: June 10, 2024


    #>



    [CmdletBinding()]
    param (
        [Parameter(parametersetname="wynncraft_place")]
        [wynncraft_place]
        $wynncraft_place
        ,
        # Parameter help description
        [Parameter(parametersetname="survival_place")]
        [survival_place]
        $survival_place
        ,
        # 
        [Parameter(parametersetname="road")]
        [road]
        $road
        ,
        # Parameter help description
        [Parameter()]
        [placecoordinate]
        $mycoordinate
    )
   
 
   
   
      
    switch ($pscmdlet.parametersetname) {
  ##parmeterset for find-place -wynncraft_place
       wynncraft_place { $wynncraft_places= Import-clixml c:\ex-sys\xml\wynncraft_places.xml|Where-Object { $_.type -like $wynncraft_place.type}
       
       


       $pair =$wynncraft_places|foreach-object {
        [main]::findplace($mycoordinate,$_)
       }|sort-object -Property distance -Descending |select-object -Last 1


       "最近的{0}离这里{1},坐标为:{2},{3},{4}" -f $pair.type ,$pair.distance,$pair.x,$pair.y,$piar.z
    
    }
    ##parmeterset for find-place -road
       road {$roads= Import-clixml c:\ex-sys\xml\roads.xml|Where-Object {$_.dimention -like $road.dimention}

       $pair= $roads|foreach-object {

[main]::findplace($mycoordinate,$_)|sort-object -Property distance -Descending |select-object -Last 1
"最近的{0}离这里{1},坐标为{2},{3},{4}" -f $pair[1],$pair[0].roadcoordinate.x,$pair[0].roadcoordinate.y,$pair[0].roadcoordinate.z

       }
   
}
##parmeterset for find-place -survival_place
   
       survival_place{$survival_places = Import-clixml c:\ex-sys\xml\survival_places.xml|Where-Object {$_.dimention -like $survival_place.dimention -and $_.type -like $survival_place.type}

       $survival_places|foreach-object {

       }
       }
##parmeterset for find-place -map
       map {
   $places = Import-clixml $map
       }

   }
   

  
  
   
   
   
             


    
}
  
    
          ##function to teleportation route
function teleportation-route {
 [CmdletBinding()]
 param (
     [Parameter()]
     [placecoordinate]
     $destination
 )

 $places = Import-clixml c:\ex-sys\xml\teleportation_places.xml
    
    $pair =  $places|foreach-object {
                $placecoordinate= [placecoordinate]::new($_.x,$_.y,$_.z)
                [main]::calcroute($destination,$placecoordinate)
             
            }|sort-object -Property distance -Descending |select-object -Last 1
       
       
            
           "最佳的路线为，传送到{0},{1}，再前往目的地" -f $pair[0],$pair[1]
    
     
        }
    
##function to road route

function road-route {
 [CmdletBinding()]
 param (
     [Parameter()]
     [road]
     $road
     ,
     # Parameter help description
     [Parameter()]
     [placecoordinate]
     $destination
 )

 $roads=Import-clixml c:\ex-sys\xml\roads.xml
 $roads = $rodas|Where-Object {$_.dimention -like $road.dimention}
 $pair =$roads|foreach-object {
    $roadcoordinate =[roadcoordinate]::new(($roads.roadcoordinate.x,$roads.roadcoordinate.y,$roads.$roadcoordinate.z,$roads.x1,$roads.y1,$roads.z1))

    [main]::calcroute{$destination,$roadcoordinate}

    

 }|sort-object -Property distance -Descending |select-object -Last 1
       
 "最佳路线为沿着{0},{1},{2},{3},{4},{5},走到{6}，距离为{7}" -f $pair.roadcoordinate.x,$pair.roadcoordinate.y,$pair.roadcoordinate.z,$pair.roadcoordinate.x1,$road.roadcoordinate.y1,$pair.roadcoordinate.z1,$pair.projectedpoint,$pair.distance
    

}






                


        function add-place {
                <#
.SYNOPSIS
add-place
-wynncraft_place (placecoordinate,type)
-survival_place (placecoordinate,dimention,type)
-teleportation (placecoordinate,name)
-road (roadcoordinate,dimention,name)
.DESCRIPTION
    GPS function .add-place 
    add structure for GPS map
.PARAMETER Path
    The path to the 
.PARAMETER LiteralPath
.
.EXAMPLE
add-place -wynncraft_place "(1,2,3),bank"

.NOTES
    Author: CNCODEGOD
    Date: June 10, 2024
#>

           [CmdletBinding()]
           param (
               [Parameter(parametersetname="road")]
               [road]
               $road
               ,
               # 
               [Parameter(parametersetname="wynncraft_place")]
               [wynncraft_place]
               $wynncraft_place
               ,
              
              
                   [Parameter(parametersetname="survival_place")]
                    [survival_place]
                   $survival_place
                   ,
                   
                   [Parameter(parametersetname="teleportation_place")]
                   [teleportation_place]
                   $teleportation
               )
           
        
           switch ($pscmdlet.parametersetname) {
            #parameter for add-place -road
            road {

                
                  
                    $roads = Import-clixml c:\ex-sys\xml\roads.xml
                    [road]::validate($road)
                    $id =[int]($roads|Sort-Object -Property id |Select-Object -Last 1).id+1
                  $road.id=$id
                  $roads=[System.Collections.Generic.List[road]]$road+$roads
                  $roads|export-Clixml C:\ex-sys\xml\roads.xml
                  "成功添加路线 ：{0},{1},{2}----{3},{4},{5}" -f $road.roadcoordinate.x,$road.roadcoordinate.y,$road.roadcoordinate.z,$road.roadcoordinate.x1,$road.roadcoordinate.y1,$road.roadcoordinate.z1

                }
             
              #parameter for add-place -wynncraft_place
            wynncraft_place {
                switch ($wynncraft_place.type) {
                 
                chest { $distance_limit=5}
blackSmith  { $distance_limit=5}
potion_merchant  { $distance_limit=5}
tool_merchant  { $distance_limit=5}
identifier   { $distance_limit=5}

powder_master  { $distance_limit=5}

Default {
    $distance_limit=50

}
                }
[wynncraft_place]::validate($wynncraft_place,$distance_limit)
$wynncraft_places = Import-clixml c:\ex-sys\xml\wynncraft_places.xml
$id =[int]($wynncraft_places  |Sort-Object -Property id |Select-Object -Last 1).id+1
$wynncraft_place.id =$id
$wynncraft_places=[System.Collections.Generic.List[wynncraft_place]]$wynncraft_place+$wynncraft_places
$wynncraft_places|Export-Clixml c:\ex-sys\xml\wynncraft_places.xml



             }
#parameter for add-place -survival_place
            survival_place {
         

                switch ($survival_place.type) {
                    nether_portal {$distance_limit=5  }
                    Default {$distance_limit=50  }
                    
                }
                [survival_place]::validate($survival_place,$distance_limit)
                $survival_places = Import-clixml c:\ex-sys\xml\survival_places.xml

                $id =[int]($survival_places  |Sort-Object -Property id |Select-Object -Last 1).id+1
                
            $survival_place.id=$id    
            
            $survival_places=[System.Collections.Generic.List[survival_place]]$survival_place+$survival_places
            $survival_places|Export-Clixml c:\ex-sys\xml\survival_places.xml
            "成功添加生存存档{0}坐标：{1},{2},{3}" -f $survival_place.type,$survival_place.placecoordinate.x,$survival_place.placecoordinate.y,$survival_place.placecoordinate.z

            
                 }
                 #parameter for add-place -teleportation_place
            teleportation_place {$teleportations = Import-clixml c:\ex-sys\xml\teleportation.xml
                [teleportation_place]::validate($teleportation_place,50)
            $id =[int]($teleportation_places|Sort-Object -Property id |Select-Object -Last 1).id+1
            $teleportation_places.id=$id 
            
            $teleportation_places=[System.Collections.Generic.List[teleportation_place]]$teleportation_place + $teleportation_places
            $teleportation_places|Export-Clixml c:\ex-sys\xml\survival_places.xml
            "成功添加传送点{0} ,坐标{1},{2},{3}" -f $teleportation_place.name,$teleportation_place.placecoordinate.x,$teleportation_place.placecoordinate.y,$teleportation_place.placecoordinate.z
           }

        }

    
    
}
function remove-place {
                    <#
.SYNOPSIS
remove-place
-wynncraft_place (id)
-survival_place (id)
-teleportation (id)
-road (id)
.DESCRIPTION
    GPS function remove-place
    remove structure in GPS map
.PARAMETER Path
    The path to the 
.PARAMETER LiteralPath
.
.EXAMPLE
remove-place -wynncraft_place "1"

.NOTES
    Author: CNCODEGOD
    Date: June 10, 2024
#>
    [CmdletBinding()]
    param (
        [Parameter(parametersetname="road")]
        [road]
        $road
        ,
        # 
        [Parameter(parametersetname="wynncraft_places")]
        [wynncraft_place]
        $wynncraft_place
        ,
     
            [Parameter(parametersetname="survival_places")]
             [survival_place]
            $survival_place
            ,
            
            [Parameter(parametersetname="teleportation_place")]
            [teleportation]
            $teleportation_place
        )
    
 
    
    switch ($pscmdlet.parametersetname) {
        ##parameterset script block for remove-place -road
        road { 

$roads = Import-clixml c:\ex-sys\xml\roads.xml
$roads = $roads|Where-Object {$_.id -ne $road.id}
$pair =  $roads|Where-Object {$_.id -eq $road.id}
$roads|Export-Clixml -path c:\ex-sys\xml\roads.xml        
"成功移除{0}号路线:{1},{2},{3},{4},{5}" -f $road.id ,$pair.roadcoordinate.x,$pair.roadcoordinate.y,$pair.roadinate.z,$pair.roadcoordinate.x1,$pair.roadcoordinate.y1,$pair.roadcoordinate.z1
        }
        ##parameterset script block for remove-place -wynncraft_place
        wynncraft_places {
            $wynncraft_places = Import-clixml c:\ex-sys\xml\roads.xml
$wynncraft_places = $wynncraft_places|Where-Object {$_.id -ne $wynncraft_place.id}
$pair =  $wynncraft_places|Where-Object {$_.id -eq $wynncraft_place.id}
$wynncraft_places|Export-Clixml -path c:\ex-sys\xml\wynncraft_places.xml   
" 成功移除{0},坐标{1},{2,{3}}" -f $pair.type,$pair.placecoordinate.x,$pair.placecoordinate.y,$pair.placecoordinate.z

}
##parameterset script block for remove-place -survival_place
        survival_places { 
            $survival_places = Import-clixml c:\ex-sys\xml\survival_places.xml
            $survival_places = $survival_places|Where-Object {$_.id -ne $survival_place.id}
            $survival_places|Export-Clixml -path c:\ex-sys\xml\survival_places.xml
            "成功移除{0},坐标{1},{2},{3}" -f $pair.type,$pair.placecoordinate.x,$pair.placecoordinate.y,$pair.placecoordinate.z


        }
        ##parameterset script block for remove-place -teleportation_place
        teleportation_place { 
        $teleportation = Import-clixml c:\ex-sys\xml\teleportation.xml
$teleportation = $teleportation|Where-Object {$_.id -ne $teleportation.id}
$teleportation|Export-Clixml -path c:\ex-sys\teleportation.xml
$pair =  $teleportation|Where-Object {$_.id -eq $teleportation.id}
"成功移除传送点{0}，坐标{1},{2},{3}" -f $pair.name,$pair.placecoordinate.x,$pair.placecoordinate.y,$pair.placecoordinate
    }
}

}



