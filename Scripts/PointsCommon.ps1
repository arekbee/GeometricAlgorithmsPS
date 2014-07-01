function Init-GeoAlg
{
    $accelerators = [psobject].Assembly.gettype('System.Management.Automation.TypeAccelerators')
    $accelerators::Add('p', [type]'System.Drawing.Point')
    $accelerators::Add('pf', [type]'System.Drawing.PointF')
}

function new-p #int
{
    $x = $args[0]
    $y = $args[1]
    return [p]@{ x=$x ;  y=$y}
}

function new-pf  #float 
{
    $x = $args[0]
    $y = $args[1]
    return [pf]@{ x=$x ;  y=$y}
}

function new-pfPSO([PSObject[]]$x,[PSObject[]]$y) 
{
    $_x = $x[0].ToSingle($null)
    $_y = $y[0].ToSingle($null) 
    new-pf $_x $_y
}




Init-GeoAlg