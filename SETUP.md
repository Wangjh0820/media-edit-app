# MediaEdit 开发环境配置指南

## 系统要求

- **操作系统**: Windows 10/11, macOS, Linux
- **Java**: JDK 17+
- **Maven**: 3.8+
- **Flutter**: 3.0+
- **MySQL**: 8.0+ (可选，默认使用H2内存数据库)

---

## 一、安装 Java 17

✅ 已安装 (Java 17.0.15)

---

## 二、安装 Maven

### Windows

**方法1: 使用 winget**
```powershell
winget install Apache.Maven
```

**方法2: 手动安装**
1. 下载: https://maven.apache.org/download.cgi
2. 解压到 `C:\Program Files\Apache\maven`
3. 添加环境变量:
   - `MAVEN_HOME` = `C:\Program Files\Apache\maven`
   - 在 `Path` 中添加 `%MAVEN_HOME%\bin`
4. 验证: `mvn -version`

### macOS
```bash
brew install maven
```

### Linux
```bash
sudo apt install maven  # Debian/Ubuntu
sudo yum install maven  # CentOS/RHEL
```

---

## 三、安装 Flutter

### Windows

**方法1: 使用 winget**
```powershell
winget install Google.FlutterSDK
```

**方法2: 手动安装**
1. 下载: https://flutter.dev/docs/get-started/install/windows
2. 解压到 `C:\flutter`
3. 添加到环境变量 `Path`: `C:\flutter\bin`
4. 运行: `flutter doctor`

### macOS
```bash
brew install flutter
```

### Linux
```bash
sudo snap install flutter --classic
```

---

## 四、配置数据库 (可选)

### 使用 MySQL

1. 创建数据库:
```sql
CREATE DATABASE media_edit_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. 修改 `backend/src/main/resources/application.yml`:
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/media_edit_db
    username: your_username
    password: your_password
```

### 使用 H2 内存数据库 (默认)

无需配置，项目默认使用 H2 内存数据库进行开发测试。

---

## 五、配置 AI 服务

### OpenAI

在 `application.yml` 中配置:
```yaml
ai:
  openai:
    api-key: your_openai_api_key
```

### 百度 AI

1. 注册百度智能云账号
2. 开通人脸识别、图像处理等服务
3. 配置:
```yaml
ai:
  baidu:
    api-key: your_baidu_api_key
    secret-key: your_baidu_secret_key
```

---

## 六、启动项目

### 启动后端

```bash
cd backend
mvn spring-boot:run
```

后端服务地址:
- API: http://localhost:8080
- Swagger文档: http://localhost:8080/swagger-ui.html

### 启动前端

```bash
cd frontend
flutter pub get
flutter run
```

---

## 七、开发工具推荐

### IDE

- **后端**: IntelliJ IDEA Ultimate / Eclipse / VS Code
- **前端**: VS Code + Flutter 插件 / Android Studio

### VS Code 插件

- Flutter
- Dart
- Spring Boot Extension Pack
- Java Extension Pack

---

## 八、常见问题

### Q: Maven 下载依赖慢?
A: 配置国内镜像，编辑 `~/.m2/settings.xml`:
```xml
<mirror>
    <id>aliyun</id>
    <mirrorOf>central</mirrorOf>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```

### Q: Flutter 依赖下载慢?
A: 配置国内镜像:
```powershell
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

### Q: 端口被占用?
A: 修改 `application.yml` 中的端口号:
```yaml
server:
  port: 8081
```

---

## 九、项目结构

```
game/
├── backend/                 # Spring Boot 后端
│   ├── src/main/java/       # Java 源码
│   ├── src/main/resources/  # 配置文件
│   └── pom.xml              # Maven 配置
├── frontend/                # Flutter 前端
│   ├── lib/                 # Dart 源码
│   ├── android/             # Android 配置
│   ├── ios/                 # iOS 配置
│   └── pubspec.yaml         # Flutter 配置
├── start.bat                # Windows 启动脚本
└── start.sh                 # Linux/macOS 启动脚本
```

---

## 十、技术栈

### 后端
- Spring Boot 3.2
- Spring Security + JWT
- Spring Data JPA
- MySQL / H2
- MinIO 对象存储
- OpenAI / 百度 AI

### 前端
- Flutter 3.x
- BLoC 状态管理
- Dio 网络请求
- Camera 相机
- Video Editor 视频编辑
