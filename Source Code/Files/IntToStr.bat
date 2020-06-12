::------------------------------------------------------------------------------
:: NAME
::     IntToStr.bat
::
:: USAGE
::     IntToStr <number>
::
:: DESCRIPTION
::     Converts an integer (positive or negative) to its word equivalent,
::     e.g. one, two, three, etc. This script can handle numbers up to 66 digits
::     long.
::
:: AUTHOR
::     sintrode
::
:: VERSION HISTORY
::     1.0 - Initial Version (2020-05-02)
::------------------------------------------------------------------------------
@echo off
setlocal enabledelayedexpansion

:: Input validation
if "%~1"=="" exit /b
set "number=%~1"
call :is_number %number% || exit /b

:: Generate text arrays
call :number_names

:: Break the number into three-digit chunks
call :split_number %number%

:: Store the chunks in an array
set counter=0
call :make_array raw_chunk "%var2%" -1
for /L %%A in (%array_index%,-1,0) do (
	set "flip_array[!counter!]=!raw_chunk[%%A]!"
	set /a counter+=1
)
set /a counter-=1

:: Re-flip the array and build the number backwards
set "print_n=<nul set /p ="
if "%number:~0,1%"=="-" %print_n% "negative "
for /L %%A in (!counter!,-1,1) do (
	call :get_num_name !flip_array[%%A]! %%A
	if !flip_array[%%A]! neq 0 %print_n% "!mult_name[%%A]! "
)
echo(
exit /b

::------------------------------------------------------------------------------
:: Ensures that the number provided to the script is an integer
::
:: Arguments: %1 - The number to validate
:: Returns:   0 if the number is an integer, 1 otherwise
::------------------------------------------------------------------------------
:is_number
set "valid_number=0"
for /f "tokens=1 delims=1234567890-" %%A in ("%~1") do (
	echo Invalid number.
	set "valid_number=1"
)
exit /b !valid_number!

::------------------------------------------------------------------------------
:: Splits a number into chunks of three for later processing
::
:: Thanks:    https://stackoverflow.com/a/28704587/4158862
:: Arguments: %1 - The number to split into groups of three digits
:: Returns:   A space-delimited representation of the original number
::------------------------------------------------------------------------------
:split_number
set "var1=%1"
set "var2="
set "sign="
if "%var1:~0,1%" equ "-" set "sign=-" & set "var1=%var1:~1%"
for /L %%i in (1,1,2730) do if defined var1 (
   set "var2=,!var1:~-3!!var2!"
   set "var1=!var1:~0,-3!"
)
set "var2=%var2:~1%"
exit /b

::------------------------------------------------------------------------------
:: Recursively generates an array from a comma-separated list of values
::
:: Arguments: %1 - Name of the array to generate
::            %2 - List of elements to add to the array
::            %3 - Index of the array to set
:: Returns:   None
::------------------------------------------------------------------------------
:make_array
set /a array_index=%3+1
if not "%~2"=="" (
	for /F "tokens=1,* delims=," %%A in ("%~2") do (
		set %1[%array_index%]=%%A
		call :make_array %1 "%%B" %array_index%
	)
)
exit /b

::------------------------------------------------------------------------------
:: Returns the name of a three-digit number
::
:: Arguments: %1 - The number to convert to a string
::            %2 - Which chunk is being processed
:: Returns:   A value between "zero" and "nine hundred ninety-nine"
::------------------------------------------------------------------------------
:get_num_name
set "number_group=%~1"

:: If number_group is three digits, strip the first digit and suffix it with
:: "hundred." Throw in an "and" if it's the last two digits.
if not "%number_group:~2,1%"=="" (
	if not "%number_group:~0,1%"=="0" (
		%print_n%" !ones[%number_group:~0,1%]! hundred "
	)
	set "number_group=!number_group:~1,2!"
	
	if "%~2"=="1" if not "!number_group!"=="00" %print_n% " and "
)

:: See if we've got a one- or two-digit number left
if not "%number_group:~1,1%"=="" (
	if %number_group:~0,1% geq 2 (
		REM Numbers above 19 can be dynamically generated through contatenation
		%print_n%"!tens[%number_group:~0,1%]!"
		if "%number_group:~1,1%" neq "0" (
			%print_n%"-!ones[%number_group:~1,1%]! "
		) else (
			%print_n% ". "
		)
	) else (
		%print_n%"!base_num[%number_group:~0,2%]! "
	)
) else (
	REM If we're here, we originally received a single digit number
	%print_n%"!ones[%number_group%]! "
)
exit /b

::------------------------------------------------------------------------------
:: Generates arrays containing the names of several numbers
::
:: Arguments: None
:: Returns:   None
::------------------------------------------------------------------------------
:number_names
set "base_num[01]=one"
set "base_num[02]=two"
set "base_num[03]=three"
set "base_num[04]=four"
set "base_num[05]=five"
set "base_num[06]=six"
set "base_num[07]=seven"
set "base_num[08]=eight"
set "base_num[09]=nine"
set "base_num[10]=ten"
set "base_num[11]=eleven"
set "base_num[12]=twelve"
set "base_num[13]=thirteen"
set "base_num[14]=fourteen"
set "base_num[15]=fifteen"
set "base_num[16]=sixteen"
set "base_num[17]=seventeen"
set "base_num[18]=eighteen"
set "base_num[19]=nineteen"

set "ones[0]=zero"
set "ones[1]=one"
set "ones[2]=two"
set "ones[3]=three"
set "ones[4]=four"
set "ones[5]=five"
set "ones[6]=six"
set "ones[7]=seven"
set "ones[8]=eight"
set "ones[9]=nine"
set "tens[2]=twenty"
set "tens[3]=thirty"
set "tens[4]=forty"
set "tens[5]=fifty"
set "tens[6]=sixty"
set "tens[7]=seventy"
set "tens[8]=eighty"
set "tens[9]=ninety"

set "mult_name[2]=thousand"
set "mult_name[3]=million"
set "mult_name[4]=billion"
set "mult_name[5]=trillion"
set "mult_name[6]=quadrillion"
set "mult_name[7]=quintillion"
set "mult_name[8]=sextillion"
set "mult_name[9]=septillion"
set "mult_name[10]=octillion"
set "mult_name[11]=nontillion"
set "mult_name[12]=decillion"
set "mult_name[13]=undecillion"
set "mult_name[14]=duodecillion"
set "mult_name[15]=tredecillion"
set "mult_name[16]=quattuordecillion"
set "mult_name[17]=quindecillion"
set "mult_name[18]=sexdecillion"
set "mult_name[19]=septendecillion"
set "mult_name[20]=octodecillion"
set "mult_name[21]=novemdecillion"
set "mult_name[22]=vigintillion"
exit /b