@echo off
echo ============================================
echo   DEPLOY - Vinheria Agnello (Sprint 2)
echo ============================================
echo.

if "%CATALINA_HOME%"=="" (
    set TOMCAT=C:\Program Files\Apache Software Foundation\Tomcat 10.1
) else (
    set TOMCAT=%CATALINA_HOME%
)

set PROJECT=%~dp0
set DEPLOY=%TOMCAT%\webapps\vinheria-agnello

if not exist "%TOMCAT%\webapps" (
    echo [ERRO] A pasta "%TOMCAT%\webapps" nao foi encontrada!
    echo Verifique se o caminho esta correto ou se voce tem permissao.
    pause
    exit /b
)

echo [1/4] Limpando deploy anterior...
if exist "%DEPLOY%" rmdir /S /Q "%DEPLOY%"

echo [2/4] Copiando arquivos web (JSP, CSS, JS)...
xcopy "%PROJECT%webapp" "%DEPLOY%" /E /I /Y /Q

echo [3/4] Copiando classes Java compiladas...
if exist "%PROJECT%out\com" (
    xcopy "%PROJECT%out\com" "%DEPLOY%\WEB-INF\classes\com" /E /I /Y /Q
) else if exist "%PROJECT%out\production\vinheria-agnello\com" (
    xcopy "%PROJECT%out\production\vinheria-agnello\com" "%DEPLOY%\WEB-INF\classes\com" /E /I /Y /Q
) else (
    echo AVISO: Pasta out/ nao encontrada. Compile o projeto antes!
    echo No IntelliJ: Build ^> Build Project ^(Ctrl+F9^)
)

echo [4/4] Copiando bibliotecas (JARs)...
if not exist "%DEPLOY%\WEB-INF\lib" mkdir "%DEPLOY%\WEB-INF\lib"
if exist "%PROJECT%libs" (
    copy "%PROJECT%libs\*.jar" "%DEPLOY%\WEB-INF\lib\" /Y >nul
) else (
    echo AVISO: Pasta libs/ nao encontrada. Crie-a e adicione h2.jar e os JARs do JSTL.
)

echo.
echo ============================================
echo   Deploy concluido!
echo.
echo   1. Inicie o Tomcat: %TOMCAT%\bin\startup.bat
echo   2. Acesse: http://localhost:8080/vinheria-agnello/
echo   3. Para parar: %TOMCAT%\bin\shutdown.bat
echo ============================================
pause
