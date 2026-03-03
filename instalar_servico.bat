@echo off

:: ================================
:: FORCAR EXECUCAO COMO ADMIN
:: ================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando permissao de administrador...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ================================
:: IR PARA PASTA DO SCRIPT
:: ================================
cd /d "%~dp0"

title Instalador BSFechamentos
color 0A

echo ======================================
echo        INSTALADOR BSFechamentos
echo ======================================
echo.

:: ================================
:: VERIFICAR GIT
:: ================================
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo ERRO: Git nao encontrado!
    pause
    exit /b
)

:: ================================
:: CLONAR REPO
:: ================================
set REPO_URL=https://github.com/4RTHURsantos/bsfechamentos.reception.git
set PROJECT_FOLDER=bsfechamentos.reception

if exist "%PROJECT_FOLDER%" (
    echo Projeto ja existe, pulando clone...
) else (
    echo Clonando repositorio...
    git clone %REPO_URL%
    if %errorlevel% neq 0 goto erro
)

:: ================================
:: ENTRAR NA PASTA DO PROJETO
:: ================================
cd "%PROJECT_FOLDER%" || (
    echo ERRO: nao conseguiu entrar na pasta do projeto!
    pause
    exit /b
)

echo Pasta do projeto:
cd
echo.

:: ================================
:: VERIFICAR NODE
:: ================================
echo Verificando Node.js...
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ERRO: Node.js nao encontrado!
    pause
    exit /b
)

echo Node encontrado.
echo.

:: ================================
:: CONFIGURAR .ENV
:: ================================
echo ================================
echo CONFIGURACAO DO ARQUIVO .ENV
echo ================================
echo.

set /p API_PORT=Digite a PORTA da API (ex: 3001):
set /p ROOT_FOLDER=Digite o caminho da pasta raiz (ex: C:\XML_RECEPCAO):

echo Salvando .env...

(
echo API_PORT=%API_PORT%
echo ROOT_FOLDER=%ROOT_FOLDER%
) > ".env"

echo .env criado com sucesso!
echo.

:: ================================
:: PARAR SERVICO ANTIGO
:: ================================
echo Parando servico se existir...
net stop BSFechamentosReception >nul 2>nul

:: ================================
:: INSTALAR DEPENDENCIAS
:: ================================
echo Instalando bibliotecas...
call npm install
if %errorlevel% neq 0 goto erro

:: ================================
:: BUILD
:: ================================
echo Buildando servico...
call npm run build
if %errorlevel% neq 0 goto erro

:: ================================
:: START
:: ================================
echo Iniciando servico...
call npm run start
if %errorlevel% neq 0 goto erro

echo.
echo ======================================
echo INSTALACAO FINALIZADA COM SUCESSO
echo ======================================
pause
exit /b

:erro
color 0C
echo.
echo ======================================
echo ERRO DURANTE O PROCESSO
echo ======================================
pause
exit /b 1