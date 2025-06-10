# HorizonFrame Development Workflow

## Core Documents

This section lists the essential documents that guide the HorizonFrame project. Consistent use and maintenance of these documents are key to effective collaboration and project clarity.

1.  **`Docs/WorkflowGuide.md` (This Document)**
    *   **Purpose:** The central, canonical guide to the entire development workflow. Explains the role of each key document, the daily startup procedure, documentation standards, and how documents interrelate.
    *   **Usage:** Consult this if you have any questions about the process or how to use other documents.

2.  **`README.md`** (Project Root)
    *   **Purpose:** Main project overview, quick start instructions for running the app, repository structure, technology stack, and high-level contribution guidelines. Links to this `WorkflowGuide.md` and `Docs/Onboarding.md`.
    *   **Usage:** Entry point for anyone new to the project or needing a general overview.

3.  **`Docs/DailyBriefing.md`**
    *   **Purpose:** The USER's first point of contact each day. Contains the overall project goal, current sprint focus, a summary of the last session (accomplishments, decisions, issues), and critically, the **Key Tasks for Today's Session**.
    *   **Usage:** Reviewed at the start of each session by both USER and AI to align on immediate objectives.

4.  **`Docs/Roadmap.md`**
    *   **Purpose:** Outlines long-term project vision, planned features, and improvements, organized by version using Markdown task lists (`- [ ]`, `- [x]`).
    *   **Usage:** Consulted to understand broader context, identify upcoming work, and track feature completion.

5.  **`Docs/DevLog.md`**
    *   **Purpose:** A chronological, detailed log of development sessions. Each entry includes the date, tasks worked on, key accomplishments, decisions made, issues encountered, and next steps considered.
    *   **Usage:** Maintained by the USER with AI assistance at the end of each session or significant milestone. Provides a historical record and context.

6.  **`Docs/Architecture.md`**
    *   **Purpose:** Describes the high-level architecture of the HorizonFrame application. This includes its main layers (e.g., Views, ViewModels, Models, Services), key components within those layers, and the primary data flow. It should clearly document the role of `ViewModels/AppData.swift` as the central observable object for managing shared application state (like collected passages, default passage, alignment streaks) and how it interacts with various views.
    *   **Usage:** Consulted when tasks involve significant architectural changes, understanding system design, or how data is managed and propagated through the app. Should be updated when major structural changes or data management strategies are implemented.

7.  **`Docs/CodeStyle.md`** (Create when needed)
    *   **Purpose:** Defines coding standards, naming conventions, and best practices for the project.
    *   **Usage:** Reference for all developers to ensure code consistency.

8.  **`Docs/Onboarding.md`**
    *   **Purpose:** Guide for new *contributors* to set up their development environment, including prerequisites and first-time configuration steps.
    *   **Usage:** Referenced in `README.md` for new team members.

9.  **`Docs/MetaPrompts/DailyStart_LLMPrompt.md`**
    *   **Purpose:** Contains specific instructions for the AI assistant at the beginning of each new chat/session. Guides the AI on how to initialize, review key documents (`DailyBriefing.md`, `Roadmap.md`), and support documentation maintenance.
    *   **Usage:** The USER directs the AI assistant to this file at the start of every session.

10. **`Docs/MetaPrompts/DailyFinish_LLMPrompt.md`**
    *   **Purpose:** Contains specific instructions for the AI assistant at the end of each session. Guides the AI in creating the `DevLog.md` entry and preparing `DailyBriefing.md` for the next session.
    *   **Usage:** The USER directs the AI assistant to this file to conclude a session.

(Note: The `Specs/` directory contains detailed specifications for *features*, e.g., `Specs/Onboarding.md` for the *user* onboarding feature design, which is distinct from `Docs/Onboarding.md` for *contributor* development environment setup.)

## Daily Workflow

This outlines the standard procedure for development sessions.

1.  **Session Start**
    *   **USER:** Reviews `Docs/DailyBriefing.md` to understand current status and tasks.
    *   **USER:** Provides the content of `Docs/MetaPrompts/DailyStart_LLMPrompt.md` to the AI assistant.
    *   **AI:** Follows `DailyStart_LLMPrompt.md` instructions (reviews `Docs/DailyBriefing.md`, `Docs/Roadmap.md`).
    *   **USER & AI:** Clarify objectives and plan for the session.

2.  **During Development**
    *   **USER & AI:** Collaborate on tasks outlined in `Docs/DailyBriefing.md`.
    *   **AI:** Assists in updating `Docs/Roadmap.md` task statuses as features are completed or progress.
    *   **USER & AI:** Document significant decisions or changes as they occur, primarily for later inclusion in `Docs/DevLog.md`.
    *   **USER:** Ensures code aligns with `Docs/CodeStyle.md` (if established).

3.  **Session End**
    *   **USER:** Provides the content of `Docs/MetaPrompts/DailyFinish_LLMPrompt.md` to the AI assistant.
    *   **AI & USER:** Collaborate to:
        *   Create a comprehensive entry in `Docs/DevLog.md` summarizing the session.
        *   Update `Docs/DailyBriefing.md` in preparation for the next session (or note key items for the USER to update).

## Documentation Standards

- Use clear, accessible language
- No emojis
- Keep task descriptions actionable
- Include completion timestamps
- Reference related documents when needed

## Version Control

- Use GitHub Desktop for commits
- Write clear commit messages
- Reference task IDs when applicable

This guide is maintained by the development team and AI assistants ("Automated Doc Refresher").
