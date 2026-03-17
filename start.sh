#!/bin/bash

echo "========================================"
echo "   MediaEdit 应用启动脚本"
echo "========================================"
echo ""

echo "[1/2] 检查环境..."

if ! command -v mvn &> /dev/null; then
    echo "[错误] Maven 未安装，请先安装 Maven"
    echo "下载地址: https://maven.apache.org/download.cgi"
    exit 1
fi

if ! command -v flutter &> /dev/null; then
    echo "[错误] Flutter 未安装，请先安装 Flutter SDK"
    echo "下载地址: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "[√] 环境检查通过"
echo ""

echo "[2/2] 启动后端服务..."
cd backend
mvn spring-boot:run &

echo "========================================"
echo "后端服务已启动!"
echo "API文档: http://localhost:8080/swagger-ui.html"
echo "========================================"
echo ""
echo "启动前端请运行: cd frontend && flutter run"
