# 🎥 Bilibili视频AI总结工具

一个完全自动化的B站视频内容总结工具，支持会员和加密视频。

## ✨ 特性

- ✅ **支持所有视频类型** - 包括会员、加密、付费内容
- ✅ **自动音频捕获** - 使用浏览器自动化和虚拟音频设备
- ✅ **AI转录** - 使用OpenAI Whisper高精度语音识别
- ✅ **智能总结** - 生成详细的视频内容总结（观点+论据+细节）
- ✅ **一键操作** - 配置完成后，只需提供视频链接

---

## 📦 安装步骤

### 前置要求

- **Node.js** (v14+)
- **Python** (v3.8+)
- **FFmpeg** (音频处理)
- **虚拟音频设备** (用于捕获系统音频)

### 1. 安装基础工具

#### Mac 用户

```bash
# 安装Homebrew（如未安装）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装Node.js
brew install node

# 安装Python
brew install python@3.11

# 安装FFmpeg
brew install ffmpeg

# 安装BlackHole虚拟音频设备
brew install blackhole-2ch

# 配置音频设备
# 系统设置 > 声音 > 输出 > 选择 "BlackHole 2ch"
```

#### Windows 用户

```powershell
# 安装Chocolatey包管理器（如未安装）
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# 安装Node.js
choco install nodejs

# 安装Python
choco install python

# 安装FFmpeg
choco install ffmpeg

# 安装VB-Cable虚拟音频设备
# 手动下载安装: https://vb-audio.com/Cable/
# 安装后在 设置 > 系统 > 声音 > 输出设备 选择 "CABLE Input"
```

### 2. 安装项目依赖

```bash
# 安装Node.js依赖
npm install playwright

# 安装Playwright浏览器
npx playwright install chromium

# 安装Python依赖
pip3 install openai-whisper

# （可选）如果需要GPU加速
pip3 install openai-whisper[gpu]

# （可选）使用 --auto-summary 或 --correct-transcript 时需安装
pip3 install openai python-dotenv
```

**配置 API Key（.env 方式，推荐）**：在项目目录创建 `.env` 文件，无需每次 export：
```bash
cp .env.example .env
# 编辑 .env，填入你的 DEEPSEEK_API_KEY
```

### 3. 配置虚拟音频设备

#### Mac (BlackHole)

1. 打开 **Audio MIDI Setup** (音频MIDI设置)
2. 点击左下角 "+" → **Create Multi-Output Device** (创建多输出设备)
3. 勾选：
   - ✅ BlackHole 2ch
   - ✅ 你的扬声器/耳机
4. 右键点击新设备 → **Use This Device For Sound Output**
5. 系统现在会同时输出到扬声器和BlackHole

#### Windows (VB-Cable)

1. 右键点击任务栏音量图标 → **声音设置**
2. **输出设备** 选择 **CABLE Input (VB-Audio Virtual Cable)**
3. 打开 **声音控制面板** → **录制**
4. 右键点击 **CABLE Output** → **启用**
5. 现在音频会路由到虚拟设备

---

## 🚀 使用方法

### 快速开始

整个流程分为两步：

#### 步骤1：捕获视频音频（本地运行）

**方法A：使用现有浏览器登录状态（推荐）**

```bash
node capture-bilibili-audio.js "https://www.bilibili.com/video/BV1kmFsz4E6q/" "output.mp3" --use-chrome-profile
```

✅ **自动解决登录问题** - 直接使用你Chrome中的B站、小红书、YouTube等登录状态
✅ **无需手动操作** - 自动识别会员权限
✅ **支持所有平台** - 任何你在Chrome中登录过的视频网站

**方法B：基础模式（需要手动登录）**

```bash
node capture-bilibili-audio.js "https://www.bilibili.com/video/BV1kmFsz4E6q/" "output.mp3"
```

如果检测到需要登录，脚本会提示你在浏览器中手动登录。

**处理长视频（1小时以上）**

```bash
# 默认支持3小时，如需更长（如5小时）：
node capture-bilibili-audio.js "视频URL" "output.mp3" --use-chrome-profile --max-duration 18000000
```

**这个脚本会：**
1. 自动打开浏览器并导航到视频页面
2. 如使用`--use-chrome-profile`，自动加载你的登录状态
3. 播放视频
4. 在后台录制音频
5. 视频结束后自动停止并保存

