$data = Get-Content .\sample.txt

$depth = $horizontal = 0

for ($i = 0; $i -lt $data.Count; $i++) {
    $instruction, [int]$distance = $data[$i].Split(" ")
    write-host "$instruction : $distance" -ForegroundColor Green
    switch ($instruction) {
        forward { $horizontal = $horizontal + $distance ; break }
        down { $depth += $distance ;break }
        up { $depth -= $distance ;break }
    }
    Write-host "Horiz: $horizontal :: Depth: $depth"
}
$horizontal * $depth