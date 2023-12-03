# powershell

# by w0lfzk1nd

# Menu
$from_sys = ""
$user_digit = ""
$valid_sys = @("oct", "hex", "bin", "dec")

Write-Host "`n╔════════════════════════════════════════════════════════════`n║ NUMBER SYSTEM CALCULATOR`n║`n║ Convert any digit of any -`n║ number system to all other.`n║`n║ (Decimal is our standart system)`n║`n║ Choose your number system:`n║`n║  1) Octadecimal-System   [e.g. 644 ]`n║  2) Hexadecimal-System   [e.g. 1A4 ]`n║  3) Binary-System        [e.g. 000110100100 ]`n║  4) Decimal-System       [e.g. 420 ]`n║"
while ($true) {
    $user_choice = Read-Host "║   Enter the system-number"

    if ($user_choice -match '^\d+$' -and [int]$user_choice -ge 1 -and [int]$user_choice -le 4) {
        break
    }
    else {
        Write-Host "║   ! INVALID DIGIT, MUST BE 1-4 !"
    }
}

# Save the system, USER has chosen
$from_sys = $valid_sys[$user_choice - 1]
Write-Host "║   [ Provide digit in <$from_sys> format ]`n║"


$get_digits = Read-Host "║   Enter your digit/s (seperated by comma)"

$user_digit = $get_digits.Replace(" ","") -split ',' | ForEach-Object { $_.Trim() }


# DEBUG TEXT FUNCTION
function debug {
    param([string]$txt)
    Write-Host "==DEBUG==`n$txt`n========="
}

# ERROR TEXT TEMPLATE
function err {
    param([string]$txt, [string]$code, [bool]$exit)
    Write-Host "==[ERROR]==`n$txt`nCODE: [ $code ]`n========="
    if ($exit) { return $true } else { return $false }
}

# Function to quadrize (8^2)
function quad {
    param([int]$digit, [int]$amount)
    
    if ($digit -isnot [int] -or $amount -isnot [int]) {
        # Errorcall
        $invalidParameter = if ($digit -isnot [int]) { 'digit' } else { 'amount' }
        $errorMsg = "$invalidParameter : $digit is not a number"
        $er = err $errorMsg "quadr_func" $true
        if ($er) { exit }
    }
    
    if ($amount -eq 0) { return 1 }
    
    $result = $digit
    for ($c = 1; $c -lt $amount; $c++) {
        $result *= $digit
    }
    if ($result -gt [int]::MaxValue) {
        $er = err "Result is too large to fit into Int max value." "quadr" $true; if ($er) { exit }
        return
    }
    
    return [int]$result
}

