# 🎬 MediaEdit - 专业媒体编辑应用

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.19-02569B?style=for-the-badge&logo=flutter)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2-6DB33F?style=for-the-badge&logo=spring)
![Java](https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=java)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**一款功能强大的移动端媒体编辑应用，支持图片编辑、视频剪辑、AI智能修图等功能**

[功能特性](#-功能特性) • [技术架构](#-技术架构) • [快速开始](#-快速开始) • [截图预览](#-截图预览)

</div>

---

## ✨ 功能特性

### 🖼️ 图片编辑
- **基础调整** - 亮度、对比度、饱和度、色相等参数调节
- **滤镜效果** - 8种精选预设滤镜，一键应用
- **裁剪旋转** - 多种比例裁剪，自由旋转
- **文字贴纸** - 添加个性化文字和贴纸装饰
- **美颜磨皮** - 智能美颜，磨皮美白

### 🎬 视频剪辑
- **视频裁剪** - 精确裁剪视频片段
- **添加音乐** - 本地音乐、在线音乐、录音
- **转场效果** - 淡入淡出、滑动、缩放等丰富转场
- **字幕添加** - 手动添加或智能识别生成字幕
- **变速播放** - 0.25x - 4x 变速控制
- **多质量导出** - 720P / 1080P / 4K 多种画质

### 📷 相机拍摄
- **拍照录像** - 支持拍照和视频录制
- **前后切换** - 一键切换前后摄像头
- **闪光灯控制** - 自动/开启/关闭/常亮
- **AI姿势指导** - 实时分析姿势，给出最佳拍摄建议

### 🤖 AI 智能功能
- **AI美颜** - 智能识别人脸，自动美化
- **姿势分析** - AI分析拍照姿势并给出改进建议
- **智能抠图** - 一键抠图，更换背景
- **风格迁移** - 将照片转换为艺术风格
- **智能修复** - 修复老照片和模糊图片
- **画质增强** - 提升图片清晰度

---

## 🏗️ 技术架构

### 后端 (Spring Boot)

```
backend/
├── src/main/java/com/mediaedit/
│   ├── ai/                  # AI服务集成
│   │   ├── OpenAIService.java
│   │   └── BaiduAIService.java
│   ├── config/              # 配置类
│   ├── controller/          # REST API控制器
│   ├── dto/                 # 数据传输对象
│   ├── entity/              # JPA实体
│   ├── repository/          # 数据访问层
│   ├── security/            # JWT安全认证
│   └── service/             # 业务逻辑层
└── pom.xml
```

**技术栈:**
- Spring Boot 3.2
- Spring Security + JWT
- Spring Data JPA
- MySQL / H2 Database
- MinIO 对象存储
- OpenAI / 百度 AI API

### 前端 (Flutter)

```
frontend/
├── lib/
│   ├── core/                # 核心配置
│   │   ├── config/          # 应用配置
│   │   ├── theme/           # 主题样式
│   │   └── utils/           # 工具类
│   ├── data/                # 数据层
│   │   ├── models/          # 数据模型
│   │   ├── repositories/    # 数据仓库
│   │   └── services/        # API服务
│   └── presentation/        # 展示层
│       ├── bloc/            # BLoC状态管理
│       ├── pages/           # 页面
│       └── widgets/         # 公共组件
└── pubspec.yaml
```

**技术栈:**
- Flutter 3.19
- BLoC 状态管理
- Dio 网络请求
- Camera 相机
- Video Editor 视频编辑
- FFmpeg 视频处理

---

## 🚀 快速开始

### 环境要求

| 工具 | 版本 |
|------|------|
| Java | 17+ |
| Maven | 3.8+ |
| Flutter | 3.0+ |
| MySQL | 8.0+ (可选) |

### 安装步骤

**1. 克隆项目**
```bash
git clone https://github.com/your-username/media-edit-app.git
cd media-edit-app
```

**2. 启动后端**
```bash
cd backend
mvn spring-boot:run
```

后端服务地址: http://localhost:8080

**3. 启动前端**
```bash
cd frontend
flutter pub get
flutter run
```

### 配置 AI 服务

在 `backend/src/main/resources/application.yml` 中配置:

```yaml
# OpenAI
ai:
  openai:
    api-key: your_openai_api_key

# 百度AI
ai:
  baidu:
    api-key: your_baidu_api_key
    secret-key: your_baidu_secret_key
```

---

## 📱 截图预览

| 首页 | 编辑器 | 相机 | 个人中心 |
|:---:|:---:|:---:|:---:|
| 首页展示 | 图片/视频编辑 | AI姿势指导 | 用户信息 |

---

## 📁 项目结构

```
media-edit-app/
├── backend/                 # Spring Boot 后端
│   ├── src/main/java/       # Java 源码
│   └── src/main/resources/  # 配置文件
├── frontend/                # Flutter 前端
│   ├── lib/                 # Dart 源码
│   ├── android/             # Android 配置
│   └── ios/                 # iOS 配置
├── docs/                    # 文档
├── start.bat                # Windows 启动脚本
├── start.sh                 # Linux/macOS 启动脚本
└── SETUP.md                 # 环境配置指南
```

---

## 🔌 API 接口

### 认证接口
| 方法 | 路径 | 说明 |
|------|------|------|
| POST | /api/auth/register | 用户注册 |
| POST | /api/auth/login | 用户登录 |
| GET | /api/auth/me | 获取当前用户 |

### 文件接口
| 方法 | 路径 | 说明 |
|------|------|------|
| POST | /api/files/upload | 上传文件 |
| GET | /api/files/list | 获取文件列表 |
| DELETE | /api/files/{id} | 删除文件 |

### AI接口
| 方法 | 路径 | 说明 |
|------|------|------|
| POST | /api/ai/enhance | AI图片增强 |
| POST | /api/ai/pose-analysis | AI姿势分析 |
| POST | /api/ai/style-transfer | 风格迁移 |

完整API文档: http://localhost:8080/swagger-ui.html

---

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

---

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

---

## 🙏 致谢

- [Spring Boot](https://spring.io/projects/spring-boot)
- [Flutter](https://flutter.dev)
- [OpenAI](https://openai.com)
- [百度AI](https://ai.baidu.com)

---

<div align="center">

**⭐ 如果这个项目对你有帮助，请给一个 Star！**

Made with ❤️ by MediaEdit Team

</div>
