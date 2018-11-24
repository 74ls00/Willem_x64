

Set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" (
 If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86
)



cls
Echo OS - %xOS%

set wpath=%~d0%~p0bin
set dpath=%~d0%~p0bin
set soft98=EpromM51_98D12C3.exe
set drvinst=TVicPortInstall41.exe

cls

rem set xOS="x86"

@echo %xOS%

if %xOS% NEQ "x64" goto run86
if %xOS% EQU "x64" goto run64
@echo end
goto endbat

:run86
echo mode 86

start /d  "%wpath%" %soft98%


goto endbat

:run64

echo 64

if not exist "T:\Temp\4" (start "TVicPort Install ..." /wait  /d "%dpath%" %drvinst%) else (start /d  "%wpath%" %soft98%)

rem EQL %xOS%="x64"


pause



goto endbat



:endbat



Pause