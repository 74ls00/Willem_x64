

Set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" (
 If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86
)



cls
Echo OS - %xOS%

set wpath=%~d0%~p0
set dpath=%wpath%TVicPort
set soft98=EpromM51_98D12C3.exe

rem set softex=%~d0%~p0EpromM51_98D12C3.exe
set drvinst=TVicPortInstall41.exe

cls
if not exist "T:\Temp\2" EQL %xOS%="x64" (start "TVicPort Install ..." /wait  /d "%dpath%" %drvinst%) else (start /d  "%wpath%" %soft98%)
pause










Pause