**注意事项：**
- ⚠️ 确保系统音频输出已切换到虚拟音频设备
- ⚠️ 浏览器会显示在前台，请不要关闭
- ✅ 使用`--use-chrome-profile`可自动登录（无需手动操作）
- ⚠️ 录音期间请关闭其他音频播放

#### 步骤2：转录和总结（本地运行 + AI 总结）

```bash
python3 transcribe-and-summarize.py output.mp3 --video-url "https://www.bilibili.com/video/BV1kmFsz4E6q/"
```

**这个脚本会：**
1. 使用Whisper将音频转录为文字
2. 保存完整转录文本
3. 生成总结提示（或使用 --auto-summary 自动调用 DeepSeek）

**若不使用自动总结，你需要：**
1. 将生成的转录文本上传给任意 AI（Claude、DeepSeek 等）
2. AI 会自动生成详细总结
3. 总结会保存为文档

---

## 📝 完整示例

### 示例1：处理普通视频

```bash
# 1. 捕获音频
node capture-bilibili-audio.js "https://www.bilibili.com/video/BV14rFszaEem/" "morgan-stanley.mp3"

# 2. 转录和准备总结
python3 transcribe-and-summarize.py morgan-stanley.mp3 --video-url "https://www.bilibili.com/video/BV14rFszaEem/"

# 3. 上传转录文本给 AI 进行总结（或使用 --auto-summary 自动生成）
```

### 示例2：处理会员视频

```bash
# 1. 捕获音频（浏览器会打开，请在浏览器中登录）
node capture-bilibili-audio.js "https://www.bilibili.com/video/BV1kmFsz4E6q/" "vip-video.mp3"

# 等待浏览器打开后：
# - 如果需要登录，在浏览器中完成登录
# - 脚本会自动等待并继续

# 2. 转录
python3 transcribe-and-summarize.py vip-video.mp3 --video-url "https://www.bilibili.com/video/BV1kmFsz4E6q/"

# 3. 上传给 AI 总结（或使用 --auto-summary 自动生成）
```

---

## 🎛️ 高级选项

### 音频捕获脚本参数

```bash
node capture-bilibili-audio.js <视频URL> [输出文件名] [选项]

# 示例
node capture-bilibili-audio.js "https://bilibili.com/video/BV123456" "my-video.mp3"

# 浏览器溢出屏幕时，可指定视口大小
node capture-bilibili-audio.js "视频URL" "output.mp3" --viewport 1280x720

# Mac: FFmpeg 录制不稳定时，可尝试 sox 备选（输出 FLAC）
node capture-bilibili-audio.js "视频URL" "output.flac" --use-sox
```

**视口/窗口适配：** 脚本会自动检测屏幕大小并适配浏览器窗口。若仍溢出，可用 `--viewport 宽x高` 手动指定（如 `1280x720`），或设置环境变量 `VIEWPORT_SIZE=1280x720`。

**--use-sox：** Mac 专用。若 FFmpeg 与 BlackHole 组合录制出空文件或杂音，可尝试 `brew install sox` 后使用此选项，输出为 FLAC 格式。

### 转录脚本参数

```bash
python3 transcribe-and-summarize.py <音频文件> [选项]

选项:
  --video-url URL      视频URL（用于获取元数据，也用于 initial_prompt 提升转录准确率）
  --model MODEL        Whisper模型: tiny, base, small, medium, large (默认: base)
  --output-dir DIR     输出目录 (默认: output/，内含 transcripts/ 和 summaries/)
  --no-summary         只转录，不生成总结提示
  --auto-summary       自动调用 DeepSeek API 生成总结，需设置 DEEPSEEK_API_KEY
  --correct-transcript 使用 DeepSeek 纠正转录中的同音字错误，需 DEEPSEEK_API_KEY
```

### Whisper模型选择

| 模型 | 大小 | 速度 | 准确度 | 推荐使用场景 |
|------|------|------|--------|--------------|
| tiny | 39M | 最快 | 较低 | 仅快速测试，**中文同音字错误较多，不推荐** |
| base | 74M | 快 | 良好 | **推荐默认** |
| small | 244M | 中等 | 很好 | **追求准确率时推荐** |
| medium | 769M | 慢 | 优秀 | 专业场景 |
| large | 1550M | 最慢 | 最佳 | 最高精度 |

