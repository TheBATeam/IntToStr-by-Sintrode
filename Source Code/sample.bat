@Echo off
cls

Title Demo File by TheBATeam - www.thebateam.org
Set "Path=%Path%;%cd%;%cd%\files"
Color 0a
Mode 80,25

:Main
Cls
Echo.

call IntToStr.bat 12345678
echo(
call IntToStr.bat 0
echo(
call IntToStr.bat 2000158
echo(
call IntToStr.bat 47060900
echo(
call IntToStr.bat -1528
echo(
call IntToStr.bat 123456789012345678901234567890123456789012345678901234567890123456
echo(
call IntToStr.bat 3080040
pause