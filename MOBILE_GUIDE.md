# 📱 手机端使用指南

## 一、环境准备

### 1. 安装 Flutter SDK

**Windows:**
```powershell
winget install Google.FlutterSDK
```

**或手动安装:**
1. 下载: https://flutter.dev/docs/get-started/install/windows
2. 解压到 `C:\flutter`
3. 添加到系统环境变量 Path: `C:\flutter\bin`
4. 重启终端，运行 `flutter doctor` 检查环境

### 2. 安装 Android Studio（用于 Android 开发）

1. 下载: https://developer.android.com/studio
2. 安装后打开，进入 SDK Manager
3. 安装 Android SDK、Android SDK Command-line Tools

### 3. 配置 Flutter

```powershell
flutter doctor
```

根据提示安装缺失的组件。

---

## 二、连接手机

### Android 手机

1. **开启开发者模式:**
   - 设置 → 关于手机 → 连续点击"版本号" 7 次

2. **开启 USB 调试:**
   - 设置 → 开发者选项 → 开启 USB 调试

3. **连接电脑:**
   - 用 USB 数据线连接手机和电脑
   - 手机上选择"文件传输"或"充电"模式
   - 弹出授权对话框时，点击"允许"

4. **验证连接:**
```powershell
flutter devices
```
应显示您的手机设备

### iOS 手机

需要 macOS 环境和 Xcode:
1. 用数据线连接 iPhone 到 Mac
2. 在 Xcode 中配置开发者账号
3. 信任开发者证书

---

## 三、运行应用

### 开发模式（热重载）

```powershell
cd frontend
flutter pub get
flutter run
```

应用会直接安装到手机并运行，支持热重载。

### 构建 Release 版本

**Android APK:**
```powershell
cd frontend
flutter build apk --release
```

APK 文件位置: `build/app/outputs/flutter-apk/app-release.apk`

**Android App Bundle (用于上架 Google Play):**
```powershell
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 四、安装 APK 到手机

### 方法 1: USB 传输

1. 将 `app-release.apk` 复制到手机
2. 在手机文件管理器中点击 APK
3. 允许安装未知来源应用
4. 完成安装

### 方法 2: ADB 安装

```powershell
adb install build/app/outputs/flutter-apk/app-release.apk
```

### 方法 3: 二维码下载

将 APK 上传到云存储，生成下载链接和二维码，手机扫码下载。

---

## 五、连接后端服务

### 本地开发环境

手机和电脑在同一局域网下:

1. **查看电脑 IP 地址:**
```powershell
ipconfig
```
找到 IPv4 地址，如 `192.168.1.100`

2. **修改前端配置:**

编辑 `frontend/lib/core/config/app_config.dart`:
```dart
static const String baseUrl = 'http://192.168.1.100:8080/api';
```

3. **启动后端服务:**
```powershell
cd backend
mvn spring-boot:run
```

### 部署到服务器

将后端部署到云服务器，修改 baseUrl 为服务器地址。

---

## 六、功能使用说明

### 首页
- 查看最近项目
- 快速进入图片/视频编辑

### 编辑器
- **图片编辑**: 滤镜、裁剪、美颜、文字
- **视频剪辑**: 裁剪、音乐、转场、字幕

### 相机
- 拍照/录像
- AI 姿势指导
- 闪光灯控制

### 个人中心
- 用户信息
- 存储空间
- VIP 会员

---

## 七、常见问题

### Q: flutter doctor 报错?

运行以下命令:
```powershell
flutter doctor --android-licenses
```
接受所有许可协议。

### Q: 手机连接不上?

1. 确认 USB 调试已开启
2. 尝试更换 USB 数据线
3. 安装手机驱动程序
4. 运行 `adb devices` 检查

### Q: 应用闪退?

1. 检查后端服务是否运行
2. 确认网络连接正常
3. 查看 Logcat 日志:
```powershell
flutter logs
```

### Q: 无法访问后端 API?

1. 确保手机和电脑在同一局域网
2. 检查防火墙设置，开放 8080 端口
3. 使用电脑 IP 地址而非 localhost

---

## 八、快速命令参考

| 命令 | 说明 |
|------|------|
| `flutter doctor` | 检查环境 |
| `flutter devices` | 列出设备 |
| `flutter pub get` | 获取依赖 |
| `flutter run` | 运行应用 |
| `flutter build apk` | 构建 APK |
| `flutter clean` | 清理构建 |
| `flutter upgrade` | 升级 Flutter |

---

## 九、下一步

1. ✅ 安装 Flutter SDK
2. ✅ 连接手机
3. ✅ 运行应用
4. ✅ 启动后端服务
5. ✅ 开始使用！

有问题随时查看官方文档: https://flutter.dev/docs
