function Get-Closes([pf[]] $points, [switch]$bruteForce)
{
  #http://rosettacode.org/wiki/Closest-pair_problem
  if($points.Count -le 2)
  {
    return $points
  }
  
  if($bruteForce)
  {
    $minPoints = $points[0..1]
    $minDis =  Get-Distance ($minPoints)
    for ([int]$i=0; $i -lt $points.Count -1 ; $I++)
    {
      for($j=$i+1; $j -lt $points.Count; $j++)
      {
        $tpoints =@($points[$i], $points[$j])
        $tDis =     Get-Distance ( $tpoints)
        if($tDis -lt $minDis)
        {
          $minDis = $tDis
          $minPoints = $tpoints
        }
      }
    }
    return $minPoints
  }
  else
  {
    if($points.Count -eq 3)
    {
      return Get-Closes $points -bruteForce
    }
    
    $pointSorted = $points | Sort-Object X,Y
    $x = $pointSorted.X
    $y = $pointSorted.Y
    $Q,$P =  Split-PointSet $pointSorted
    
    
    $closeQ = Get-Closes $Q
    $closeP = Get-Closes $P
    
    $disQ =  Get-Distance ( $closeQ)
    $disP =  Get-Distance ( $closeP)
    
    
    if($disQ -le $disP)
    {
      return $closeQ
      
    }else
    {
      return $closeP
    }
  }
}

function Get-Distance([pf[]] $points)
{
  if($points.Count -eq 2)
  { 
    return [math]::Sqrt([math]::Pow($points[0].X - $points[1].X ,2) + [math]::Pow($points[0].Y - $points[1].Y ,2)) 
  }
  return [double]::MaxValue
}


function Split-PointSet([pf[]]$points)
{
  $count = $points.Count
  $lastIndex = $count-1
  $middleIndex =  [MATH]::Floor($lastIndex / 2)
  
  $Q= $points[0..$middleIndex]
  $P = $points[($middleIndex+1)..$lastIndex]
  
  if($Q.Count - $P.count -gt 1)
  {
    throw "Wrong spliting for points $($points -join ' ')" 
  }
  return $Q, $p
}


function Is-InSegment
{
  param(
    [Parameter(Position = 0, Mandatory = $true)]
    [pf]$searchP, 
    
    [ValidateCount(2, 2)]
    [Parameter(Position = 1, Mandatory = $true)]
  [pf[]]$points)
  
  $xMax = Get-MaxMinP -compareOn X -edge Maximum -points $points
  $yMax = Get-MaxMinP -compareOn Y -edge Maximum -points $points
  $xMin = Get-MaxMinP -compareOn X -edge Minimum -points $points
  $yMin = Get-MaxMinP -compareOn Y -edge Minimum -points $points
  
  return ($searchP.X -ge $xMin) -and ($searchP.X -le $xMax) -and  
  ($searchP.Y -ge $yMin) -and ($searchP.Y -le $yMax)
}