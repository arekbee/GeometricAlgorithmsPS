function Sort-P
{
    param([pf[]]$points)

    $pointsWithAlfa = $points | %{ $_ | Add-Member -Name 'Alfa' -MemberType NoteProperty -Value (Get-Alfa($_)) -PassThru }
    return $pointsWithAlfa | sort -Property Alfa
}
