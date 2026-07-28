@echo off
echo ============================================================
echo  Deploy: push to GitHub Pages
echo ============================================================
cd /d "C:\Users\liuzi\WorkBuddy\2026-07-27-08-46-12\personal-workbench"
powershell -NoProfile -ExecutionPolicy Bypass -File ".\deploy-github.ps1"
echo ============================================================
echo.
echo  Script finished.
echo  If above did NOT show "完成", screenshot to me.
echo  Press any key to close this window.
pause