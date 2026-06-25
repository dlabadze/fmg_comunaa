@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo  ═══════════════════════════════════════
echo   FMG Community — საბოლოო ვერსიის შენახვა
echo  ═══════════════════════════════════════
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0save-snapshot.ps1"
if errorlevel 1 (
  echo.
  echo  შენახვა ვერ მოხერხდა.
  pause
  exit /b 1
)

echo.
pause
