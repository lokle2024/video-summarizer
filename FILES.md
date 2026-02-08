# 项目文件说明

## 核心程序文件（必需）

| 文件 | 作用 |
|------|------|
| `capture-bilibili-audio.js` | 音频捕获脚本（基础版）。用 Playwright 打开 B 站视频并录制音频，支持 FFmpeg/sox |
| `capture-video-auto.js` | 音频捕获脚本（**推荐**）。自动使用 Chrome 登录状态，支持 B 站/小红书/YouTube 等 |
| `transcribe-and-summarize.py` | 转录与总结脚本。Whisper 转写 + DeepSeek 纠错/总结 |
| `package.json` | Node.js 依赖配置 |
| `requirements.txt` | Python 依赖配置 |

## 配置与文档

| 文件 | 作用 |
|------|------|
| `.env` | 环境变量（DEEPSEEK_API_KEY 等），**不要提交到 Git** |
| `README.md` | 完整使用文档 |
| `PROJECT_INFO.md` | 项目简介与快速开始 |
| `FILES.md` | 本文件，各文件作用说明 |

## 脚本与安装

| 文件 | 作用 |
|------|------|
| `install.sh` | 一键安装脚本（Node/Python/FFmpeg 依赖） |
| `QUICK_START.sh` | 快速开始：连接已打开的 Chrome → 捕获 → 转录 |
| `start_chrome_for_capture.sh` | 以远程调试模式启动 Chrome（首次使用需运行） |

## 提示词配置

| 目录/文件 | 作用 |
|-----------|------|
| `prompts/summary_prompt.txt` | 视频总结提示词，可编辑 |
| `prompts/correction_prompt.txt` | 转录纠错提示词，可编辑 |
| `prompts/README.md` | 占位符说明 |

## 目录结构

| 目录 | 作用 |
|------|------|
| `node_modules/` | Node.js 依赖（npm install 生成） |
| `output/` | 所有输出文件归档目录（见下方） |
| `output/logs/processing_log.md` | 处理日志（Markdown），记录每次处理的视频信息 |

## 输出目录 `output/` 结构

```
output/
├── audio/          # 捕获的音频文件 (.mp3, .flac)
├── transcripts/    # 转录文本 (*_transcript_*.txt)
└── summaries/      # 视频总结 (*_summary_*.md)
```

## 登录弹框解决方案

- **推荐**：使用 `--use-existing-chrome`，连接已打开的 Chrome，**不关闭浏览器**。需先运行 `./start_chrome_for_capture.sh` 启动 Chrome，再执行 `./QUICK_START.sh "视频URL"`
- **备选**：`--use-system-chrome` 需先关闭 Chrome，由脚本启动新实例
- 脚本会尝试自动关闭 B 站登录弹窗

## 可删除文件（临时/测试）

- `test-audio.mp3`、`test-capture.mp3`：测试用音频（已删除）
- 根目录下散落的 `*_transcript_*.txt`、`*_summary_*.md`：已归档到 `output/`
