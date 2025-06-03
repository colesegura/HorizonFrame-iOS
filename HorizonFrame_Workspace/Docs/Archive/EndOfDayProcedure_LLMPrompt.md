# Meta-Prompt: End of Day Procedure

**USER:** "Okay, I'm wrapping up for the day." or something along those lines.

**AI Assistant's Role:** To assist the USER in comprehensively updating project documentation to ensure a smooth handover and accurate record-keeping. Follow these steps meticulously:

1.  **Acknowledge & Inquire:**
    *   Acknowledge the user is ending the session.
    *   Ask if there are any final thoughts, decisions, or minor changes made that haven't been explicitly mentioned, to ensure they are captured.

2.  **Review Session's Work:**
    *   Briefly list the key tasks that were worked on during the session (referencing `DailyBriefing.md` and any emergent tasks).

3.  **Update `Docs/Roadmap.md`:**
    *   For each task worked on from the current sprint:
        *   If completed: Mark with `[x]` and add a completion timestamp `(Completed: YYYY-MM-DD HH:MM)`.
        *   If partially completed or has new findings/issues: Add a sub-bullet under the task briefly noting the status or issue (e.g., `*   Status: Still investigating swipe action issue.`).
        *   If a "User Vision" was clarified or defined, ensure it's accurately captured.
    *   Add any newly identified bugs or small features that arose during the session if not already captured.

4.  **Update `Docs/DevLog.md`:**
    *   Create a new entry for the current date (YYYY-MM-DD).
    *   Include the following sections:
        *   **Date:** Current date.
        *   **Key Tasks Worked On:** List tasks from `DailyBriefing.md` and any emergent tasks handled.
        *   **Accomplishments:** What was successfully implemented or achieved.
        *   **Key Decisions Made:** Important choices or architectural decisions.
        *   **Issues Encountered:** Any bugs, blockers, or unresolved problems (e.g., "`AlignView` swipe actions still not working in simulator despite multiple attempts: `ScrollView`, `LazyVStack`, gesture simplification.").
        *   **Next Steps (for next session):** What should be prioritized or looked at next.

5.  **Update `Docs/DailyBriefing.md` (for the *Next* Session):
    *   Set the date at the top to tomorrow's date.
    *   **Overall Project Goal:** Verify it's still current.
    *   **Current Sprint Focus:** Verify it's still current (e.g., `Sprint 0.1.3`).
    *   **Summary of Last Session (Today's Session):** Write a concise summary based on the `DevLog.md` entry just created. Highlight key achievements and critical unresolved issues.
    *   **Key Tasks for Today's Session (Tomorrow's Session):** Populate this list based on:
        *   Unfinished tasks from today.
        *   New issues identified today that need addressing.
        *   The "Next Steps" identified in `DevLog.md`.
        *   The next logical tasks from the current sprint in `Roadmap.md`.

6.  **Reminder for Version Control:**
    *   Remind the USER: "Please remember to commit and push your changes using GitHub Desktop to ensure everything is saved and backed up."

7.  **Confirmation & Closing:**
    *   Confirm that all documentation updates (`Roadmap.md`, `DevLog.md`, `DailyBriefing.md`) have been made.
    *   Wish the user well and offer to assist with any final quick questions before they log off.

*This prompt ensures that the project's state is accurately captured and the next session can begin efficiently.*
