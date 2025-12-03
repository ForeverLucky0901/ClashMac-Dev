#!/bin/bash

set -e

echo "======================================"
echo "  ClashMac Helper 安装脚本"
echo "======================================"
echo ""

# 检查是否以 root 权限运行
if [ "$EUID" -ne 0 ]; then
  echo "❌ 请使用 sudo 运行此脚本："
  echo "   sudo ./install-helper.sh"
  exit 1
fi

# 定义路径
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 智能检测 Helper 文件路径
# 1. 优先检查当前目录 (App Bundle 环境)
if [ -f "$SCRIPT_DIR/com.clashmac.helper" ]; then
  HELPER_BINARY="$SCRIPT_DIR/com.clashmac.helper"
# 2. 其次检查开发环境路径
elif [ -f "$SCRIPT_DIR/../ClashMacHelper/com.clashmac.helper" ]; then
  HELPER_BINARY="$SCRIPT_DIR/../ClashMacHelper/com.clashmac.helper"
else
  # 默认回退，虽然可能不存在
  HELPER_BINARY="$SCRIPT_DIR/com.clashmac.helper"
fi

# 智能检测 plist 文件路径
if [ -f "$SCRIPT_DIR/com.clashmac.helper.plist" ]; then
  PLIST_SOURCE="$SCRIPT_DIR/com.clashmac.helper.plist"
else
  PLIST_SOURCE="$SCRIPT_DIR/../scripts/com.clashmac.helper.plist"
fi

INSTALL_PATH="/Library/PrivilegedHelperTools/com.clashmac.helper"
PLIST_INSTALL="/Library/LaunchDaemons/com.clashmac.helper.plist"

echo "📍 脚本目录：$SCRIPT_DIR"
echo "📦 Helper 源文件：$HELPER_BINARY"
echo ""

# 检查 Helper 文件是否存在
if [ ! -f "$HELPER_BINARY" ]; then
  echo "❌ 错误：找不到 Helper 文件：$HELPER_BINARY"
  exit 1
fi

# 检查 plist 文件是否存在
if [ ! -f "$PLIST_SOURCE" ]; then
  echo "❌ 错误：找不到 launchd 配置文件：$PLIST_SOURCE"
  exit 1
fi

# 先卸载旧版本（如果存在）
if [ -f "$PLIST_INSTALL" ]; then
  launchctl unload "$PLIST_INSTALL" 2>/dev/null || true
  rm -f "$PLIST_INSTALL"
  rm -f "$INSTALL_PATH"
  rm -f /var/run/com.clashmac.helper.sock
fi

# 复制 Helper 到系统目录
cp "$HELPER_BINARY" "$INSTALL_PATH"
chmod 755 "$INSTALL_PATH"
chown root:wheel "$INSTALL_PATH"

# 安装 launchd 配置
cp "$PLIST_SOURCE" "$PLIST_INSTALL"
chmod 644 "$PLIST_INSTALL"
chown root:wheel "$PLIST_INSTALL"

# 启动 Helper 服务
launchctl load -w "$PLIST_INSTALL"
sleep 1

# 验证服务状态
if launchctl list | grep -q com.clashmac.helper; then
  echo "✅ Helper 安装成功且正在运行"
else
  echo "⚠️  Helper 安装完成但未运行，请检查日志"
fi
