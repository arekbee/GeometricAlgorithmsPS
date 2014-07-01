$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace('.Tests.', '.')
. "$here\PointsCommon.ps1"
. "$here\$sut"


Describe 'when invoking Get-Distance' {
  
  context 'and there are more then 2 points ' {
    [pf[]]$points = @((new-pf), (new-pf), (new-pf))
    It 'should return max value'{
      $disstance = Get-Distance $points
      $disstance | should be ([double]::MaxValue)
    }
  }
  
  context 'and there are less then 2 points ' {
    [pf[]]$points = @((new-pf))
    It 'should return max value'{
      Get-Distance $points | should be ([double]::MaxValue)
    }
  }
  
  context 'and there are 2 same poinst'{
    [pf[]]$points = @((new-pf 11 22),(new-pf 11 22))
    It 'should return 0' {
      Get-Distance $points | should be 0
    }
    
  }

  context 'and there are 2 diffrent points' {
    [pf[]]$points = @((new-pf 11 22) , (new-pf 22 33))
    it 'should return non-zero value' {
      Get-Distance $points | should not be 0
    }
  }
}

Describe 'when invoking Get-Closes'{

  context 'and there are less then 4 points ' {
    [pf[]]$pointsToTest =  @((new-pf 11 22),(new-pf 22 22), (new-pf 11 10))

    It 'should invoke bruteforce' {
      Mock Get-Closes -parameterFilter {$points -eq  $pointsToTest } 
      Get-Closes $pointsToTest -bruteForce:$false
      Assert-MockCalled -commandName Get-Closes -parameterFilter {$points } -times 1 
    }

    It 'should return not null' {
      
     $findPoints = Get-Closes $pointsToTest   
     $findPoints | should not be $null
     $findPoints | should Not Be NullOrEmpty
    }

    It 'should return 2 points' {
      $findPoints = Get-Closes $pointsToTest 
      $findPoints.Count  | should be 2
      $findPoints | ?{$_.X -eq 11 -and $_.Y -eq 22} | should Not Be NullOrEmpty
      $findPoints | ?{$_.X -eq 22 -and $_.Y -eq 22} | should Not Be NullOrEmpty
    }

  }

  context 'and there are more then 3 points' {
    [pf[]]$in_points = @((new-pf 11 22),(new-pf 22 22), (new-pf 11 10), (new-pf 11 0))

    It 'should return 2 items' {
      $out_Points =  Get-Closes $in_points 
      $out_Points | should not be nullOrEmpty
      $out_Points.Count | should be 2

    }
  
  }

  context 'and there are less then 3 points' {
  
    It 'should return all points' {
      [pf[]]$in_points = @((new-p), (new-p))
       $out_point = Get-Closes $in_points
        $out_point.Count | should be 2
    }

    It 'should return one point' {
      [pf[]]$in_points = @((new-p))
       $out_point = Get-Closes $in_points
        $out_point.Count | should be 1
    }

    It 'should not throw exception on empty args' {
      {Get-Closes @() } | should not throw
    }
 
  }




}

$res = $MyInvocation.MyCommand
$res