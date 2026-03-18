# ☁️ 云构建指南 - iOS 和 Android

本指南帮助您在没有 Mac 电脑的情况下构建 iOS 应用。

---

## 方法一：GitHub Actions（推荐，免费）

### 步骤 1：推送代码到 GitHub

项目已配置 GitHub Actions 工作流，只需推送代码即可自动构建。

```powershell
cd C:\Users\Administrator\Desktop\game
git add .
git commit -m "Add cloud build configuration"
git push
```

### 步骤 2：查看构建进度

1. 访问您的仓库：https://github.com/Wangjh0820/media-edit-app
2. 点击 **Actions** 标签
3. 查看正在运行的工作流

### 步骤 3：下载构建产物

构建完成后：
1. 点击已完成的工作流
2. 在 **Artifacts** 部分下载：
   - `android-apk` - Android APK 文件
   - `ios-app` - iOS 应用包

---

## 方法二：Codemagic（Flutter 官方推荐）

### 步骤 1：注册 Codemagic

1. 访问：https://codemagic.io
2. 使用 GitHub 账号登录
3. 授权访问您的仓库

### 步骤 2：添加应用

1. 点击 **Add application**
2. 选择 `media-edit-app` 仓库
3. 选择 Flutter 项目类型

### 步骤 3：配置 iOS 签名（可选）

如果需要发布到 App Store：

1. 在 Codemagic 中进入 **Settings** → **iOS signing**
2. 上传您的 Apple Developer 证书
3. 配置 Bundle ID：`com.mediaedit.app`

### 步骤 4：开始构建

1. 点击 **Start new build**
2. 选择 `ios-workflow` 或 `android-workflow`
3. 等待构建完成
4. 下载构建产物

---

## 方法三：Bitrise

### 步骤 1：注册 Bitrise

1. 访问：https://bitrise.io
2. 使用 GitHub 账号登录

### 步骤 2：添加项目

1. 点击 **Add New App**
2. 选择 GitHub 仓库
3. 选择 Flutter 项目

### 步骤 3：配置工作流

Bitrise 会自动检测 Flutter 项目并创建工作流。

---

## 📱 iOS 安装方式

### 方式一：TestFlight（推荐）

1. 在 Codemagic 配置 App Store Connect API
2. 构建完成后自动上传到 TestFlight
3. 通过 TestFlight 安装测试

### 方式二：Xcode 安装

1. 下载 `Runner.app.zip`
2. 在 Mac 上解压
3. 使用 Xcode 安装到 iPhone

### 方式三：AltStore（无需 Mac）

1. 在 Windows 上安装 AltStore
2. 使用 AltStore 安装 .ipa 文件

---

## 🔧 配置文件说明

### codemagic.yaml

已创建在项目根目录，包含：
- iOS 构建工作流
- Android 构建工作流
- 自动邮件通知

### .github/workflows/build.yml

已创建 GitHub Actions 工作流：
- 自动构建 Android APK
- 自动构建 iOS 应用包
- 上传构建产物

---

## 📧 通知配置

构建完成后会发送邮件到：`3074148703@qq.com`

---

## 🆓 免费额度

| 服务 | 免费额度 |
|------|----------|
| GitHub Actions | 2000 分钟/月 |
| Codemagic | 500 分钟/月 |
| Bitrise | 200 分钟/月 |

---

## 🚀 快速开始

**最简单的方式：**

1. 推送代码到 GitHub
2. 等待 Actions 自动构建
3. 下载 iOS 和 Android 安装包

```powershell
# 推送代码
cd C:\Users\Administrator\Desktop\game
git add .
git commit -m "Add cloud build"
git push
```

然后访问 GitHub Actions 页面查看构建进度！
