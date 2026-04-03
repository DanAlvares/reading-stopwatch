@stopwatch
Feature: Reading Stopwatch PWA

  @timer
  Scenario: Start Timer
    Given the app is loaded and timer shows "00:00:00" with "Ready" label
    When the user taps the "Start" button
    Then the timer starts counting
    And the label changes to "Running"
    And the button changes to "Pause"
    And "New Page" button appears
    And "End" button is hidden

  @timer
  Scenario: Pause Timer
    Given the timer is running
    When the user taps the "Pause" button
    Then the timer stops
    And the label changes to "Paused"
    And the button changes to "Resume"
    And "New Page" button is hidden
    And "End" button appears

  @timer
  Scenario: Resume Timer
    Given the timer is paused
    When the user taps the "Resume" button
    Then the timer continues
    And the label changes to "Running"
    And the button changes to "Pause"
    And "New Page" button appears
    And "End" button is hidden

  @timer
  Scenario: End Timer
    Given the timer is running or paused
    When the user taps the "End" button
    Then the timer stops
    And the label changes to "Ended"
    And "Reset" button appears
    And save modal opens

  @timer
  Scenario: Reset Timer
    Given the timer has ended
    When the user taps the "Reset" button
    Then the timer resets to "00:00:00"
    And the label shows "Ready"
    And all pages are cleared
    And buttons return to initial state

  @pages
  Scenario: Add New Page via Button
    Given the timer is running
    When the user taps the "New Page" button
    Then a new page entry is added with #1
    And the live page shows running time
    And screen flashes white

  @pages
  Scenario: Add Multiple Pages
    Given the timer is running with 2 pages logged
    When the user taps "New Page" again
    Then page #3 appears at top with live timer
    And previous pages show their recorded times

  @pages
  Scenario: Page Numbering Order
    Given multiple pages have been logged
    When viewing the page list
    Then the newest page (#1) appears at the top
    And oldest at the bottom

  @pages
  Scenario: First Page Time Preserved
    Given the timer is running with pages logged
    When a new page is added
    Then the first page's recorded time is preserved

  @pages
  Scenario: Delete Page from Active Session
    Given the timer is running with multiple pages
    When the user taps the delete (×) button on a page
    Then that page is removed from the list

  @voice
  Scenario: Voice Page Detection
    Given the timer is running and microphone permission is granted
    When the user says any word containing "page"
    Then a new page is logged
    And screen flashes

  @voice
  Scenario: Voice Debounce
    Given the timer is running and voice detection is active
    When the user says "page" multiple times within 500ms
    Then only one page is logged

  @voice
  Scenario: Voice Stops on Pause
    Given the timer is running with voice detection active
    When the user pauses the timer
    Then voice detection stops

  @voice
  Scenario: Voice Resumes on Resume
    Given the timer was paused with voice detection stopped
    When the user resumes the timer
    Then voice detection resumes

  @voice
  Scenario: Voice Stops on End
    Given the timer is running with voice detection active
    When the user ends the session
    Then voice detection stops

  @voice
  Scenario: Voice Stops on Reset
    Given a session is in progress with voice detection active
    When the user resets the session
    Then voice detection stops

  @voice
  Scenario: No Voice Error on Unsupported Browser
    Given the browser does not support Speech Recognition API
    When the user starts the timer
    Then no errors occur
    And app functions normally without voice features

  @persistence
  Scenario: Session Restored on Refresh (Running)
    Given a session is running with pages logged
    When the page is refreshed
    Then the session state is restored with Resume/End buttons visible

  @persistence
  Scenario: Session Restored on Refresh (Paused)
    Given a session is paused with pages logged
    When the page is refreshed
    Then the session state is restored with Resume/End buttons visible

  @persistence
  Scenario: Resume Restored Session
    Given a paused session was restored after refresh
    When the user taps "Resume"
    Then the timer continues
    And "New Page" button is enabled
    And voice detection resumes

  @persistence
  Scenario: New Page After Resume
    Given a paused session was restored and resumed
    When the user taps "New Page"
    Then a new page is successfully added

  @persistence
  Scenario: Session State Saved on Unload
    Given a session is in progress
    When the browser tab is closed or navigated away
    Then the session state is saved to localStorage

  @history
  Scenario: View Session History
    Given there are saved sessions
    When the user taps the "History" button
    Then the history panel opens showing all sessions with date, time, page count, and avg time/page

  @history
  Scenario: View Session Detail
    Given the history panel is open
    When the user taps on a session
    Then the detail view opens showing all page times with highlighting for fastest/slowest

  @history
  Scenario: Page Order in Detail View
    Given viewing a session detail with multiple pages
    Then newest page (#1) appears at top
    And oldest at bottom

  @history
  Scenario: Page Numbering in Detail View
    Given viewing a session detail with multiple pages
    Then highest page number appears at top
    And lowest at bottom

  @history
  Scenario: Fastest/Slowest Highlighting
    Given a session detail with 4 or more pages
    Then the fastest page is highlighted green
    And slowest in red

  @history
  Scenario: No Highlighting for Few Pages
    Given a session detail with 2 pages
    Then no fastest/slowest highlighting is shown

  @history
  Scenario: Delete Session from History
    Given the history panel is open
    When the user taps the delete (×) button on a session
    Then that session is removed from history
    And list refreshes

  @history
  Scenario: Delete Page from History Detail
    Given viewing a session detail
    When the user taps the delete (×) button on a page
    Then that page is removed
    And total time is recalculated

  @history
  Scenario: Rename Session
    Given viewing a session detail
    When the user taps the pencil icon and enters a new name
    Then the session name is updated

  @history
  Scenario: Back to Session List
    Given viewing a session detail
    When the user taps the back button
    Then the history list is shown

  @grouping
  Scenario: Sessions Grouped by Name
    Given 3 sessions with the same custom name "Book"
    When viewing history
    Then they appear in a collapsible accordion labeled "Book"

  @grouping
  Scenario: Accordion Shows Stats
    Given a grouped accordion
    Then it shows the session name
    And session count
    And page count
    And avg time/page

  @grouping
  Scenario: Accordion Open by Default
    Given there are grouped sessions
    When viewing history
    Then accordions are expanded by default

  @grouping
  Scenario: Accordion Toggle
    Given a grouped accordion is expanded
    When the user taps the header
    Then the accordion collapses

  @grouping
  Scenario: Single Sessions Not Grouped
    Given sessions with unique names
    When viewing history
    Then they appear as individual items

  @grouping
  Scenario: Default Name Sessions Not Grouped
    Given sessions with default names like "Session 1"
    When viewing history
    Then they appear as individual items

  @grouping
  Scenario: Case-Insensitive Grouping
    Given sessions named "Book" and "book"
    When viewing history
    Then they are grouped together

  @grouping
  Scenario: Groups Sorted Alphabetically
    Given multiple grouped categories
    When viewing history
    Then groups appear in alphabetical order

  @boox-filter
  Scenario: Boox Sessions Hidden by Default
    Given there are sessions with "Boox" in the name
    When viewing history
    Then those sessions are hidden

  @boox-filter
  Scenario: Show Boox Toggle
    Given there are hidden Boox sessions
    When the user enables the "Show Boox" toggle
    Then Boox sessions become visible

  @boox-filter
  Scenario: Hide Boox Sessions
    Given Boox sessions are visible
    When the user disables the "Show Boox" toggle
    Then Boox sessions are hidden

  @boox-filter
  Scenario: Boox Case Insensitive
    Given sessions with "boox", "Boox", "BOOX"
    When viewing history
    Then all are hidden by the Show Boox toggle

  @clipboard
  Scenario: Copy All Sessions
    Given there are saved sessions
    When the user taps the copy button in history header
    Then all session data is copied to clipboard as JSON

  @clipboard
  Scenario: Copy Shows Toast
    Given the user taps the copy button
    When the copy completes
    Then a "Copied!" toast appears at the top

  @clipboard
  Scenario: Toast Fades Away
    Given the "Copied!" toast is shown
    When 2 seconds pass
    Then the toast fades away

  @save-modal
  Scenario: Save Modal Opens on End
    Given the timer is running or paused
    When the user ends the session
    Then the save modal appears

  @save-modal
  Scenario: Save with Custom Name
    Given the save modal is open
    When the user enters a name and taps Save
    Then the session is saved with that name

  @save-modal
  Scenario: Save with Default Name
    Given the save modal is open
    When the user taps Save without entering a name
    Then the session is saved as "Session N" where N is the session count

  @save-modal
  Scenario: Close Modal Without Resetting
    Given the save modal is open
    When the user taps outside the modal
    Then the modal closes without resetting the session

  @save-modal
  Scenario: Discard Session
    Given the save modal is open
    When the user taps Discard
    Then the session is discarded
    And timer resets

  @save-modal
  Scenario: Keyboard Save
    Given the save modal is open with text input focused
    When the user presses Enter
    Then the session is saved

  @visual
  Scenario: Screen Flash on Page via Button
    Given the timer is running
    When the user taps "New Page"
    Then the screen flashes white briefly

  @visual
  Scenario: Screen Flash on Page via Voice
    Given the timer is running with voice detection active
    When voice detects "page"
    Then the screen flashes white briefly

  @visual
  Scenario: Mic Indicator Active
    Given the timer is running with voice detection supported
    When voice detection is listening
    Then a pulsing green dot appears in top right corner

  @visual
  Scenario: Mic Indicator Hidden When Paused
    Given the timer is paused
    When the timer is not running
    Then the mic indicator is hidden

  @pwa
  Scenario: Service Worker Caches App
    Given the app has been visited once
    When the user goes offline
    Then the app still loads and functions

  @pwa
  Scenario: Update Available Button
    Given a new service worker version is available
    When the user visits the app
    Then an "Update" button or prompt appears

  @pwa
  Scenario: Pull to Refresh
    Given on a touch device
    When the user pulls down from the top
    Then the page refreshes

  @pwa
  Scenario: Screen Wake Lock Active
    Given the timer is running
    When the app is in foreground
    Then the screen stays on

  @pwa
  Scenario: Screen Wake Lock Released on Pause
    Given wake lock was active
    When the user pauses the timer
    Then the wake lock is released

  @pwa
  Scenario: Screen Wake Lock Released on End
    Given wake lock was active
    When the user ends the session
    Then the wake lock is released

  @edge-cases
  Scenario: Session with No Pages
    Given a session is ended without logging any pages
    When saved
    Then it appears in history with 0 pages and 0 avg time

  @edge-cases
  Scenario: Delete Last Session
    Given only one session exists
    When it is deleted
    Then history shows "No saved sessions"

  @edge-cases
  Scenario: Empty History
    Given no sessions have been saved
    When the user opens history
    Then it shows "No saved sessions"

  @edge-cases
  Scenario: Very Long Session Name
    Given a session name exceeds normal width
    When displayed in history or accordion
    Then text should not overflow or break layout

  @edge-cases
  Scenario: Rapid Page Tapping
    Given the timer is running
    When the user rapidly taps "New Page" multiple times
    Then each tap registers a new page correctly

  @edge-cases
  Scenario: Session Detail with Single Page
    Given a session with only 1 page
    When viewing detail
    Then no fastest/slowest highlighting appears
