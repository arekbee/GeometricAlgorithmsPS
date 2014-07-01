
function Get-Det
{
    [cmdletbinding()]
    param(
[pf]$p1
,
[pf]$p2
,
[pf]$p3)

    if(-not $p3)
    {
        Write-Verbose 'arg[0] and  arg[1]'
        return ($p1.X * $p2.Y) -  ($p1.Y * $p2.X)
    }
    else
    {
      Write-Verbose 'arg[0] arg[1] and arg[2]'
        return ($p1.X * $p2.Y) + ($p2.X * $p3.Y) + ($p3.X * $p1.Y) - ($p1.Y * $p2.X) - ($p2.Y * $p3.X) - ($p3.Y * $p1.X)
    }
}

function Get-Sign($value)
{
  return [math]::Sign($value)
}

function Get-Alfa([pf]$p)
{
    $d = [math]::Abs($p.X) + [math]::Abs($p.Y)
    $y_d =  ([math]::Abs($p.Y) / $d)

    if($p.X -gt 0 -and $p.Y -ge 0)
    {
        return $p.Y / $d
    }
    elseif ($p.X -le 0 -and $p.Y -gt 0)
    {
        return 2 - $y_d
    }
    elseif ($p.X -lt 0 -and $p.Y -le 0)
    {
        return 2 + $y_d
    }
    elseif ($p.X -ge 0 -and $p.Y -lt 0)
    {
        return 4 -  $y_d
    }
    return 0 #point 0 0
}


#Get-Centroid (new-p 0 0 ), (new-p 10 10 ), (new-p 10 1 ), (new-p 8 7)
function Get-Centroid
{
    param([pf[]]$points)
    $xAvg = ($points| measure -Average -Property X).Average
    $yAvg = ($points| measure -Average -Property Y).Average
    return new-pf $xAvg $yAvg
}