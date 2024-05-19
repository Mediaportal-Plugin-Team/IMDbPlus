@ECHO OFF
CLS

Title Creating IMDB+ Installer

IF "%programfiles(x86)%XXX"=="XXX" GOTO 32BIT
    :: 64-bit
    SET PROGS=%programfiles(x86)%
    GOTO CONT
:32BIT
    SET PROGS=%ProgramFiles%
:CONT

IF NOT EXIST "%PROGS%\Team MediaPortal\MediaPortal\" SET PROGS=C:

:: Get version from DLL
FOR /F "tokens=*" %%i IN ('..\Tools\Tools\sigcheck.exe /accepteula /nobanner /n "..\IMDB+\bin\Release\IMDB+.dll"') DO (SET version=%%i)

:: Temp xmp2 file
COPY "..\MPEI\IMDB+.xmp2" "..\MPEI\IMDB+Temp.xmp2"

:: Build MPE1
CD ..\MPEI
"%PROGS%\Team MediaPortal\MediaPortal\MPEMaker.exe" "..\MPEI\IMDB+Temp.xmp2" /B /V=%version% /UpdateXML
CD ..\build

:: Cleanup
DEL "..\MPEI\IMDB+Temp.xmp2"
