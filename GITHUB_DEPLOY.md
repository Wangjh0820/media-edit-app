# GitHub 部署指南

## 方法一：手动创建仓库

### 步骤 1: 在 GitHub 上创建新仓库

1. 打开浏览器，访问 https://github.com/new
2. 填写仓库信息：
   - **Repository name**: `media-edit-app`
   - **Description**: `专业媒体编辑应用 - 图片编辑、视频剪辑、AI智能修图`
   - **可见性**: 选择 Public（公开）或 Private（私有）
   - **不要勾选**: "Add a README file"、"Add .gitignore"、"Choose a license"
3. 点击 "Create repository"

### 步骤 2: 推送代码到 GitHub

创建仓库后，在项目目录运行以下命令：

```powershell
# 添加远程仓库 (替换 YOUR_USERNAME 为您的 GitHub 用户名)
git remote add origin https://github.com/YOUR_USERNAME/media-edit-app.git

# 推送代码到 GitHub
git branch -M main
git push -u origin main
```

---

## 方法二：使用 GitHub CLI (推荐)

### 安装 GitHub CLI

```powershell
winget install GitHub.cli
```

### 创建仓库并推送

```powershell
# 登录 GitHub
gh auth login

# 创建仓库并推送
gh repo create media-edit-app --public --source=. --push
```

---

## 方法三：使用 SSH (推荐用于长期开发)

### 1. 生成 SSH 密钥

```powershell
ssh-keygen -t ed25519 -C "your_email@example.com"
```

### 2. 添加 SSH 密钥到 GitHub

1. 复制公钥内容：
```powershell
cat ~/.ssh/id_ed25519.pub
```

2. 访问 https://github.com/settings/keys
3. 点击 "New SSH key"，粘贴公钥内容

### 3. 使用 SSH 地址推送

```powershell
git remote set-url origin git@github.com:YOUR_USERNAME/media-edit-app.git
git push -u origin main
```

---

## 验证部署

推送成功后，访问您的仓库页面：
https://github.com/YOUR_USERNAME/media-edit-app

确认以下内容：
- ✅ README.md 正确显示
- ✅ 代码结构完整
- ✅ LICENSE 文件存在

---

## 后续操作

### 设置 GitHub Pages (可选)

如果需要展示项目文档：

1. 访问仓库 Settings > Pages
2. Source 选择 "Deploy from a branch"
3. Branch 选择 "main" 和 "/ (root)"
4. 点击 Save

### 添加 GitHub Actions (CI/CD)

创建 `.github/workflows/ci.yml` 文件实现自动化构建。

### 保护敏感信息

确保不要提交以下内容：
- API 密钥
- 数据库密码
- 私钥文件

这些已在 `.gitignore` 中配置。