**转录准确率提示**：中文同音字多，Whisper 易产生歧义。脚本会利用视频标题/简介作为 `initial_prompt` 提升专有名词识别。若错误仍多，建议使用 `--model small` 或 `medium`。

```bash
# 追求更高准确率（减少同音字错误）
python3 transcribe-and-summarize.py audio.mp3 --video-url "URL" --model small
```

**自动总结与纠错**：在项目目录创建 `.env` 并填入 `DEEPSEEK_API_KEY` 后可使用：
```bash
# 自动生成总结并保存为 *_summary_*.md
python3 transcribe-and-summarize.py audio.mp3 --video-url "URL" --auto-summary

# 纠正转录中的同音字错误
python3 transcribe-and-summarize.py audio.mp3 --video-url "URL" --correct-transcript
```
（也可用 `export DEEPSEEK_API_KEY="key"` 或在 ~/.zshrc 中配置）

---

## ❓ 常见问题

### Q1: 视频需要登录 / 出现登录弹框怎么办？

**推荐方案**：使用已打开的 Chrome（不关闭浏览器）

```bash
# 1. 首次使用：以远程调试模式启动 Chrome
./start_chrome_for_capture.sh

# 2. 在 Chrome 中登录 B 站后，运行
./QUICK_START.sh "视频URL"
```

或使用 `capture-video-auto.js` 直接连接：

```bash
node capture-video-auto.js "视频URL" "output/audio/video-audio.mp3" --use-existing-chrome
```

（需先运行 `./start_chrome_for_capture.sh` 启动 Chrome）

**备选**：使用 `--use-system-chrome` 需先关闭 Chrome，再由脚本启动新实例。

### Q2: 视频超过1小时怎么办？

默认支持3小时视频。如需更长：

```bash
# 5小时 = 18000000毫秒
node capture-bilibili-audio.js "视频URL" "output.mp3" --max-duration 18000000

# 或结合登录状态：
node capture-bilibili-audio.js "视频URL" "output.mp3" --use-chrome-profile --max-duration 18000000
```

**时长参考**：
- 1小时 = 3600000
- 2小时 = 7200000
- 3小时 = 10800000（默认）
- 5小时 = 18000000

### Q3: 支持哪些视频平台？

理论上支持**所有**网页视频平台：
- ✅ Bilibili（B站）
- ✅ 小红书
- ✅ YouTube
- ✅ 抖音网页版
- ✅ 腾讯视频
- ✅ 爱奇艺
- ✅ 优酷
- ✅ 任何HTML5视频播放器

只要：
1. 视频能在浏览器中播放
2. 使用了标准的`<video>`标签

### Q4: 会员/付费视频可以录制吗？

可以！使用 `--use-chrome-profile` 即可。

**重要**：
- ✅ 仅限个人学习使用
- ❌ 不要分发录制内容
- ❌ 不要用于商业目的
- 请尊重内容创作者的版权

## 🔧 故障排除

### 问题1：FFmpeg未找到

**错误信息**: `FFmpeg 未安装`

**解决方法**:
```bash
# Mac
brew install ffmpeg

# Windows
choco install ffmpeg

# 或手动下载: https://ffmpeg.org/download.html
```

### 问题2：虚拟音频设备无法工作 / 音频文件为 0 字节

**症状**: 生成的音频文件为空或很小（0 字节）

**解决方法**:
1. 确认虚拟音频设备已正确安装，多输出设备包含 BlackHole 和扬声器
2. 确认系统音频输出已切换到多输出设备
3. **在系统「终端.app」中运行**（而非 IDE 内置终端），macOS 对 IDE 启动的进程可能限制音频访问
4. 若 FFmpeg 持续不稳定，可尝试 sox 备选方案：
   ```bash
   brew install sox
   node capture-bilibili-audio.js "视频URL" "output.flac" --use-sox
   ```
   sox 输出为 FLAC 格式，Whisper 转录同样支持

### 问题3：浏览器无法打开视频

**症状**: `页面加载超时` 或 `视频播放器未找到`

**解决方法**:
1. 检查网络连接
2. 确认视频URL正确
3. 手动在浏览器中访问视频确认可访问
4. 如果是地区限制，可能需要代理

