# Reading Stopwatch PWA

A simple Progressive Web App for tracking reading sessions and individual page times.

## Features

- Stopwatch timer with start/pause/resume/end/reset
- Track time spent on each page
- Session history with localStorage persistence
- Voice control for hands-free page tracking (say "page" to log a new page)
- Offline support via service worker
- Screen wake lock to prevent screen from sleeping during sessions

## Running Locally

Since this is a PWA with a service worker, you need to serve it over HTTP (not `file://`).

### Option 1: Python (built-in)

```bash
python3 -m http.server 8001
```

Then open http://localhost:8001

### Option 2: Node.js

```bash
npx http-server -p 8001
```

### Option 3: VS Code Live Server

Use the Live Server extension to serve the app.

## Tech Stack

- Pure HTML/CSS/JavaScript (no build process)
- PWA with service worker for offline support
- localStorage for data persistence
- Web Speech API for voice control
- Wake Lock API to keep screen on
