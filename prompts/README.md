# 提示词配置

本目录存放 AI 总结与纠错所用的提示词模板，可直接编辑以调整输出风格。

## 文件说明

| 文件 | 用途 |
|------|------|
| `summary_prompt.txt` | 视频总结提示词（DeepSeek 生成总结时使用） |
| `correction_prompt.txt` | 转录纠错提示词（DeepSeek 纠正同音字时使用） |
| `translate_prompt.txt` | 英文翻译提示词（DeepSeek 将英文转录翻成中文时使用） |

## 占位符

- **summary_prompt.txt**：`{{VIDEO_INFO}}`、`{{TRANSCRIPT}}`
- **correction_prompt.txt**：`{{CONTEXT}}`、`{{TRANSCRIPT}}`
- **translate_prompt.txt**：`{{CONTEXT}}`、`{{TRANSCRIPT}}`

程序会自动替换这些占位符，无需修改占位符名称。
