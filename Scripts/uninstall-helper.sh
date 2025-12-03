#!/bin/bash

set -e

echo "======================================"
echo "  ClashMac Helper 卸载脚本"
echo "======================================"
echo ""

if [ "$EUID" -ne 0 ]; then
  echo "❌ 请使用 sudo 运行此脚本："
  echo "   sudo ./uninstall-helper.sh"
  exit 1
fi

PLIST_PATH="/Library/LaunchDaemons/com.clashmac.helper.plist"
HELPER_PATH="/Library/PrivilegedHelperTools/com.clashmac.helper"
SOCKET_PATH="/var/run/com.clashmac.helper.sock"
LOG_PATH="/var/log/com.clashmac.helper.log"

# 停止服务
launchctl unload "$PLIST_PATH" 2>/dev/null || true

# 删除文件
rm -f "$PLIST_PATH"
rm -f "$HELPER_PATH"
rm -f "$SOCKET_PATH"
rm -f "$LOG_PATH"

# 清理内核相关的残留文件
KERNEL_SOCKET="/tmp/clashmac.sock"
if [ -S "$KERNEL_SOCKET" ]; then
  rm -f "$KERNEL_SOCKET"
fi

# 检查残留内核进程
pkill -f "mihomo" || true

echo "✅ Helper 已卸载"
