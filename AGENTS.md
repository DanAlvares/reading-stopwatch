# Reading Stopwatch PWA - Development Guidelines

## Project Overview

This is a Progressive Web App (PWA) for tracking reading sessions and individual page times. It's a single-page application with all HTML, CSS, and JavaScript contained in `index.html`.

## File Structure

```
stopwatch-app/
├── index.html        # Main application (HTML, CSS, JS embedded)
├── sw.js            # Service worker for offline caching
├── manifest.json     # PWA manifest
├── icon-192.png     # App icon (192x192)
├── icon-512.png     # App icon (512x512)
├── CHANGELOG.md     # Version history
├── FEATURES.md      # Feature descriptions
├── FEATURES.feature # Gherkin test scenarios
├── README.md        # User documentation
└── AGENTS.md       # This file
```

## Required Updates for Every Change

When making any change to this project, you MUST update ALL of the following:

### 1. Service Worker (`sw.js`)
- Update `CACHE_NAME` version when new features are added or code changes
- Version format: `stopwatch-vX.Y.Z` (e.g., `stopwatch-v0.3.1`)
- Increment appropriately:
  - **Patch** (Z): Bug fixes, small improvements
  - **Minor** (Y): New features, backwards-compatible changes
  - **Major** (X): Breaking changes

### 2. Changelog (`CHANGELOG.md`)
- Add new section at top with version number and date
- Use format: `## [X.Y.Z] - YYYY-MM-DD`
- Document all changes under appropriate headers:
  - `### Added` - New features
  - `### Changed` - Modifications to existing features
  - `### Fixed` - Bug fixes
  - `### Removed` - Deleted features
- Remove any version sections that are now obsolete (keep last 5-10 versions)

### 3. Feature Files
When adding new features:
- **FEATURES.md**: Add feature description to the list
- **FEATURES.feature**: Add Gherkin scenarios using Given/When/Then format
- Use appropriate tags: `@timer`, `@pages`, `@voice`, `@history`, `@grouping`, `@boox-filter`, `@clipboard`, `@save-modal`, `@visual`, `@pwa`, `@edge-cases`

## Code Style Guidelines

### HTML/CSS
- Use CSS custom properties for colors (`var(--text)`, `var(--surface)`, etc.)
- Keep styles organized in the `<style>` section at the top
- Use semantic HTML elements
- Mobile-first responsive design

### JavaScript
- All JavaScript goes in the `<script>` tag at the bottom of `index.html`
- Use `const` and `let` instead of `var`
- Use template literals for string interpolation
- Always check JavaScript syntax: `sed -n '/<script>/,/<\/script>/p' index.html | sed '1d;$d' > /tmp/script.js && node --check /tmp/script.js`

### Naming Conventions
- Functions: camelCase (e.g., `renderSessions`, `saveSession`)
- CSS classes: kebab-case (e.g., `session-group`, `history-panel`)
- Session IDs: use `Date.now().toString()`
- LocalStorage keys: descriptive, lowercase with hyphens (e.g., `stopwatchSessions`, `currentSessionState`)

## Common Patterns

### Adding a New Feature

1. Read existing code to understand the pattern
2. Make changes to `index.html`
3. Update `sw.js` cache version
4. Update `CHANGELOG.md`
5. Add scenarios to `FEATURES.md` and `FEATURES.feature`
6. Test the changes
7. Commit and push

### Session Data Structure

```javascript
// Session object
{
  id: "1234567890",
  name: "My Book",
  date: "2024-01-15T10:30:00.000Z",
  totalTime: 3600000,  // milliseconds
  laps: [
    { pageTime: 300000, totalSessionTime: 300000, number: 1 },
    { pageTime: 450000, totalSessionTime: 750000, number: 2 }
  ]
}
```

### Adding UI Components

1. Add HTML in appropriate location
2. Add CSS styles (grouped logically)
3. Add JavaScript handlers
4. Test on mobile and desktop

## Testing Checklist

Before committing any change, verify:

- [ ] JavaScript syntax is valid (`node --check`)
- [ ] New feature works as expected
- [ ] Existing features still work
- [ ] Service worker updates properly
- [ ] Version numbers are consistent
- [ ] Changelog is accurate

## Voice Control Implementation

The app uses the Web Speech API for voice recognition:
- Uses `webkitSpeechRecognition` or `SpeechRecognition`
- Listens for any transcript containing "page" (case-insensitive)
- 500ms debounce prevents rapid-fire triggers
- Microphone indicator shows when listening
- Gracefully disabled if API unavailable

## PWA Requirements

- Service worker must cache: index.html, manifest.json, icon files
- Manifest must include: name, short_name, start_url, display, icons
- Icons must be 192x192 and 512x512 PNG

## localStorage Keys

- `stopwatchSessions`: Array of saved session objects
- `currentSessionState`: JSON of in-progress session for persistence

## Git Workflow

1. Make changes on a feature branch if implementing significant features
2. Commit with descriptive message: "Add [feature] / Fix [bug] / Update [component]"
3. Push and create PR for review
4. Merge to main after approval

## Version Bumping

```
Patch: 0.3.0 → 0.3.1 (bug fixes)
Minor: 0.3.0 → 0.4.0 (new features)
Major: 0.3.0 → 1.0.0 (breaking changes)
```

## Important Notes

- NEVER commit secrets, API keys, or credentials
- Always test on Safari (has different Speech Recognition support)
- The app is designed for mobile-first experience
- Pull-to-refresh uses touch events on `.app` element
- Screen wake lock prevents screen sleep during active sessions
