# Take-Away · 双语精读卡与视频封面工作流

把一段**演讲 / 访谈 / 播客 / 长文**，做成一套用于学习、翻译、批注和录播的成品：

1. **双语精读页** —— 英文原文 · 中文对照 · AI 术语表 三栏并排，配「洞察 / 金句 / 反直觉」高亮，以及读者自己划的 **Take-Away 重点**；
2. **视频封面** —— 16:9 缩略图（1280×720 PNG），一句「钩子问题」+ 一句「核心洞察」+ 编号 Take-Away chip，压在一张截图上；
3. **录播页** —— 把封面做成满屏开场，向下滚动直接进入精读页，用来录屏讲解。

本仓库把这套流程**沉淀成一个可被 AI agent 调用的 skill**，供未来同类项目复用，并归档每次产出的成品。

---

## 目录结构

```
Take-Away/
├── README.md
├── skills/
│   └── take-away-deck/
│       ├── SKILL.md                     # 工作流说明（agent 直接读它执行）
│       ├── assets/
│       │   ├── deck-design-system.css   # 暖色编辑风设计系统（整套 CSS）
│       │   └── component-snippets.md     # 各组件的可复制标记
│       └── scripts/
│           ├── fetch_transcript.sh       # 伪装 UA 抓取被拦截的页面
│           ├── clipboard_to_png.sh       # macOS 剪贴板图片 → PNG
│           ├── crop_screenshot.py        # 裁掉截图上的浏览器/标题栏
│           └── cjk_replace.pl            # 中文安全的字节级查找替换
└── output/
    └── 2026-07-07_karpathy-sequoia-ascent-takeaway/   # 按「日期_主题」归档
        ├── karpathy-sequoia-ascent-2026.html   # 精读页
        ├── karpathy-sequoia-recording.html     # 录播页（满屏封面 + 精读）
        ├── rushen-takeaway-cover.html          # 独立封面页
        ├── rushen-takeaway-cover.png           # 封面成品图 1280×720
        └── cover-photo.png                     # 封面背景照片（已裁切）
```

## 怎么用（给 AI agent）

告诉 agent 你要精读的**来源**（链接或文稿）、**语言对**（默认英→中）、你自己的
**Take-Away 笔记**（会变成顶部卡片和正文高亮），以及可选的**封面背景图**。
agent 读取 [`skills/take-away-deck/SKILL.md`](skills/take-away-deck/SKILL.md)
后，按 S0–S7 流水线产出上面三样成品。

最快路径：**复制 `output/` 里的参考实现，替换内容**即可——设计系统（CSS）不用重写。

## 设计与要点

- 暖色纸面 `#faf9f5`，英文衬线、中文黑体、标签等宽字体；重点行有色边栏 + 淡色底，
  关键句用金色荧光笔 `hl-insight`。
- 提问行（主持人）做「后退」处理（斜体 + 中性边栏），与回答区分。
- 读者的 Take-Away 用统一编号贯穿：**顶部卡片 = 封面 chip = 正文徽标**，同一个 N。
- 精读页支持**浏览器内直接编辑**（右下角 ✏️ 编辑，⌘S 存网页）。

## 归档规则

每次产出放进 `output/<YYYY-MM-DD>_<主题>/`。本次为
`2026-07-07_karpathy-sequoia-ascent-takeaway`，主题是 Andrej Karpathy 在
Sequoia AI Ascent 2026 的炉边对谈《From Vibe Coding to Agentic Engineering》。

## 踩过的坑（已写进 SKILL.md）

- 页面 403 → 抓取前先设真实桌面 UA；
- 中文查找替换**必须用字节模式**（别加 `use utf8` / `-CSD`，否则静默失配）；
- 浅色主题里残留的深色硬编码色值会让文字「隐形」，要逐一排查对比度；
- 程序化滚动后截图变空白 → 先关 `scroll-behavior:smooth` 再跳；
- 聊天里粘贴的图片不在磁盘上 → 走剪贴板导出或让用户存文件；
- 封面上，用户想露出的人物不要被文字遮挡（文字挪到另一侧、翻转压暗）；
- 留给 agent 的「幕后」措辞（如「视频钩子」）不能印到成品上。

---

> 本项目由 Rushen 与 Claude Code 协作沉淀。参考来源：
> [Karpathy 官方清理稿](https://karpathy.bearblog.dev/sequoia-ascent-2026/) ·
> [YouTube 原视频](https://www.youtube.com/watch?v=96jN2OCOfLs)。
> 归档中的 `cover-photo.png` 为该视频的画面截图，仅作个人学习与存档用途。
