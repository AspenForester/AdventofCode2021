$data = Get-Content .\input.txt
$linelength = $data[0].Length

# Create Variables
for ($i = 0; $i -lt $linelength; $i++)
{
    New-Variable -Name "bit$($i + 1)"
}

$datatokeep = $data
for ($i = 0; $i -lt $linelength; $i++) {
    Clear-Variable -Name thisbitsum
    foreach ($item in $datatokeep)
    {
        $null, $bits = $item -split ("") # remember this returns one extra element at the end
        if ( $bits[$i] -eq 1)
        {
            $thisbitsum += [int]$bits[$i]
        }
    }
    if ($thisbitsum -ge ($datatokeep.Count /2))
    {
        $datatokeep = $datatokeep | Where-Object {$_[$i] -eq "1"}
    }
    else {
        $datatokeep = $datatokeep | Where-Object {$_[$i] -eq "0"}
    }
    #Write-Host "after Bit $i" -ForegroundColor Yellow
    #$datatokeep
    if ($datatokeep.count -eq 1) { break }
}
$oxygenGeneratorRating = [convert]::ToInt32(($datatokeep -join ('')), 2)

Remove-Variable -Name bit*

# Now do CO2 Scrubber Rating
# Create Variables
for ($i = 0; $i -lt $linelength; $i++)
{
    New-Variable -Name "bit$($i + 1)"
}

$datatokeep = $data
for ($i = 0; $i -lt $linelength; $i++) {
    Clear-Variable -Name thisbitsum
    foreach ($item in $datatokeep)
    {
        $null, $bits = $item -split ("") # remember this returns one extra element at the end
        $thisbitsum += [int]$bits[$i]

    }
    if ($thisbitsum -lt ($datatokeep.Count /2))
    {
        $datatokeep = $datatokeep | Where-Object {$_[$i] -eq "1"}
    }
    else {
        $datatokeep = $datatokeep | Where-Object {$_[$i] -eq "0"}
    }
    #Write-Host "after Bit $i" -ForegroundColor Yellow
    #$datatokeep
    if ($datatokeep.count -eq 1) { break }
}
$CO2ScubberRatingRating = [convert]::ToInt32(($datatokeep -join ('')), 2)

$oxygenGeneratorRating
$CO2ScubberRatingRating
Write-Host "Life Support Rating"
$oxygenGeneratorRating * $CO2ScubberRatingRating

Remove-Variable -Name bit*
