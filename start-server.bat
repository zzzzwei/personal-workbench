@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ============================================
echo   个人工作台 - 本地服务器
echo ============================================
echo.
echo  1) 电脑上自测(应能打开工作台):
echo     http://127.0.0.1:8137/index.html
echo.
echo  2) 你的 IPv4 地址(手机用非 127.0.0.1 的那个):
ipconfig | findstr "IPv4"
echo.
echo  3) 手机连同一个 WiFi, Safari 打开:
echo     http://<上面那个非 127 IP>:8137/index.html
echo.
echo  4) 关闭此窗口 = 停止服务器
echo     手机打不开? 确认同 WiFi + 防火墙允许 8137
echo ============================================
echo.
"C:\Users\liuzi\.workbuddy\binaries\python\versions\3.13.12\python.exe" -m http.server 8137
echo.
echo (服务器已停止)
pause
