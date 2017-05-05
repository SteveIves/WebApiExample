@echo off
setlocal
pushd DATA

echo Deleting existing files...
if exist department.ism del /q department.ism
if exist department.is1 del /q department.is1
if exist employee.ism   del /q employee.ism
if exist employee.is1   del /q employee.is1

echo Loading new files...
fconvert -it department.txt -oi department.ism -d department.xdl
fconvert -it employee.txt   -oi employee.ism   -d employee.xdl

popd
endlocal
