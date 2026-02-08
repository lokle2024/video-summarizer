# 🎥 视频总结工具项目

AI驱动的视频内容自动总结工具，支持B站、小红书、YouTube等主流平台。

---

## 📦 项目文件结构

```
video-summarizer/
├── README.md                           # 完整使用文档
├── PROJECT_INFO.md                     # 项目说明（本文件）
│
├── capture-bilibili-audio.js           # 音频捕获脚本（基础版）
├── capture-video-auto.js              # 音频捕获脚本（自动登录版）★推荐
│
├── transcribe-and-summarize.py        # Whisper转录和AI总结脚本
│
├── package.json                        # Node.js项目配置
└── install.sh                          # 一键安装脚本
```

---

## 🚀 快速开始

### 1. 安装依赖（首次使用）

```bash
cd video-summarizer
./install.sh
```

### 2. 使用自动登录版本（推荐）

```bash
# 关闭Chrome
killall "Google Chrome"

# 运行脚本（自动使用Chrome登录状态）
node capture-video-auto.js "视频URL" "output.mp3"
```

### 3. 转录和总结

```bash
python3 transcribe-and-summarize.py output.mp3 --video-url "视频URL"
```

### 4. 上传转录文本给Claude，生成详细总结

---

## 📝 两个版本对比

### capture-video-auto.js（推荐）⭐
- ✅ 自动使用Chrome登录状态
- ✅ 支持所有平台（B站、小红书、YouTube等）
- ✅ 无需手动登录
- ✅ 默认支持3小时视频
- 使用方法：`node capture-video-auto.js "视频URL" "output.mp3"`

### capture-bilibili-audio.js（基础版）
- ⚠️ 需要手动登录（或使用 --use-chrome-profile 参数）
- 适合只需要临时使用的情况
- 使用方法：`node capture-bilibili-audio.js "视频URL" "output.mp3"`

---

## 🔧 系统要求

- **Node.js** v14+
- **Python** 3.8+
- **FFmpeg** 音频处理
- **虚拟音频设备**：
  - Mac: BlackHole 2ch
  - Windows: VB-Cable

---

## ✨ 功能特点

1. **自动登录**
   - 复用Chrome登录状态
   - 支持会员/付费内容
   - 支持所有视频平台

2. **长视频支持**
   - 默认3小时
   - 可自定义任意时长

3. **高精度转录**
   - 使用OpenAI Whisper
   - 支持多种模型（base/small/medium）

4. **AI智能总结**
   - 提取核心观点
   - 保留论据细节
   - 生成结构化文档

---

## 📖 详细文档

查看 [README.md](./README.md) 获取完整使用说明，包括：
- 详细安装步骤
- 常见问题解答
- 故障排除指南
- 最佳实践建议

---

## 🎯 典型使用场景

- 📚 学习笔记：自动总结教育视频
- 📊 会议纪要：记录线上会议内容
- 🎬 内容整理：批量处理视频资料
- 🔍 信息提取：快速获取视频要点

---

## ⚠️ 重要提醒

1. **版权尊重**
   - 仅限个人学习使用
   - 不要分发录制内容
   - 尊重内容创作者权益

2. **系统配置**
   - 确保虚拟音频设备已安装
   - 录音前切换系统音频输出
   - 关闭其他音频播放

3. **Chrome配置**
   - 使用自动登录版时需关闭Chrome
   - 脚本需要独占访问Chrome配置

---

## 🆘 需要帮助？

查看 [README.md](./README.md) 中的故障排除部分，或联系支持。

---

**创建时间**: 2026-02-08
**版本**: 1.0
**作者**: lok,Claude AI,Cursor