### 问题4：Whisper转录错误

**错误信息**: `转录失败` 或 模型下载失败

**解决方法**:
```bash
# 重新安装Whisper
pip3 uninstall openai-whisper
pip3 install openai-whisper

# 手动下载模型（如果网络问题）
python3 -c "import whisper; whisper.load_model('base')"
```

### 问题5：音频质量差/不清晰

**解决方法**:
1. 确保视频播放音量适中（不要静音或太小）
2. 关闭其他音频播放
3. 使用更好的Whisper模型（如 `--model small`）
4. 检查录音设备是否正确配置

---

## 📊 输出文件说明

脚本会生成以下文件：

### 1. 音频文件 (*.mp3)
- 从视频中捕获的音频
- 用于转录输入

### 2. 转录文本 (*_transcript_*.txt)
```
================================
视频完整转录
================================

视频URL: https://...
生成时间: 2026-02-07 12:00:00

--------------------------------
完整文本:
--------------------------------

[转录的完整文字内容]

================================
时间轴分段:
================================

[00:00 - 00:15] 大家好，今天我们来讨论...
[00:15 - 00:30] 首先第一个观点是...
...
```

### 3. 视频总结 (*_summary_*.md)
```markdown
# 视频总结

**视频链接**: https://...
**生成时间**: 2026-02-07 12:00:00

---

## 概述
[视频主旨总结]

## 核心观点
1. [观点1]
2. [观点2]
...

## 论据和细节
...

## 深度分析
...

## 结论和启示
...
```

---

## 💡 最佳实践

### 1. 首次使用前测试

建议先用一个短视频（2-3分钟）测试整个流程：

```bash
# 使用一个短视频测试
node capture-bilibili-audio.js "https://www.bilibili.com/video/BV短视频/" "test.mp3"
python3 transcribe-and-summarize.py test.mp3 --model tiny
```

### 2. 长视频处理策略

对于超过1小时的视频：
- 使用 `base` 模型（平衡速度和质量）
- 确保磁盘空间充足（音频文件可能很大）
- 转录可能需要10-30分钟

### 3. 批量处理

创建批处理脚本处理多个视频：

```bash
#!/bin/bash
# batch-process.sh

VIDEOS=(
  "https://www.bilibili.com/video/BV1..."
  "https://www.bilibili.com/video/BV2..."
  "https://www.bilibili.com/video/BV3..."
)

for url in "${VIDEOS[@]}"; do
  bv=$(echo $url | grep -oP 'BV\w+')
  echo "处理: $bv"

  node capture-bilibili-audio.js "$url" "${bv}.mp3"
  python3 transcribe-and-summarize.py "${bv}.mp3" --video-url "$url"

  echo "完成: $bv"
  echo "---"
done
```

### 4. 优化音频质量

如果转录质量不佳：
1. 调整视频播放音量到70-80%
2. 使用更好的Whisper模型
3. 确保录音环境安静（关闭其他应用）

---

## 🔮 未来规划

- [ ] **完全自动化**: 一键运行整个流程
- [ ] **Web界面**: 提供图形化操作界面
- [ ] **云端处理**: 支持上传到云端处理
- [ ] **字幕优先**: 优先尝试获取官方字幕
- [ ] **多平台支持**: 扩展到YouTube、抖音等

---

## 📄 许可和免责声明

**仅供个人学习使用**

- ⚠️ 请遵守B站服务条款
- ⚠️ 不要分发或商用处理后的内容
- ⚠️ 尊重原创者版权
- ⚠️ 会员内容仅限个人观看和学习

---

## 🆘 需要帮助？

如遇到问题：

1. **查看故障排除部分** - 大部分常见问题都有解决方案
2. **检查系统配置** - 确认所有依赖都已正确安装
3. **测试独立组件** - 分别测试音频捕获和转录功能
4. **联系支持** - 提供详细的错误信息和系统信息

---

## 🎉 开始使用

现在你已经准备好了！运行你的第一个视频总结：

```bash
# 快速开始
node capture-bilibili-audio.js "你的视频URL" "output.mp3"
python3 transcribe-and-summarize.py output.mp3 --video-url "你的视频URL"
```

祝你使用愉快！🚀
