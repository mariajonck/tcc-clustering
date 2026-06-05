@echo off
set ECLIPSE_DIR=C:\Users\dudaj\Downloads\eclipse
set EQUINOX=%ECLIPSE_DIR%\plugins\org.eclipse.equinox.launcher_1.3.100.v20150511-1540.jar
set ORGANIC=organic.Organic
set OUT_DIR=C:\tmp\smells
set PROJ_DIR=C:\Users\dudaj\Downloads\projetos

:: Cria a pasta de saída 
if not exist "%OUT_DIR%" mkdir "%OUT_DIR%"

::call :analisar "elasticsearch-main"
::call :analisar "spring-boot-main"
::call :analisar "ghidra-master"
call :analisar "java-design-patterns-master"

:: ============================================================

echo.
echo Todos os projetos foram analisados!
echo Arquivos salvos em: %OUT_DIR%
pause
exit /b


:: Função de análise
:: Procura automaticamente a pasta src dentro do projeto
:analisar
set NOME=%~1
set OUT=%OUT_DIR%\%NOME%.json
set BASE=%PROJ_DIR%\%NOME%

echo.
echo ========================================
echo Analisando projeto: %NOME%
echo ========================================

:: Tenta encontrar a pasta src em ordem de prioridade
set SRC=

if exist "%BASE%\src\main\java"  set SRC=%BASE%\src\main\java
if "%SRC%"=="" if exist "%BASE%\src\java"      set SRC=%BASE%\src\java
if "%SRC%"=="" if exist "%BASE%\src"           set SRC=%BASE%\src
if "%SRC%"=="" if exist "%BASE%\source"        set SRC=%BASE%\source
if "%SRC%"=="" if exist "%BASE%\java"          set SRC=%BASE%\java
if "%SRC%"==""                                  set SRC=%BASE%

echo Fonte encontrada: %SRC%
echo Saida: %OUT%
echo ----------------------------------------

java -jar -XX:MaxPermSize=2560m -Xms40m -Xmx2500m "%EQUINOX%" ^
  -application %ORGANIC% ^
  -data "C:\tmp\workspace" ^
  -sf "%OUT%" ^
  -src "%SRC%"

echo Concluido: %NOME%
exit /b