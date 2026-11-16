"""Build index.html and sw.js from src/app.html and data/questions.json.

Run after editing questions or the app:  python3 build.py
"""
import hashlib, json, pathlib

root = pathlib.Path(__file__).parent
data = json.loads((root / "data/questions.json").read_text(encoding="utf-8"))
payload = json.dumps(data, ensure_ascii=False, separators=(",", ":")).replace("</", "<\\/")
html = (root / "src/app.html").read_text(encoding="utf-8").replace("__DATA__", payload)
(root / "index.html").write_text(html, encoding="utf-8")

version = hashlib.sha1(html.encode()).hexdigest()[:10]
sw = (root / "src/sw.js").read_text(encoding="utf-8").replace("__VERSION__", version)
(root / "sw.js").write_text(sw, encoding="utf-8")
print(f"Built index.html ({len(html)//1024} KB) with {len(data['items'])} questions, cache version {version}")
