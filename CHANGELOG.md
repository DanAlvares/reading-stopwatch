# Changelog

All notable changes to the Reading Stopwatch PWA are documented here.

The cache version is incremented to force service worker updates to all users.

## [0.2.5] - 2026-03-21

### Fixed
- Page numbering now displays with highest number at top in session history detail
- Fixed "New Page" button being disabled after resuming a restored session

---

## [0.2.4] - 2026-03-21

### Added
- Voice control for hands-free page tracking (re-implemented)
- Speech Recognition API listens for "page" keyword while timer is running
- Triggers on any phrase containing "page" (case-insensitive, e.g., "new page", "next page")
- Screen flash feedback when page is detected (via voice OR button)
- Microphone indicator (pulsing green dot) shows when voice recognition is active
- 500ms debounce prevents multiple triggers from single utterance
- Gracefully disabled if browser doesn't support Speech Recognition (Chrome, Edge, Safari 14.1+)

---

## [0.2.3] - 2026-03-20

### Removed
- Voice detection feature (Speech Recognition API)

### Fixed
- Page times now display in correct order (page 1 at top, newest page at bottom)
- Zero-second page entry removed when ending a session

---

## [0.2.2] - 2025-03-11

### Added
- Pull-to-refresh gesture to reload the app
- Drag down from the top of the screen to refresh (requires 100px+ pull with velocity)

---

## [0.2.1] - 2025-03-10

### Added
- Rename sessions from the history detail view
- Click the pencil icon to edit the session name
- Press Enter to save, Escape to cancel

---

## [0.2.0] - 2025-03-10

### Added
- Voice control for hands-free page tracking
- Speech Recognition API listens for "page" keyword while timer is running
- Triggers on any phrase containing "page" (case-insensitive, e.g., "new page", "next page")
- Screen flash feedback when page is detected (via voice OR button)
- Microphone indicator (pulsing green dot) shows when voice recognition is active
- 500ms debounce prevents multiple triggers from single utterance
- Gracefully disabled if browser doesn't support Speech Recognition (Chrome, Edge, Safari 14.1+)

---

## [0.1.1] - 2025-03-09

### Added
- Session state persistence using localStorage
- Auto-restore session when page is reloaded or reopened
- Save session state on page unload (`beforeunload` event)

### Fixed
- Session data now persists across browser/app restarts

---

## [0.1.0] - 2025-03-09

### Added
- Update available button - appears when new service worker version is detected
- Allows users to manually update to the latest version

---

## [0.0.15] - 2025-03-09

### Added
- Screen Wake Lock API - keeps screen on while timer is running
- Auto-releases wake lock when paused, ended, or reset

### Added
- Fastest/slowest lap highlighting (green/red) in active session

---

## [0.0.13] - 2025-03-09

### Fixed
- NaN display in session detail page times - added proper fallback for undefined lap times

---

## [0.0.12] - 2025-03-09

### Fixed
- NaN issue in session averages - added better fallback logic for empty or undefined lap data

---

## [0.0.10] - 2025-03-09

### Fixed
- First page time now correctly preserved when adding a new page (was resetting to 0)

---

## [0.0.9] - 2025-03-09

### Fixed
- Page numbering now uses sequential creation order instead of array index

---

## [0.0.8] - 2025-03-09

### Added
- Track individual page times
- Each page starts timing from zero
- Pages use 1-based numbering (#1, #2, etc.)

---

## [0.0.7] - 2025-03-09

### Fixed
- PWA paths corrected for GitHub Pages subdirectory deployment

---

## [0.0.6] - 2025-03-09

### Changed
- Hidden milliseconds from all time displays (HH:MM:SS format only)

---

## [0.0.5] - 2025-03-09

### Changed
- "New Page" button now shows when timer is running
- Button hidden when paused

---

## [0.0.4] - 2025-03-09

### Changed
- Renamed "Split" button to "New Page"
- Button only visible when timer is paused

---

## [0.0.3] - Initial Release

### Added
- Reading stopwatch PWA app
- Start/pause/resume/stop timer
- Page/split tracking
- Session history with localStorage
- Session save with optional name
- PWA manifest and service worker for offline support
