rem create n++ 7.4.1
chcp 866
title ����� Willem EPROM
echo off

Set "xOS=x64" & If "%PROCESSOR_ARCHITECTURE%"=="x86" (
 If Not Defined PROCESSOR_ARCHITEW6432 Set "xOS=x86"
)

set wpath=%~d0%~p0bin
set dpath=%~d0%~p0bin
set soft98=EpromM51_98D12C3.exe
set drvinst=TVicPortInstall41.exe

set GenteePaths="HKLM\SOFTWARE\Wow6432Node\Gentee\Paths"
set "DrvPathsName=TVicPortDemo"
set "DrvPaths=                   "

rem set "xOS=x86"
rem set "xOS=x64"

cls

@echo ����來���� ��⥬�=%xOS%

if %xOS% EQU x64 goto :run64
if %xOS% NEQ x64 goto :run86

@echo end
goto :endbat

:run86
title ����� 86
start /d  "%wpath%" %soft98%
goto :endbat

:run64
title ����� 64

rem < �⥭�� ��� �� ॥���
for /f "tokens=2*" %%A in ('REG QUERY %GenteePaths% /v %DrvPathsName%') DO (
  for %%F in (%%B) do (
    set DrvPaths=%%F
    goto :break1
  )
)
:break1
rem end �⥭�� ��� �� ॥��� >

echo.
rem �஢�ઠ ������ 䠩���
if exist %DrvPaths%\cpd64.exe (Call echo %DrvPaths%\cpd64.exe               OK) else (Echo %DrvPaths%\cpd64.exe               �� ������)
if exist %DrvPaths%\Docs\LICENSE.TXT (echo %DrvPaths%\Docs\LICENSE.TXT        OK) else (Echo %DrvPaths%\Docs\LICENSE.TXT        �� ������)
if exist %DrvPaths%\Examples (echo %DrvPaths%\Examples                �������) else (Echo %DrvPaths%\Examples                �� ��⠭������)
if exist %DrvPaths%\uninstall.ini (echo %DrvPaths%\uninstall.ini           OK) else (Echo %DrvPaths%\uninstall.ini           �� ������)
if exist %DrvPaths%\uninstall.exe (echo %DrvPaths%\uninstall.exe           OK) else (Echo %DrvPaths%\uninstall.exe           �� ������)

if exist %SystemRoot%\system\TVicPort.dll (echo %SystemRoot%\system\TVicPort.dll              OK) else (Echo %SystemRoot%\system\TVicPort.dll              �� ������)
if exist %SystemRoot%\System32\drivers\TVicPort64.sys (echo %SystemRoot%\System32\drivers\TVicPort64.sys  OK) else (Echo %SystemRoot%\System32\drivers\TVicPort64.sys  �� ������)
if exist %SystemRoot%\SysWOW64\drivers\TVicPort64.sys (echo %SystemRoot%\SysWOW64\drivers\TVicPort64.sys  OK) else (Echo %SystemRoot%\SysWOW64\drivers\TVicPort64.sys  �� ������)

title ����� 64 : ��⠭���� �ࠩ���
if not exist "%DrvPaths%\cpd64.exe" (start "TVicPort Install ..." /wait  /d "%dpath%" %drvinst%) else (start /d  "%wpath%" %soft98%)

rem title ����� Willem EPROM 
rem start /d  "%wpath%" %soft98%

goto endbat

:endbat
title �����襭�
echo.
echo ��室
rem Pause
exit