#!/bin/bash
# 视频总结工具 - 快速开始脚本

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║            视频总结工具 - 快速开始                          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# 检查是否传入视频URL
if [ -z "$1" ]; then
    echo "❌ 请提供视频URL"
    echo ""
    echo "使用方法:"
    echo "  ./QUICK_START.sh "视频URL" [输出文件名]"
    echo ""
    echo "示例:"
    echo "  ./QUICK_START.sh "https://www.bilibili.com/video/BV1kmFsz4E6q/" "output.flac""
    exit 1
fi

VIDEO_URL="$1"
# 从 URL 提取视频 ID 作为默认文件名（B站 BV 号等），便于追踪
VIDEO_ID=$(echo "$VIDEO_URL" | grep -oE 'BV[0-9a-zA-Z]+' | head -1)
[ -z "$VIDEO_ID" ] && VIDEO_ID="video-audio"
OUTPUT_FILE="${2:-output/audio/${VIDEO_ID}.flac}"

echo "📹 视频URL: $VIDEO_URL"
echo "💾 输出文件: $OUTPUT_FILE"
echo ""

# 步骤1: 捕获音频（连接已打开的 Chrome，不关闭浏览器）
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "步骤 1/3: 捕获视频音频（连接已打开的 Chrome）"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "💡 首次使用请运行: ./start_chrome_for_capture.sh  （然后登录 B 站）"
echo ""

if [ ! -f "capture-video-auto.js" ]; then
    echo "❌ 找不到 capture-video-auto.js"
    exit 1
fi

node capture-video-auto.js "$VIDEO_URL" "$OUTPUT_FILE" --use-sox --use-existing-chrome --auto

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ 音频捕获失败"
    exit 1
fi

# 步骤2: 转录、纠错、总结
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "步骤 2/2: 转录 + 纠错 + AI 总结（需配置 DEEPSEEK_API_KEY）"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ ! -f "transcribe-and-summarize.py" ]; then
    echo "❌ 找不到 transcribe-and-summarize.py"
    exit 1
fi

python3 transcribe-and-summarize.py "$OUTPUT_FILE" --video-url "$VIDEO_URL" --correct-transcript --auto-summary

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ 转录失败"
    exit 1
fi

# 完成
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    ✅ 全部完成！                             ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "📄 生成的文件:"
echo "   - 音频: $OUTPUT_FILE"
echo "   - 转录: output/transcripts/"
echo "   - 总结: output/summaries/"
echo ""
