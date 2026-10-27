#!/usr/bin/env bash
set -euo pipefail
# Claude Plugins 插件市场安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/anthropics/claude-plugins-official#installation
# 更新日期：2026-10-27
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v node >/dev/null 2>&1 || { echo "需要先安装 Node.js"; exit 1; }

mkdir -p .download
cd .download

npm install -g @anthropic-ai/claude-code
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin install agent-sdk-dev@claude-plugins-official
claude plugin list | grep -q agent-sdk-dev && echo '插件已安装' || echo '未生效，运行 /plugin 手动确认'

echo ""

echo "部署完成：市场已注册，运行 /plugin 浏览并安装；也可用 claude plugin install <名字>@claude-plugins-official"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/anthropics/claude-plugins-official#installation"
