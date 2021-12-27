$DataPath = ".\input.txt"
$draws = (Get-Content -Path $DataPath -Head 1) -split (",")

$boards = Get-Content -Path $DataPath | Select-Object -Skip 2 | Where-Object { $_ -ne "" } | ForEach-Object { ($_ -replace "  ", " ").trim() }

# Build cards
$cards = [object[]]::new($boards.Count / 5)
for ($x = 0; $x -lt $boards.Count / 5; $x++)
{
    $thisCard = [object[]]::new(5)
    Write-Host "Card $x" -ForegroundColor Yellow
    for ($j = 0; $j -lt 5; $j++)
    {
        $thiscard[$j] = $boards[($j + $x * 5)] -split (" ")
    }
    $cards[$x] = $thisCard
}

$cardCount = $cards.Count
Clear-Variable Win,BingoRow,BingoColumn -ErrorAction SilentlyContinue
#play game
:GamePlay foreach ($ball in $draws)
{
    Write-Host "Next Ball: $ball"
    for ($a = 0; $a -lt $cardcount; $a++)
    {
        for ($b = 0; $b -lt 5; $b++)
        {
            for ($c = 0; $c -lt 5; $c++)
            {
                $currentCell = [int]($cards[$a][$b][$c])
                if ([int]($cards[$a][$b][$c]) -eq [int]$ball)
                {
                    $cards[$a][$b][$c] = "999"
                    Write-Host "Found on Card $a" -ForegroundColor Red
                }
            }
        }

    }

    # Check for wins
    :BingoCheck for ($a = 0; $a -lt $cardcount; $a++)
    {
        # Check each Row for all "999"
        for ($row = 0; $row -lt 5; $row++)
        {
            if (($cards[$a][$row] | Measure-Object -Sum).sum -eq (5 * 999) )
            {
                $Win = $true
                $BingoRow = $row
                Break # This loop doesn't need named
            }
        }
        # Check Each Column for a win
        
        :ColumnCheck for ($Col = 0; $Col -lt 5; $Col++)
        {
            Clear-Variable ColumnSum -ErrorAction SilentlyContinue
            for ($row = 0; $row -lt 5; $row++)
            {
                $columnSum += [int]$cards[$a][$row][$Col]
                if ($columnSum -eq (5 * 999))
                {
                    $Win = $true
                    $BingoColumn = $col
                    Break :ColumnCheck
                }
            }
        }
        if ($win)
        {
            Break :BingoCheck
        }
    }
    If ($win)
    {
        Write-Host "Bingo!"
        $WinningCard = $a
        $LastBall = [int]$ball

        Break :GamePlay
    }
}

# Tally Winning Score

$cardTally = $cards[$WinningCard] | Foreach-object {$_.ToInt32($null)} | Where-Object {$_ -ne 999} | Measure-Object -sum | Select-Object -ExpandProperty Sum
#0..$cardCount | ForEach-Object { $cards[$_] }
Write-Host "Winning Card: $WinningCard" -ForegroundColor Yellow
Write-Host "Winning Row: $BingoRow" -ForegroundColor Yellow
Write-Host "Winning COlumn: $BingoColumn" -ForegroundColor Yellow

$cardTally * $LastBall

