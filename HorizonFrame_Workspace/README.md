# NeuroPaths – Chart Your Inner Cosmos

> *Rewire your emotional responses and visualize your journey of transformation as a unique Neural Constellation.*

---

## Why NeuroPaths?

Traditional well-being apps often focus on tracking habits or moods. NeuroPaths takes a deeper approach, guiding you through the science-backed process of **rewiring your brain's emotional circuits.**

The app empowers you to:

1.  **Identify & Acknowledge Emotions:** Recognize and name the emotions you're experiencing without judgment.
2.  **Complete the Emotional Circuit:** Engage in a guided practice to process and reframe these emotions, effectively neutralizing unhelpful patterns and fostering new, positive neural pathways. This is based on the principles of neuroplasticity.
3.  **Visualize Your Growth:** As you log your completed emotional circuits and reflections, watch your personal **Neural Constellation** grow and evolve. Each completed circuit adds a new "star" or connection, creating a beautiful and dynamic map of your inner transformation.
4.  **Cultivate Emotional Intelligence:** Develop a deeper understanding of your emotional landscape and build resilience.

---

## Current Status — May 2025

*   **Major Pivot:** The project has pivoted to **NeuroPaths**, focusing on emotional circuit reframing and neural constellation visualization.
*   The project structure remains `HorizonFrame_Workspace` (pending rename to reflect NeuroPaths), and documentation is managed using an integrated Obsidian-based system.

*(This section is updated when major project milestones change)*

---

## Our Development Workflow

We follow a structured, collaborative workflow designed for clarity and efficiency, especially when working with AI assistants. This process helps us manage tasks, track progress, and maintain clear communication.

**For a detailed explanation of our day-to-day process, roles of key documents (`DailyBriefing.md`, `Roadmap.md`, `DevLog.md`), and how to get started each day, please see our [Development Workflow Guide](Docs/WorkflowGuide.md).**

---

## Repository Structure (High-Level Overview)

```
HorizonFrame-iOS/ (Workspace Root)
├── Horizon-Frame/            – Main application source code and resources
│   ├── Horizon-Frame.xcodeproj/  – The main Xcode project file
│   ├── Models/               – Simple Swift data structures
│   ├── ViewModels/           – Manages data for views (MVVM)
│   ├── Views/                – SwiftUI files for UI (organized by feature)
│   ├── Services/             – Handles tasks like notifications, data storage
│   └── ... (other app-specific files like App.swift, Assets.xcassets)
├── Docs/                     – Project documentation (Architecture, DevLog, etc.)
├── Specs/                    – Specifications and requirements documents
└── README.md                 – This file, providing a project overview
```

A detailed explanation of the app's layers, components, and future plans can be found in `Docs/Architecture.md`.

---

## Main Technologies Used

| Technology          | Purpose                                                                 |
| :------------------ | :---------------------------------------------------------------------- |
| **SwiftUI**         | Apple's modern framework for building user interfaces (for iOS 18+).    |
| **Combine**         | Apple's framework to manage how data changes and flows within the app.  |
| **UserNotifications** | Handles sending local daily reminders from your Insight Bank.           |
| **SwiftData** (planned) | A future replacement for `UserDefaults` for a more robust way to save app data. |

Currently, the project uses only Apple's native frameworks, making it easier for new contributors to get started. We plan to use **Swift Package Manager (SPM)** for any future third-party libraries.

---

## Contributing to NeuroPaths

Welcome to the team! Here’s how you can contribute:

1.  **Get Set Up:** Start by reading the `Docs/Onboarding.md` guide. It will walk you through setting up your development environment (this should take about 20 minutes).
2.  **Find a Task:**
    *   **Primary Task Sources:**
        *   For **immediate daily tasks**, refer to the "Key Tasks for This Session" section in `Docs/DailyBriefing.md`.
        *   For **longer-term features, epics, and planned improvements**, consult `Docs/Roadmap.md`.
    *   (Todoist may be used as a personal scratchpad, but `DailyBriefing.md` and `Roadmap.md` are the official sources for project tasks.)
3.  **Coding and Committing Your Work:**
    *   Always create a new branch for your changes. This keeps the main codebase stable.
    *   Save your work frequently by making commits. Use clear and descriptive commit messages (e.g., `feat: implement user profile screen`, `fix: resolve issue with data saving`, `docs: clarify setup instructions`).
4.  **Reporting Your Progress:**
    *   Each day you contribute, please add a brief note to `Docs/DevLog.md` under the current date. Describe what you accomplished, any significant decisions you made, or any problems you encountered. This helps keep everyone informed.
5.  **Keeping Documentation Up-to-Date (Automated Doc Refresher):**
    *   We use an "Automated Doc Refresher" process. This system, often facilitated by an LLM assistant, ensures our key documentation (`DailyBriefing.md`, `DevLog.md`, `Architecture.md`, `README.md`) remains consistent with the latest code changes and project status. This up-to-date documentation is vital for effective daily handoffs and onboarding for all contributors.
    *   If you make significant changes to the code (like adding a major new feature or altering how a core part of the app works), please also update `Docs/Architecture.md` as needed. The "Automated Doc Refresher" process includes support for incorporating daily progress into `DevLog.md` and preparing `DailyBriefing.md` for the next session.
6.  **Submitting Your Changes (Pull Requests):**
    *   When your feature or bug fix is complete and you've tested it, submit a Pull Request (PR) on GitHub.
    *   Another developer (or an AI assistant like me) will review your code. Once it's approved, your changes will be merged into the main project.

Our detailed coding style guide and rules for naming branches are located in `Docs/CodeStyle.md`.

---

## License

_Proprietary © Cole Segura 2025 – please contact for permitted uses._
