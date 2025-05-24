# Daily Start Instructions for LLM Assistant (HorizonFrame Project)

Welcome! The USER will be starting their day by reviewing `../DailyBriefing.md`. Your role is to support them in achieving the day's goals. Please follow these steps:

1.  **Acknowledge USER's Starting Point:** The USER has already consulted `../DailyBriefing.md`. Confirm you are ready to assist with the tasks outlined there.

2.  **Internal Contextual Review:**
    *   **`../DailyBriefing.md`:** Quickly review this yourself to understand the immediate tasks, previous session summary, and any blockers.
    *   **`../Roadmap.md`:** Consult this to understand how today's tasks fit into the larger project goals and upcoming versions. Note any tasks in the Roadmap that might be completed or progressed by today's work.
    *   **`../Architecture.md` (If relevant):** Review if today's tasks involve significant architectural changes.

3.  **Clarify & Confirm Objectives:** Based on your review, briefly confirm your understanding of the USER's primary objectives for the session. Ask any essential clarifying questions to ensure alignment.

4.  **Creative Brainstorming (Offer if applicable):** If the tasks in `../DailyBriefing.md` involve designing new features or significant refactoring, ask the USER: "We're about to tackle [specific task]. Do you have a specific implementation in mind, or would you like to consult with 'Exploratory Ideation' for a few creative approaches first?" If they opt for the Designer, embody that persona: provide 3 novel ideas, explain their pros/cons, and offer a recommendation.

5.  **Documentation Support (Ongoing):**
    *   **`../Roadmap.md` Task Management (NEW PROTOCOL):**
        *   **Adding New Tasks:** When the USER defines a new task to be worked on (not a quick daily to-do, but something for the project's future), automatically add it to `../Roadmap.md`.
            *   Place it under the current active sprint (e.g., `### Sprint 0.1.x`) or the next planned sprint if the current one is full or nearly complete.
            *   Use the format: `- [ ] **Task Title:** Brief description.
                *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task. Prompt the USER to fill this in if they don't provide it immediately).`
        *   **Updating Task Status:** When a task is confirmed by the USER as complete:
            *   Mark it as `- [x]`.
            *   Append a completion timestamp in the format `(Completed: YYYY-MM-DD HH:MM)`. Example: `- [x] **Task Title:** Description. (Completed: 2025-05-24 15:57)`
            *   Ensure the current local time is used for the timestamp.
        *   **Working on Tasks:** When starting a task from the Roadmap, refer to its `User Vision:` sub-bullet to understand the specific requirements and goals.
    *   **`../DevLog.md`:** At the end of the session (or significant milestones), assist the USER in preparing a detailed entry for the DevLog.
    *   **`../WorkflowGuide.md`:** If the USER has questions about our development process, refer them to this document.

6.  **Recall User Preferences:** Be mindful of the user's documentation preferences (emoji-free, accessible language, "Automated Doc Refresher" - Memory ID: 5de9c30b-ac36-48df-ba4c-13a7f5034109) and any other relevant memories.

Let's align and build!
