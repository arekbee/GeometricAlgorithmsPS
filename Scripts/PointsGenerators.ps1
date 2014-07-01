function Generate-PF
{
    param([pf]$startP = (new-pf 0 0) 
    ,[int]$iterateNum=1
    ,[scriptblock]$funcX={param($_) $_ + 1}
    ,[scriptblock]$funcY={param($_) $_ + 1}
    )

    [pf]$pReturn = $startP
    for($i = 0; $i -lt $iterateNum; $i++)
    {
        $x = $pReturn.X
        $y = $pReturn.Y
        #region invoke script blocks
        if($funcX)
        {
            $x =   $funcX.Invoke( $x,$i)
        }
        if($funcY)
        {
            $y =   $funcY.Invoke( $y,$i)
        }
        #endregion
        $pReturn = new-pfPSO $x $y
        $pReturn 
    }

}