# Pub Quiz Cards

1,000 pub quiz questions with answers, shown as flip cards in a single-page web app.

## Features

- 10 categories of 100 questions: General knowledge, Geography, History, Science & nature, Film & TV, Music, Sport, Food & drink, Books, language & art, Germany & Europe
- Every question has an answer, a short summary explaining it, and a level (Easy, Medium or Hard)
- Tap a card to flip it and reveal the answer
- Filter by category and level, and search questions, answers and summaries
- Shuffle the cards, or show all answers at once
- **Host mode:** one big card at a time for running a quiz on a TV or laptop (arrow keys to move, Space to reveal, Esc to close)
- Works on phone and desktop, with light and dark themes

## Run it

No build step and no dependencies. Open `index.html` in a browser.

To publish it with GitHub Pages: **Settings → Pages → Deploy from a branch → `main` / root**.

## Files

| File | What it is |
| --- | --- |
| `index.html` | The app, with all questions embedded |
| `data/questions.json` | The questions as JSON (`c` category, `q` question, `a` answer, `s` summary, `l` level) |
| `data/template.html` | The app without data, with a `__DATA__` placeholder |

To rebuild `index.html` after editing the questions:

```bash
python3 -c "d=open('data/questions.json').read().replace('</','<\\\\/'); open('index.html','w').write(open('data/template.html').read().replace('__DATA__',d))"
```

Time-sensitive facts (World Cup results, euro members, UNESCO site counts, scoring records) were checked in November 2026.