#FUNCTION TO CONVERT ANY TO DECIMAL
function to_decimal {
    # Parameters 1: user_digit ; 2: user_system
    param([string]$any_digit, [string]$from)

    if (!$any_digit -or !$from) {
        $er = err "any_digit:$any_digit or from:$from is missing" "to_deci_param" $true; if ($er) { exit }
    }

    switch ($from) {
        # from = octal TO DECIMAL
        $valid_sys[0] {
            # Convert entered number in array, with each character as object
            $split_digit = $any_digit.ToCharArray()
            # Length of entered binary digit
            $digit_len = $split_digit.Length - 1
            # Starting Multiplier
            $multiplier = 0
            # Final digit var
            $converted_decimal = 0

            for ($digit_len; $digit_len -gt -1; $digit_len = $digit_len - 1) {
                # Quadrize 8 with multiplier
                $q = quad 8 $multiplier
                # Convert the single char in int
                [int]$s = [Convert]::ToInt32([char]$split_digit[$digit_len], 10)
                # Multiply the quadrized result with the digit
                $x = $q * $s
                # Add result to the final result
                $converted_decimal = $converted_decimal + $x
                # Raise multiplier for quad by 1
                $multiplier = $multiplier + 1
                # Move to next character to the left
            }
        }

        # from = hex TO DECIMAL
        $valid_sys[1] {
            $split_digit = $any_digit.ToCharArray()
            # Length of entered binary digit
            $digit_len = $split_digit.Length - 1
            # Starting Multiplier
            $multiplier = 0
            # Final digit var
            $converted_decimal = 0

            for ($digit_len; $digit_len -gt -1; $digit_len = $digit_len - 1) {
                # Quadrize 16 with multiplier
                $q = quad 16 $multiplier
                # Convert the single char in int
                if ($split_digit[$digit_len] -match "\d+") {
                    [int]$s = [Convert]::ToInt32([char]$split_digit[$digit_len], 10)
                }
                else {
                    $over_hex_val = $split_digit[$digit_len]
                    switch ($over_hex_val) {
                        "A" { $s = 10 }
                        "B" { $s = 11 }
                        "C" { $s = 12 }
                        "D" { $s = 13 }
                        "E" { $s = 14 }
                        "F" { $s = 15 }
                        default {
                            $er = err "over_hex_val:$over_hex_val is greater then 15 or NaN, no valid letter possible." "hex_to_dec" $true; if ($er) { exit }
                            exit
                        }
                    }
                }
                # Multiply the quadrized result with the digit
                $x = $q * $s
                # Add result to the final result
                $converted_decimal = $converted_decimal + $x
                # Raise multiplier for quad by 1
                $multiplier = $multiplier + 1
                # Move to next character to the left
            }
        
        }

        # from = binary TO DECIMAL
        $valid_sys[2] {
            # Convert entered number in array, with each character as object
            $split_digit = $any_digit.ToCharArray()
            # Length of entered binary digit
            $digit_len = $split_digit.Length - 1
            # Starting Multiplier
            $multiplier = 1
            # Final digit var
            $converted_decimal = 0
            # for each character, starting from the back
            foreach ($char in $split_digit) {
                # If character is 1
                if ($split_digit[$digit_len] -eq "1") {
                    # Add multiplier value to final digit
                    $converted_decimal = $converted_decimal + $multiplier
                }
                # Multiply multiplier by 2
                $multiplier = $multiplier * 2
                # Move to next character to the left
                $digit_len = $digit_len - 1
            } 
        }
    }

    #Return final value
    return $converted_decimal
}

