@echo off
pushd DATA
rem Make sure we have a schema
echo Locating schema file...
if not exist rps.sch goto no_schema
rem Test to see if the schema will load
echo Testing schema load...
dbs RPS:rpsutl -i rps.sch -ia -ir -s -n rpsmain.new rpstext.new
if "%ERRORLEVEL%"=="1" goto parse_fail
if exist rpsmain.new del /q rpsmain.new
if exist rpsmain.ne1 del /q rpsmain.ne1
if exist rpstext.new del /q rpstext.new
if exist rpstext.ne1 del /q rpstext.ne1
echo Test OK
rem Load the schema
echo Performing schema load...
dbs RPS:rpsutl -i rps.sch -ia -ir
if "%ERRORLEVEL%"=="1" goto load_fail
echo Schema loaded OK
goto done
:no_schema
echo *ERROR* Schema file not found!
goto done
:parse_fail
echo *ERROR* Schema parse failed - repository not changed
goto done
:load_fail
echo *ERROR* Schema load failed - repository not changed
:done
popd