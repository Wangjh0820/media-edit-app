@echo off
chcp 65001 >nul
echo ========================================
echo    MediaEdit 应用启动脚本
echo ========================================
echo.

echo [1/2] 检查环境...

where mvn >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Maven 未安装，请先安装 Maven
    echo 下载地址: https://maven.apache.org/download.cgi
    echo 或使用: winget install Apache.Maven
    goto :end
)

where flutter >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Flutter 未安装，请先安装 Flutter SDK
    echo 下载地址: https://flutter.dev/docs/get-started/install/windows
    goto :end
)

echo [√] 环境检查通过
echo.

echo [2/2] 启动后端服务...
cd backend
start cmd /k "mvn spring-boot:run"
echo [√] 后端服务启动中... (http://localhost:8080)
echo.

echo ========================================
echo 后端服务已启动!
echo API文档: http://localhost:8080/swagger-ui.html
echo ========================================
echo.
echo 启动前端请运行: cd frontend ^&^& flutter run
echo.

:end
pause
