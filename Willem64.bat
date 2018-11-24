echo off
chcp 65001

Set "xOS=x64" & If "%PROCESSOR_ARCHITECTURE%"=="x86" (
 If Not Defined PROCESSOR_ARCHITEW6432 Set "xOS=x86"
)

set wpath=%~d0%~p0bin
set dpath=%~d0%~p0bin
set soft98=EpromM51_98D12C3.exe
set drvinst=TVicPortInstall41.exe

set GenteePaths="HKLM\SOFTWARE\Wow6432Node\Gentee\Paths"
set "DrvPathsName=TVicPortDemo"
set "DrvPaths="



cls


rem set "xOS=x86"
rem set "xOS=x64"

@echo xOS=%xOS%

if %xOS% EQU x64 goto :run64
if %xOS% NEQ x64 goto :run86

@echo end
goto :endbat

:run86
pause
echo mode 86
start /d  "%wpath%" %soft98%
goto :endbat

:run64

echo mode 64

rem < чтение пути из реестра
for /f "tokens=2*" %%A in ('REG QUERY %GenteePaths% /v %DrvPathsName%') DO (
  for %%F in (%%B) do (
    set DrvPaths=%%F
    goto :break1
  )
)
:break1
rem end чтение пути из реестра >

rem проверка наличия файлов
if exist %DrvPaths%\cpd64.exe (Call echo %DrvPaths%\cpd64.exe               OK) else (Echo %DrvPaths%\cpd64.exe               не найден)
if exist %DrvPaths%\Docs\LICENSE.TXT (echo %DrvPaths%\Docs\LICENSE.TXT        OK) else (Echo %DrvPaths%\Docs\LICENSE.TXT        не найден)
if exist %DrvPaths%\Examples (echo %DrvPaths%\Examples                найдено) else (Echo %DrvPaths%\Examples                не установлено)
if exist %DrvPaths%\uninstall.ini (echo %DrvPaths%\uninstall.ini           OK) else (Echo %DrvPaths%\uninstall.ini           не найден)
if exist %DrvPaths%\uninstall.exe (echo %DrvPaths%\uninstall.exe           OK) else (Echo %DrvPaths%\uninstall.exe           не найден)

if exist %SystemRoot%\system\TVicPort.dll (echo %SystemRoot%\system\TVicPort.dll              OK) else (Echo %SystemRoot%\system\TVicPort.dll              не найден)
if exist %SystemRoot%\System32\drivers\TVicPort64.sys (echo %SystemRoot%\System32\drivers\TVicPort64.sys  OK) else (Echo %SystemRoot%\System32\drivers\TVicPort64.sys  не найден)
if exist %SystemRoot%\SysWOW64\drivers\TVicPort64.sys (echo %SystemRoot%\SysWOW64\drivers\TVicPort64.sys  OK) else (Echo %SystemRoot%\SysWOW64\drivers\TVicPort64.sys  не найден)

if not exist "%DrvPaths%\cpd64.exe" (start "TVicPort Install ..." /wait  /d "%dpath%" %drvinst%) else (start /d  "%wpath%" %soft98%)







goto endbat



:endbat

echo exit
Pause
exit