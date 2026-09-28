<div align="center">
  <img src="assets/ran-banner.svg" width="100%" alt="RAN · Research Action Note" />

  <br />

  English · [中文](README.md)

  <p><strong>A research meeting ends. The work that matters is only beginning.</strong></p>
  <p>RAN turns transcripts, slides, papers, and discussion into research notes that are traceable, reviewable, and ready to move forward.</p>

  <a href="https://yanxingji-ran.onrender.com/app/demo.html"><img src="https://img.shields.io/badge/Try_it-Live_Demo-2563EB?style=for-the-badge" alt="Try the live demo" /></a>
  <a href="https://github.com/zhongshiyu0129/lab-meeting-copilot"><img src="https://img.shields.io/badge/GitHub-Source-111827?style=for-the-badge&logo=github" alt="View source on GitHub" /></a>

  <br /><br />

  <img src="https://img.shields.io/badge/Python-3.9%2B-3776AB?style=flat-square&logo=python&logoColor=white" alt="Python 3.9+" />
  <img src="https://img.shields.io/badge/FastAPI-Backend-009688?style=flat-square&logo=fastapi&logoColor=white" alt="FastAPI" />
  <img src="https://img.shields.io/badge/LLM-OpenAI--compatible-5B5BD6?style=flat-square" alt="OpenAI-compatible LLM" />
  <img src="https://img.shields.io/badge/License-MIT-1f2937?style=flat-square" alt="MIT License" />
</div>

---

## Try it before reading the docs

