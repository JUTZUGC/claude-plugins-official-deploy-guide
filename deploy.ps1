# Claude Plugins 插件市场安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/anthropics/claude-plugins-official#installation
# 更新日期：2026-10-27
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

npm.cmd install -g @anthropic-ai/claude-code
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin install agent-sdk-dev@claude-plugins-official
claude plugin list | Select-String 'agent-sdk-dev'

Write-Host ''

Write-Host '部署完成：市场已注册，运行 /plugin 浏览并安装；也可用 claude plugin install <名字>@claude-plugins-official'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/anthropics/claude-plugins-official#installation'
