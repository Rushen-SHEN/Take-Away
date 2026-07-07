# Component snippets — Take-Away Deck

Copy-paste markup for the pieces the deck is built from. All of these are styled
by `deck-design-system.css`. The canonical, fully worked example lives in
`../../../output/2026-07-07_karpathy-sequoia-ascent-takeaway/` — when in doubt,
open that file and mirror its structure.

The transcript is a 3-column grid per row: **English original · Chinese
translation · term glossary**. Rows carry a semantic class that tints them.

---

## Page skeleton

```html
<body>
  <header class="hero">…title, subtitle, source links…</header>

  <div class="thesis-grid">…takeaway cards…</div>

  <nav class="section-nav" id="nav">…anchor links…</nav>

  <div class="col-headers">
    <div class="col-header en">English · Original</div>
    <div class="col-header zh">中文 · 对照翻译</div>
    <div class="col-header terms">AI 术语 · 发音 & 释义</div>
  </div>

  <main class="transcript">
    <div class="section-block" id="s-intro">
      <div class="section-title"><span class="section-num">00</span> Section · 章节</div>
      …rows…
    </div>
  </main>

  <footer>…source credit…</footer>
  <script>…scroll-spy + term-click highlight…</script>
</body>
```

## Row types (the semantic vocabulary)

```html
<!-- plain dialogue row -->
<div class="row">
  <div class="cell en"><span class="speaker">Speaker</span>English text…</div>
  <div class="cell zh"><span class="speaker">Speaker</span>中文…</div>
  <div class="cell terms">
    <div class="term"><span class="term-word">word</span><span class="term-ipa">/ipa/</span>
      <div class="term-def">释义</div></div>
  </div>
</div>

<!-- interviewer question (recessed, italic, neutral left rail) -->
<div class="row question">
  <div class="cell en"><span class="q-tag">Question</span><span class="speaker">Interviewer</span>…</div>
  <div class="cell zh"><span class="q-tag">提问</span><span class="speaker">主持</span>…</div>
  <div class="cell terms"></div>
</div>

<!-- core insight (gold) / paradigm shift (terracotta) / quote / contrast -->
<div class="row insight">   … <span class="insight-tag core">Core Insight</span> … </div>
<div class="row paradigm">  … <span class="insight-tag paradigm">Paradigm Shift</span> … </div>
<div class="row quote">     … <span class="insight-tag quote">Memorable Quote</span> … </div>
<div class="row contrast">  … <span class="insight-tag core">Counter-intuitive</span> … </div>
```

Inline emphasis inside cells: `<span class="hl-insight">…</span>` (gold highlighter),
`<span class="hl-paradigm">…</span>`, `<span class="hl-danger">…</span>`.

## Reader's curated highlights ("Take-Away")

Layer the reader's own picks over the transcript. Add `takeaway` to the row's
class list and a badge at the start of the English cell. Pair a question with its
answer by giving both the same number.

```html
<div class="row question takeaway">
  <div class="cell en"><span class="takeaway-badge hook">★ Rushen's Take-Away #1</span>
    <span class="q-tag">Question</span><span class="speaker">Interviewer</span>…</div>
  …
</div>
<div class="row insight takeaway">
  <div class="cell en"><span class="takeaway-badge">★ Rushen's Take-Away #1</span>
    <span class="insight-tag core">Core Insight</span><span class="speaker">Speaker</span>…</div>
  …
</div>
```

`.takeaway-badge.hook` = outline variant (for questions); plain = filled (answers).

## Top thesis cards (5 across)

```html
<div class="thesis-grid">
  <div class="thesis-card purple">   <!-- colors: purple green gold blue rust -->
    <div class="label">⚡ Rushen's Take-Away #1</div>
    <p><strong>Lead phrase</strong> — 支撑句子。</p>
  </div>
  …
</div>
```

## Optional visuals

```html
<!-- evolution strip -->
<div class="sw-evolution">
  <div class="sw-step"><div class="ver">1.0</div><div class="desc">…</div></div>
  <div class="sw-arrow">→</div>
  <div class="sw-step active"><div class="ver">3.0</div><div class="desc">…</div></div>
</div>

<!-- jagged bar chart (heights + gradients are inline; keep data-viz colors vivid) -->
<div class="jagged-viz"><div class="jagged-bar-wrap">
  <div class="jagged-bar" style="height:95%;background:linear-gradient(to top,#6ee7b7,#34d399);">
    <span class="bar-val" style="color:var(--accent);">95%</span>
    <span class="bar-label">Code<br>编程</span>
  </div>
</div></div>

<!-- monospace formula / callout -->
<div class="formula">capability ≈ verifiability × training attention × data coverage</div>
```

## In-browser edit toggle (drop before `</body>`)

Lets the user fix wording live in the browser (⌘S saves the page). The button is
`contenteditable="false"` so it stays clickable while the body is editable; keep
it OUTSIDE any element you screenshot (e.g. the cover `#cover`).

```html
<button id="rs-edit-toggle" type="button" contenteditable="false">✏️ 编辑</button>
<style>
  #rs-edit-toggle{ position:fixed; right:18px; bottom:18px; z-index:99999;
    font:600 14px 'Noto Sans SC',system-ui; padding:10px 16px; border-radius:999px;
    cursor:pointer; color:#fff; background:#b85c3e; border:none;
    box-shadow:0 6px 20px rgba(184,92,62,.35); }
  #rs-edit-toggle.editing{ background:#2f7d32; }
</style>
<script>
(function(){var b=document.getElementById('rs-edit-toggle');b.onclick=function(){
  var on=document.body.getAttribute('contenteditable')==='true';
  document.body.setAttribute('contenteditable',on?'false':'true');
  b.classList.toggle('editing',!on); b.textContent=on?'✏️ 编辑':'✅ 完成 · ⌘S 存网页';};})();
</script>
```
