# HorizonFrame Development Workflow Guide

Welcome to the HorizonFrame project! This guide outlines our collaborative development workflow, designed to be clear, efficient, and effective for both human (USER) and AI (Cascade) participants.

## Core Principles

*   **Clarity:** Know where to find information and what to do next.
*   **Efficiency:** Minimize redundant information and effort.
*   **Actionability:** Clearly track tasks and progress.
*   **Simplicity:** Easy for both human and AI to follow and maintain.

## Key Documents & Their Roles

1.  **`Docs/DailyBriefing.md` (Your Morning Dashboard)**
    *   **Purpose:** This is the **FIRST document the USER should review at the start of each workday/session.** It provides a snapshot of the current state and the plan for the day.
    *   **Content Structure:**
        *   `## Overall Project Goal & Current Sprint Focus`: Links to `Roadmap.md` for broader context.
        *   `## Summary of Yesterday's Session`: Key accomplishments, decisions, new memories created, link to the relevant `DevLog.md` entry.
        *   `## Key Tasks for Today's Session`: Actionable items for the current day, formatted as a Markdown task list (`- [ ]` for pending, `- [x]` for completed).
        *   `## Blockers/Open Questions`: Any impediments or queries.
        *   `## Pointers & Reminders`: Links to relevant memories, specific documents, etc.
    *   **Workflow:** Cascade will assist in populating the "Summary of Yesterday" and drafting "Key Tasks for Today" (based on `Roadmap.md` and carry-overs). The USER reviews, adjusts, and finalizes it.

2.  **`Docs/Roadmap.md` (Long-Term Vision & Feature Tracking)**
    *   **Purpose:** Tracks larger features, epics, and version goals for the HorizonFrame project.
    *   **Format:** All items **MUST** use Markdown task list syntax (`- [ ]` for pending, `- [x]` for completed).
    *   **Workflow:** Updated collaboratively. When a roadmap item (or a significant part of it) is completed, it's marked `- [x]`. New feature ideas and significant fixes are added here as `- [ ]` items.

3.  **`Docs/DevLog.md` (The Detailed Project Diary)**
    *   **Purpose:** A chronological, detailed log of each development session. This is where the nitty-gritty details are recorded: specific decisions, problems encountered, solutions, rationale, code snippets discussed, memories created, etc.
    *   **Workflow:** Cascade will help append a summary to this file at the end of each session. This log can be referenced from `DailyBriefing.md` for context on past work.

4.  **`Docs/MetaPrompts/DailyStart_LLMPrompt.md` (AI's Morning Instructions)**
    *   **Purpose:** Contains the initial instructions for Cascade at the beginning of each new session.
    *   **Workflow:** The USER will provide this prompt to Cascade. It guides Cascade to review `DailyBriefing.md` and `Roadmap.md`, offer brainstorming, and understand the day's objectives. It also includes instructions for Cascade to help maintain the documentation system (e.g., updating `Roadmap.md` task statuses).

5.  **`README.md` (Project Overview)**
    *   **Purpose:** Provides a high-level introduction to the HorizonFrame project.
    *   **Content:** Includes a link to this `WorkflowGuide.md` for easy access to our process documentation.

6.  **This Document (`Docs/WorkflowGuide.md`)**
    *   **Purpose:** Your central reference for understanding how our collaborative meta-process works. If you're unsure about the workflow, start here.

## Daily Startup Procedure for the USER

1.  **Open `Docs/DailyBriefing.md`:** This is your primary starting point.
2.  **Review:** Understand yesterday's summary and today's key tasks.
3.  **Initiate Session with Cascade:** Provide the content of `Docs/MetaPrompts/DailyStart_LLMPrompt.md` to Cascade.
4.  **Collaborate:** Work with Cascade on the tasks outlined in `DailyBriefing.md`.

## Task Management

*   **Daily Tasks:** Managed within `Docs/DailyBriefing.md` using `- [ ]` / `- [x]`.
*   **Long-Term Features/Epics:** Managed within `Docs/Roadmap.md` using `- [ ]` / `- [x]`.
*   Cascade will assist in updating the status of these tasks as work progresses.

This workflow is designed to be adaptive. We can review and refine it as needed.
