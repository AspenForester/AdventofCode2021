$data = get-Content .\input.txt
$greater = $less = 0
for ($i = 1; $i -lt $data.Count; $i++) {
    if ([int]$data[$i] -gt [int]$data[$i-1]) 
    {
        $greater++
    }
    else {
        $less++
    }
}

$greater 