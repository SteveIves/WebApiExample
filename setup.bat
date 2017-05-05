@echo off

rem This batch file can be used to configure the environment after an initial
rem download of the environment. It will load the repository from the schema
rem file, and load the ISAM files ready for use.

if exist "%SYNERGYDE64%dbl\dblvars64.bat" (
  call "%SYNERGYDE64%dbl\dblvars64.bat"
  echo Using 64-bit Synergy
) else (
  if exist "%SYNERGYDE32%dbl\dblvars32.bat" (
    call "%SYNERGYDE32%dbl\dblvars32.bat"
    echo Using 32-bit Synergy
  ) else (
    echo "Synergy/DE not found!"
    exit /b
  )
)

set ROOT=%~dp0
set DAT=%ROOT%DATA
set RPSMFIL=%ROOT%DATA\rpsmain.ism
set RPSTFIL=%ROOT%DATA\rpstext.ism

rem If no repository load it from the schema
if not exist "%RPSMFIL%" (
  call rps_import.bat"
)

rem if no data files, create and load them
if not exist DATA\employee.ism (
  call load_data.bat"
)
