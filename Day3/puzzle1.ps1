$data = Get-Content .\input.txt
$totalItems = $data.Count
$linelength = $data[0].Length

# Create Variables
for ($i = 0; $i -lt $linelength; $i++)
{
    New-Variable -Name "bit$($i + 1)"
}

$gamma = @()
$epsilon = @()

foreach ($item in $data)
{
    $null, $bits = $item -split ("")
    # Accumulate the 1s in each bit 
    for ($i = 1; $i -lt $bits.Count; $i++)
    {
        Set-Variable -Name bit$i -Value ((Get-Variable -Name bit$i -ValueOnly) + ([int]$bits[$i - 1]))
    }
}

for ($i = 1; $i -lt $bits.count; $i++)
{
    $onebitcount = Get-Variable -Name "bit$i" -ValueOnly
    if ($onebitcount -gt $totalItems / 2)
    {
        $gammabit = 1
        $epsilonbit = 0
    }
    else
    {
        $gammabit = 0
        $epsilonbit = 1
    }
    $gamma += $gammabit
    $epsilon += $epsilonbit
}


$gammavalue = [convert]::ToInt32(($gamma -join ('')), 2)
$epsilonvalue = [convert]::toint32(($epsilon -join ('')), 2)

$gammavalue * $epsilonvalue

Remove-Variable -Name bit*