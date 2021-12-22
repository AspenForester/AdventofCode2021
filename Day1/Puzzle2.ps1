$data = get-Content .\input.txt
$greater = $less = 0
for ($i = 0; $i -lt $data.Count-2; $i++) {
    $sum1 = [int]$data[$i] + [int]$data[$i + 1] + [int]$data[$i + 2]
    $sum2 = [int]$data[$i + 1] + [int]$data[$i + 2] + [int]$data[$i + 3]
    if ($sum2 -gt $sum1) 
    {
        $greater++
    }
    else {
        $less++
    }
}

$greater 