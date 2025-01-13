BeforeAll {

    function dre-send {
        [CmdletBinding()]
        param (
            [Parameter()]
            [string]
            $scriptblock
        )
    
            wt -w RightShell PowerShell -c $scriptblock    
     
     
           
            # wt -w RightShell cmd /c $scriptblock
         
       
            
            wt -w RightShell powershell -c node $scriptblock    
           
                 
            wt -w RightShell PowerShell -c py $scriptblock    
               
            
        
    
    
        
        
    }
    
}

Describe 'function dre-send debug'{

    context 'test function'{

        it 'test dre-send with direction'{
            


        }
    }
}