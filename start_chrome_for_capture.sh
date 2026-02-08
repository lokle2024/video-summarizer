#!/bin/bash
# 以远程调试模式启动 Chrome，供 capture 脚本连接
# 使用方式：./start_chrome_for_capture.sh
# 运行后请登录 B 站，然后执行 ./QUICK_START.sh "视频URL"

PORT=${CHROME_DEBUG_PORT:-9222}

echo "🚀 以远程调试模式启动 Chrome（端口 $PORT）"
echo ""
echo "⚠️  若 Chrome 已打开，将先关闭再以调试模式重启（需手动保存未保存的标签）"
echo ""
echo "启动后请："
echo "  1. 在弹出的 Chrome 窗口中登录 B 站（使用独立配置，登录一次即可）"
echo "  2. 保持 Chrome 打开"
echo "  3. 在终端运行: ./QUICK_START.sh \"视频URL\""
echo ""

if [[ "$OSTYPE" == "darwin"* ]]; then
  killall "Google Chrome" 2>/dev/null
  sleep 2
  # Chrome 远程调试要求使用非默认 user-data-dir
  CHROME_DEBUG_DIR="$HOME/Library/Application Support/VideoCaptureChrome"
  mkdir -p "$CHROME_DEBUG_DIR"
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
    --remote-debugging-port=$PORT \
    --user-data-dir="$CHROME_DEBUG_DIR" &
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
  taskkill //F //IM chrome.exe 2>/dev/null
  sleep 2
  start chrome.exe --remote-debugging-port=$PORT
else
  echo "请手动以远程调试模式启动 Chrome："
  echo "  google-chrome --remote-debugging-port=$PORT"
  echo "  或 chromium --remote-debugging-port=$PORT"
fi
