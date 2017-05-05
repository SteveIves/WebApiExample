@echo off
setlocal
pushd %~dp0

set PROJECT_NAME=WebApiServices

set CODEGEN_TPLDIR=.\Templates
set CODEGEN_OUTDIR=.\%PROJECT_NAME%
set RPSMFIL=.\DATA\rpsmain.ism
set RPSTFIL=.\DATA\rpstext.ism

codegen -s EMPLOYEE DEPARTMENT -t RepositoryCrudApiController -tf -lf -e -r -n %PROJECT_NAME% -ut MODEL_NS=%PROJECT_NAME%.Models

popd
endlocal