#!/bin/bash
# Bilibili视频总结工具 - 一键安装脚本

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║          Bilibili视频总结工具 - 自动安装                    ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# 检测操作系统
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    CYGWIN*)    MACHINE=Windows;;
    MINGW*)     MACHINE=Windows;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo "🖥️  检测到操作系统: $MACHINE"
echo ""

# 检查必要工具
echo "🔍 检查必要工具..."
echo ""

# 检查Node.js
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version)
    echo "✅ Node.js 已安装: $NODE_VERSION"
else
    echo "❌ Node.js 未安装"
    if [ "$MACHINE" = "Mac" ]; then
        echo "   安装命令: brew install node"
    elif [ "$MACHINE" = "Windows" ]; then
        echo "   安装命令: choco install nodejs"
    else
        echo "   访问: https://nodejs.org/"
    fi
    exit 1
fi

# 检查Python
if command -v python3 >/dev/null 2>&1; then
    PYTHON_VERSION=$(python3 --version)
    echo "✅ Python3 已安装: $PYTHON_VERSION"
else
    echo "❌ Python3 未安装"
    exit 1
fi

# 检查FFmpeg
if command -v ffmpeg >/dev/null 2>&1; then
    echo "✅ FFmpeg 已安装"
else
    echo "❌ FFmpeg 未安装"
    if [ "$MACHINE" = "Mac" ]; then
        echo "   安装命令: brew install ffmpeg"
    elif [ "$MACHINE" = "Windows" ]; then
        echo "   安装命令: choco install ffmpeg"
    fi
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 安装项目依赖..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 安装Node.js依赖
echo "⏳ 安装Node.js依赖 (playwright)..."
npm install
if [ $? -eq 0 ]; then
    echo "✅ Node.js依赖安装成功"
else
    echo "❌ Node.js依赖安装失败"
    exit 1
fi

echo ""
echo "⏳ 安装Playwright浏览器..."
npx playwright install chromium
if [ $? -eq 0 ]; then
    echo "✅ Playwright浏览器安装成功"
else
    echo "❌ Playwright浏览器安装失败"
    exit 1
fi

echo ""
echo "⏳ 安装Python依赖 (openai-whisper)..."
pip3 install openai-whisper
if [ $? -eq 0 ]; then
    echo "✅ Python依赖安装成功"
else
    echo "❌ Python依赖安装失败"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚠️  配置虚拟音频设备"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$MACHINE" = "Mac" ]; then
    echo "Mac用户需要安装BlackHole虚拟音频设备："
    echo ""
    echo "1. 安装BlackHole:"
    echo "   brew install blackhole-2ch"
    echo ""
    echo "2. 配置音频路由:"
    echo "   - 打开 Audio MIDI Setup"
    echo "   - 创建 Multi-Output Device"
    echo "   - 勾选 BlackHole 2ch 和你的扬声器"
    echo "   - 将新设备设为输出"
    echo ""

    # 尝试自动安装BlackHole
    if command -v brew >/dev/null 2>&1; then
        echo "⏳ 尝试自动安装BlackHole..."
        brew install blackhole-2ch
        if [ $? -eq 0 ]; then
            echo "✅ BlackHole安装成功"
        else
            echo "⚠️  BlackHole安装失败，请手动安装"
        fi
    else
        echo "⚠️  未检测到Homebrew，请手动安装BlackHole"
    fi

elif [ "$MACHINE" = "Windows" ]; then
    echo "Windows用户需要安装VB-Cable虚拟音频设备："
    echo ""
    echo "1. 下载VB-Cable:"
    echo "   https://vb-audio.com/Cable/"
    echo ""
    echo "2. 安装后配置:"
    echo "   - 设置 > 系统 > 声音"
    echo "   - 输出设备选择 'CABLE Input'"
    echo "   - 录制设备启用 'CABLE Output'"
    echo ""
fi

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    ✅ 安装完成！                             ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "📝 下一步:"
echo ""
echo "1. 配置虚拟音频设备（见上方说明）"
echo ""
echo "2. 测试工具:"
echo "   node capture-bilibili-audio.js "视频URL" "test.mp3""
echo ""
echo "3. 转录和总结:"
echo "   python3 transcribe-and-summarize.py test.mp3 --video-url "视频URL""
echo ""
echo "4. 查看完整文档:"
echo "   cat README.md"
echo ""
echo "🎉 开始使用吧！"