#FUNCTION TO CONVERT DECIMAL TO OCTAL
function to_octal {
    param([int64]$decimal_digit)
    # Bool for running calculator
    $run = $true
    # Multiplier for QUAD
    $multiplier = 0
    # Temp value for calculating (save 8bit value lower then input)
    $temp_val = 0
    # Temp value
    $temp = $decimal_digit
    # Final octal value
    $converted_octal = ""
    while ($run) {
        # calculate the quadrized value for checking
        $oc_qu = quad 8 $multiplier
        # If the result is lower then input
        if ($oc_qu -lt $decimal_digit) {
            # Calculate the next quadrized value and check if its still lower
            $temp_quad = quad 8 ($multiplier + 1)
            # If its lower, add 1 to multiplier of quadrize and continue
            if ($temp_quad -lt $decimal_digit) {
                $multiplier = $multiplier + 1
                # If greated, save result and stop first run
            }
            else {
                $temp_val = quad 8 $multiplier
                $run = $false
            }
        }
    }

    # Restart run
    $run = $true
    while ($run) {
        # Calculate the value
        $temp_val = quad 8 $multiplier
        # Check how many times it fits and round down
        $step = [math]::Floor($temp / $temp_val)
        # Calculate the new value
        $temp = $temp - ($step * $temp_val)
        # Add the amount, how many times it fits, to the final string
        $converted_octal = $converted_octal + "$step"
        # If multiplier is 0, stop run
        if ($multiplier -eq 0) { $run = $false }
        # Lower multiplier by 1
        $multiplier = $multiplier - 1
    }
    return $converted_octal
}
#FUNCTION TO CONVERT DECIMAL TO HEXA
function to_hex {
    param([int64]$decimal_digit)
    # Bool for running calculator
    $run = $true
    # Multiplier for QUAD
    $multiplier = 0
    # Temp value for calculating (save 8bit value lower then input)
    $temp_val = 0
    # Temp value
    $temp = $decimal_digit
    # Final hex value
    $converted_hex = ""

    while ($run) {
        # calculate the quadrized value for checking
        $oc_qu = quad 16 $multiplier
        # If the result is lower then input
        if ($oc_qu -lt $decimal_digit) {
            # Calculate the next quadrized value and check if its still lower
            $temp_quad = quad 16 ($multiplier + 1)
            # If its lower, add 1 to multiplier of quadrize and continue
            if ($temp_quad -lt $decimal_digit) {
                $multiplier = $multiplier + 1
                # If greated, save result and stop first run
            }
            else {
                $temp_val = quad 8 $multiplier
                $run = $false
            }
        }
    }

    # Restart run for calculating the actual hex
    $run = $true
    while ($run) {
        # Calculate the value
        $temp_val = quad 16 $multiplier
        # Check how many times it fits and round down
        $step = [math]::Floor($temp / $temp_val)
        # Calculate the new value
        $temp = $temp - ($step * $temp_val)

        # Check if step value should be a Letter (value over 9)
        if ($step -lt 16 -and $step -gt 9) {
            switch ($step) {
                10 { $step = "A" }
                11 { $step = "B" }
                12 { $step = "C" }
                13 { $step = "D" }
                14 { $step = "E" }
                15 { $step = "F" }
            }
        }
        elseif ($step -gt 15) {
            $er = err "step:$step is greater 16 or lower 9, no possible letter." "deci_to_hex" $true; if ($er) { exit }
        }

        # Add the amount, how many times it fits, to the final string
        $converted_hex = $converted_hex + "$step"

        # If multiplier is 0, stop run
        if ($multiplier -eq 0) { $run = $false }
        # Lower multiplier by 1
        $multiplier = $multiplier - 1
    }

    return $converted_hex
}
#FUNCTION TO CONVERT DECIMAL TO BINARY
function to_binary {
    param([int64]$decimal_digit)
    # Bool for running calculations
    $run = $true
    # Temporary digit of userinput
    $temp = $decimal_digit
    # Final digit string
    $converted_binary = ""

    while ($run) {
        # Divide userdigit by 2
        $res = $temp / 2
        # Add numbers after comma
        $check_float = "{0:N1}" -f $res
        # Check if number is 5 - adding 1 for rest
        if ($check_float.Substring($check_float.Length - 1) -eq 5) {
            # add 1 at the start of final string
            $converted_binary = "1" + $converted_binary
            # Round result down
            $temp = [math]::Floor($temp / 2)
        }
        else {
            # Else if its 0 - adding 0
            $converted_binary = "0" + $converted_binary
            $temp = [math]::Floor([float]$temp / 2)
        }
        if ($temp -eq 0) { $run = $false }
    }
    # Get len of res
    $c = $converted_binary.Length
    # dividing counter with 4
    $c2 = $c / 4
    # Add 2 digits after comma for ALL numbers
    $c3 = "{0:N2}" -f $c2
    # Remove digits infront of comma
    $c4 = $c3.Substring($c3.Length - 2)
    # 25 = three 0 is missing for packets of 4 digits each
    # 50 = two 0 missing
    # 75 = one 0 missing
    switch ($c4) {
        25 { $converted_binary = "000" + $converted_binary }
        50 { $converted_binary = "00" + $converted_binary }
        75 { $converted_binary = "0" + $converted_binary }
        default {}
    }
    return $converted_binary
}


# Calling Functions
foreach ($digit_to_process in $user_digit) {
    switch ($from_sys) {

        # userinp is octal
        $valid_sys[0] {
            $oct = "[ $digit_to_process ]"
            $dec = to_decimal $digit_to_process $from_sys
            $hex = to_hex $dec
            $bin = to_binary $dec
        }

        # userinp is hex
        $valid_sys[1] {
            $hex = "[ $digit_to_process ]"
            $dec = to_decimal $digit_to_process $from_sys
            $oct = to_octal $dec
            $bin = to_binary $dec
        }

        # userinp is binary
        $valid_sys[2] {
            $bin = "[ $digit_to_process ]"
            $dec = to_decimal $digit_to_process $from_sys
            $hex = to_hex $dec
            $oct = to_octal $dec
        }

        # userinp is decimal
        $valid_sys[3] {
            $dec = "[ $digit_to_process ]"
            $oct = to_octal $digit_to_process
            $hex = to_hex $digit_to_process
            $bin = to_binary $digit_to_process
        }
    }
    Write-Host "╠════════════════════════════════════════════════════════════`n║`n║  OCTADECIMAL:     $oct`n║  HEXADECIMAL:     $hex`n║  BINARY:          $bin`n║  DECIMAL:         $dec`n║"
}
Write-Host "╚════════════════════════════════════════════════════════════"