Open the **[public RAN demo](https://yanxingji-ran.onrender.com/app/demo.html)** and select “加载官方试用案例” to run the bundled Pig Cycle research meeting from end to end:

1. Load a transcript, research slide deck, and reference paper.
2. Confirm speakers and material ownership.
3. Generate discussion points, advisor feedback, risks, and actions.
4. Select a citation to return to the original PPT/PDF page and inspect the yellow evidence highlight.
5. Save the result to the library for editing or export.

The public demo uses a server-side model allowance, so visitors do not need an API key. Render's free instance may take 30–60 seconds to wake after a period of inactivity.

> This is a shared demo environment. Prefer the bundled case, and do not upload confidential, unpublished, or personal data. Run RAN locally for private research material.

## Why RAN

The valuable part of a research meeting rarely fits into a closing summary. It lives across a figure on a slide, a paragraph in a paper, an advisor's question about one variable, and the experiment that must be repeated next week.

Conventional minutes compress that trail into prose that sounds plausible. RAN takes a different approach: important findings should lead back to their original evidence, and every discussion should become a concrete starting point for the next action.

```text
transcript + PPT + PDF / DOCX
              ↓
 parse, clean, and bind presenters
              ↓
multimodal understanding of text and figures
              ↓
discussion · feedback · risks · actions
              ↓
 page citations · highlights · research library
```

The model interprets; the application constrains. RAN owns the source documents, output schema, evidence pages, file previews, and action state. The result is not a disposable AI response, but a research record that can be checked, edited, and carried forward.

## What works today

| Capability | What it does |
| :-- | :-- |
| **Multimodal intake** | Imports transcripts, DOCX, PPT/PPTX, and PDF while keeping a human confirmation step for presenters and material ownership. |
| **Scientific figure reading** | Sends page images together with extracted text and prioritizes pages likely to contain charts, experiments, and model details. |
| **Structured notes** | Produces presenter/topic-oriented discussion points, advisor feedback, risks, and next actions. |
| **Page-level provenance** | Uses structured page numbers and marks matching regions on original PPT/PDF pages with a yellow highlight or border. |
| **Faithful previews** | Renders PPT with LibreOffice and PDF page by page, with thumbnails, large-page views, and original-file access. |
| **Action loop** | Stores owner, deadline, priority, status, and response in a searchable research library. |
| **One-click official case** | Includes a full Pig Cycle meeting, so the entire workflow can be tested without preparing files. |

## Run locally

### macOS one-click launch

1. Copy the template: `cp ran-backend/.env.example ran-backend/.env`.
2. Add your model-service credentials to `ran-backend/.env`.
3. Double-click [启动研行记.command](启动研行记.command) in Finder.
4. The first run creates a Python environment, installs dependencies, and opens the demo.

Keep the launch terminal open; closing it stops the local service.

### Manual launch

```bash
cd ran-backend
python3 -m venv .venv
./.venv/bin/python -m pip install -r requirements.txt
./.venv/bin/python -m uvicorn main:app --host 127.0.0.1 --port 8003
```

Open `http://127.0.0.1:8003/app/demo.html`. FastAPI serves both the UI and API, so no separate static server is required.

## Model configuration

RAN supports OpenAI-compatible APIs. The default example uses `deepseek/deepseek-v4.1-flash` through OpenRouter:

```dotenv
OPENAI_API_KEY=your_openrouter_key
OPENAI_BASE_URL=https://openrouter.ai/api/v1
OPENAI_MODEL=deepseek/deepseek-v4.1-flash
VISION_INPUT_ENABLED=true
VISION_MAX_IMAGES=18
```

When using another provider, update the base URL, model name, and key together. See [模型推荐.md](ran-backend/模型推荐.md) for model notes.

## Deploy a public demo

The root [Dockerfile](Dockerfile) can be deployed directly to Render or another container platform. Configure these variables in the platform's server-side environment/secret panel:

| Variable | Example | Purpose |
| :-- | :-- | :-- |
| `OPENAI_API_KEY` | Set as a platform secret | Required; never commit it. |
| `OPENAI_BASE_URL` | `https://openrouter.ai/api/v1` | OpenAI-compatible endpoint. |
| `OPENAI_MODEL` | `deepseek/deepseek-v4.1-flash` | Current multimodal model. |
| `VISION_INPUT_ENABLED` | `true` | Sends rendered pages to the model. |
| `VISION_MAX_IMAGES` | `18` | Maximum visual pages per generation. |

The deployed `/health` endpoint reports whether a model is configured without returning credentials.

Real keys belong only in local `ran-backend/.env` or the hosting provider's secret manager. `.gitignore` and `.dockerignore` exclude `.env`, and model requests run on the backend without giving the key to the browser. Review staged changes before committing to avoid accidentally embedding credentials in code or documentation. Set provider-side budget caps and alerts: when the demo allowance runs out, the page remains available but generation pauses.

The current demo is deployed from a public repository on Render. After pushing to GitHub, select **Manual Deploy → Deploy latest commit** in the dashboard. Configure a GitHub integration separately if automatic deployment is desired.

## Repository map

```text
lab-meeting-copilot/
├── ran-page 3/             # Product landing page and interactive demo
├── ran-backend/
│   ├── main.py             # FastAPI, parsing, model orchestration, provenance, and library APIs
│   ├── trial_assets/       # Bundled official demo material
│   ├── requirements.txt    # Python dependencies
│   └── .env.example        # Configuration template with no real secrets
├── 测试材料_三人组会/        # Local manual-upload test pack
├── Dockerfile              # Public container deployment
└── 启动研行记.command       # One-click macOS launcher
```

## Privacy and boundaries

- API keys are read only by the backend. `.env`, generated databases, and uploaded files are excluded from Git and Docker build contexts.
- The current public build is a product demo, not an account-isolated multi-user service. Do not process sensitive material on the public site.
- The free deployment has no persistent disk. Restarts or redeployments may reset the library; export important notes promptly.
- AI output assists research organization; researchers remain responsible for validating experiments, data, citations, and conclusions.
- Bundled material is for product demonstration only. Ensure you have permission before processing or sharing your own files.

## Next

- [x] Multi-source parsing and structured notes
- [x] Faithful PPT/PDF previews with page-level yellow provenance
- [x] Multimodal figure understanding and visual-page prioritization
- [x] Action-item loop and local research library
- [x] One-click official case and public demo
- [ ] Team accounts, permissions, and data isolation
- [ ] Editable evidence boxes and manual correction
- [ ] Cross-project research memory and collaboration

## License

Released under the [MIT License](LICENSE).

## Contact

Built by [@zhongshiyu0129](https://github.com/zhongshiyu0129). Issues and pull requests are welcome.
