$data = Get-Content .\input.txt

[int]$depth = 0
[int]$horizontal =0
[int]$aim = 0

for ($i = 0; $i -lt $data.Count; $i++) {
    $instruction, [int]$distance = $data[$i].Split(" ")
    write-host "$instruction : $distance" -ForegroundColor Green
    switch ($instruction) {
        forward { $horizontal = $horizontal + $distance
            $depth = $depth + ($distance * $aim)
            break }
        down { $aim += $distance ;break }
        up { $aim -= $distance ;break }
    }
    Write-host "Horiz: $horizontal :: Depth: $depth"
}
$horizontal * $depth