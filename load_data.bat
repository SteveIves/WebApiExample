@echo off
setlocal
pushd "%DAT%"

echo Deleting existing files...
if exist DEPARTMENT.ISM  del /q DEPARTMENT.ISM
if exist DEPARTMENT.IS1  del /q DEPARTMENT.IS1
if exist EMPLOYEE.ISM    del /q EMPLOYEE.ISM
if exist EMPLOYEE.IS1    del /q EMPLOYEE.IS1

echo Loading new files...
fconvert -it DEPARTMENT.TXT -oi DEPARTMENT.ISM -d DEPARTMENT.XDL
fconvert -it EMPLOYEE.TXT   -oi EMPLOYEE.ISM   -d EMPLOYEE.XDL

popd
endlocal
