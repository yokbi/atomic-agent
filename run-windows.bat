@echo off
REM run-windows.bat - atomic-agent fork'unu Windows'ta kaynaktan derler ve test eder.
REM
REM DIKKAT: Bu, AtomicBot-ai/atomic-agent'in DEGISTIRILMEMIS bir fork'udur -
REM bu depoda size ait kod yoktur (bkz. DEPO-DURUMU.md). Ajani sadece KULLANMAK
REM istiyorsaniz bu depoya ihtiyaciniz yok.
REM
REM Kullanim:
REM   run-windows.bat           kur + lint + derle + test
REM   run-windows.bat --check   yalnizca ortam kontrolu

setlocal
cd /d "%~dp0"

echo atomic-agent - AtomicBot-ai/atomic-agent fork'u
echo ^(Bu depoda size ait kod yok - DEPO-DURUMU.md^)
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo HATA: Node.js bulunamadi.
  echo   Bu proje Node ^>= 25.7.0 istiyor - cok yeni bir surum, LTS degil.
  echo   nvm-windows ile kurun: https://github.com/coreybutler/nvm-windows
  echo       nvm install 25
  echo       nvm use 25
  pause & exit /b 1
)

echo ==^> Node.js kontrol ediliyor ^(package.json: ^>=25.7.0^)...
for /f "tokens=1 delims=." %%a in ('node -v') do set NODEMAJ=%%a
set NODEMAJ=%NODEMAJ:v=%
if %NODEMAJ% LSS 25 (
  echo.
  echo HATA: Node
  node -v
  echo       bulundu; bu proje ^>= 25.7.0 istiyor.
  echo.
  echo   Sistem genelinde Node 25'e GECMEYIN - diger projeleriniz bozulur.
  echo   nvm-windows ile proje bazinda gecin:
  echo       nvm install 25
  echo       nvm use 25
  echo.
  echo   Not: Node 25 tek sayili, yani "Current" hatti - LTS degil.
  pause & exit /b 1
)
node -v
npm -v

if "%1"=="--check" (
  echo.
  echo Ortam uygun. Derlemek icin: run-windows.bat
  pause & exit /b 0
)

if exist "node_modules" (
  echo [OK] node_modules mevcut - kurulum atlandi.
) else (
  echo ==^> npm install... uzun surebilir.
  call npm install
  if errorlevel 1 goto hata
)

echo ==^> Tip kontrolu ^(npm run lint^)...
call npm run lint
if errorlevel 1 goto hata

echo ==^> Derleme ^(npm run build^)...
call npm run build
if errorlevel 1 goto hata

echo ==^> Testler ^(npm test^)...
call npm test
if errorlevel 1 goto hata

echo.
echo Tamam. CLI'yi calistirmak icin: npm run cli
echo.
echo UYARI: Calistirmadan once DEPO-DURUMU.md ^(A3^) okuyun -
echo bu ajan dosya duzenler, tarayici surer ve kabuk komutu calistirir.
pause
exit /b 0

:hata
echo.
echo HATA olustu. Yukaridaki ciktiya bakin.
pause
exit /b 1
