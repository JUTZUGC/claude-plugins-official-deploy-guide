# Claude Plugins 插件市场安装指南

> 第三方部署指南 · 非 Claude Plugins 官方仓库。官方项目：[anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official)
> 内容来自官方文档（2026-10-27）。项目迭代快，请以[官方文档](https://github.com/anthropics/claude-plugins-official#installation)为准。

[![⚡ 插件市场安装](https://img.shields.io/badge/%E2%9A%A1_%E6%8F%92%E4%BB%B6%E5%B8%82%E5%9C%BA%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#插件市场安装推荐用百度搭子)

## 插件市场安装（推荐：用百度搭子）

> [!TIP]
> 不想到处翻 Claude 插件，让百度搭子把这个 315 条目的市场加进来，按名字挑着装。

⚠️ 这是插件目录，不是插件本身。Anthropic 不审核插件里的 MCP server 与代码，装之前先看对应插件的仓库和权限。部分插件会读仓库、邮箱、日历等敏感数据。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/claude-plugins-official-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子安装 Claude Code CLI，把插件市场加进来，再按名字安装需要的插件，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## Claude Plugins 是什么？

Claude Plugins 是开源的44.8k stars，Apache-2.0，315 个插件的索引仓库，一条命令加市场再按名字装（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/anthropics/claude-plugins-official?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

Claude Code 的插件市场索引：仓库只维护 `marketplace.json` 和条目信息，实际插件分散在各作者仓库，安装时由 Claude Code 拉取。

- 44.8k stars：插件生态的集中入口
- 315 个条目：开发、数据、营销、合规全覆盖
- 一条命令加市场，之后按名字装
- slug 稳定：插件改名会做迁移，不会突然失效
- Apache-2.0：索引本身可读可改
- 持续更新：新插件跟进较快

（来源：[官方仓库](https://github.com/anthropics/claude-plugins-official)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 44.8k stars | 生态入口，覆盖面广 |
| 315 个条目 | 几乎涵盖常见开发与办公场景 |
| slug 稳定 | 改名有迁移机制 |
| 安装简单 | 一条命令装一个插件 |
| 持续维护 | 新插件跟进快 |

| 需要注意 | 说明 |
|---|---|
| 不是实际插件 | 只是索引，装的时候才拉代码 |
| 不审核第三方 | 权限与质量要自己判断 |
| 需要 Claude Code | 没有客户端用不了 |
| 插件差异大 | 成熟度参差 |
| 敏感权限多 | 邮件、日历、仓库类插件要谨慎 |

> 以上基于官方文档与社区反馈整理（2026-10-27），以官方最新文档为准。

## 快速部署（官方方式）

```bash
npm install -g @anthropic-ai/claude-code
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin install agent-sdk-dev@claude-plugins-official
claude plugin list | grep -q agent-sdk-dev && echo '插件已安装' || echo '未生效，运行 /plugin 手动确认'
```

部署步骤来源：[https://github.com/anthropics/claude-plugins-official#installation](https://github.com/anthropics/claude-plugins-official#installation)

## 验证状态

| 场景 | 状态 |
|---|---|
| 仓库元数据已核对：44.8k stars、Apache-2.0、2025-11 建仓 | 已核对 2026-10-27 |
| marketplace.json 实测解析成功，共 315 个插件条目 | 已验证 2026-10-27 |
| README 确认安装命令格式为 <name>@claude-plugins-official | 已核对 2026-10-27 |
| 未实测 plugin install（本机未登录 Claude Code） | 说明 2026-10-27 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

部分插件内含 MCP server 配置；本仓库只提供市场接入说明，不注册 MCP。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-27）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\claude-plugins-official-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

```text
/plugin                                  # 浏览市场
/plugin install airtable@claude-plugins-official
```

### 常用插件示例

| 插件 | 用途 |
|---|---|
| `agent-sdk-dev` | 用 Agent SDK 开发 Agent |
| `airtable` | 读写 Airtable 表 |
| `aikido` | 安全扫描 |
| `adobe-for-creativity` | Adobe 创意工具 |

### 命令行等价写法

```bash
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin install <插件名>@claude-plugins-official
```

### 更新市场

```bash
claude plugin marketplace update claude-plugins-official
```

> ⚠️ 市场里有第三方插件，装之前看清楚它会访问哪些数据；不确定的先用小号或测试项目。

## 常见坑

- `plugin-not-found`：插件名或市场名拼错，先用 `/plugin` 浏览
- 市场加不上：网络问题，重试一次
- 装完 command 不存在：重启会话
- 第三方插件要求账号：提前准备对应服务的授权
- 不要装高权限插件到公司仓库：先看 scope
- 升级后插件失效：`plugin marketplace update` 再重装

## 免责声明

本仓库为第三方指南，与 Claude Plugins 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-27），项目迭代快，请以[官方文档](https://github.com/anthropics/claude-plugins-official#installation)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
