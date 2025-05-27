# NeuroPaths Project Roadmap (Concept: Neural Constellation)

This document outlines planned features and improvements for the **NeuroPaths** application. It is a living document and will be updated as priorities evolve. The app's core purpose is to guide users through a neurological reframing practice, visualizing progress as a personal "Neural Constellation."

## Version 0.1.0: Minimum Viable Product (MVP) - Neural Constellation Core

*Goal: Implement the core circuit completion practice and initial constellation visualization.* 

### Sprint 0.1.1: Foundation & Logging

- [ ] **Project Setup & Renaming:**
    - [ ] Rename project/target from "HorizonFrame" to "NeuroPaths" (or chosen final name).
    - [ ] Update bundle identifiers, display names, etc.
- [ ] **Core Data Model:**
    - [ ] Define data structures for storing logged emotional experiences (emotion type, custom text, timestamp, affirmation used, completion status).
    - [ ] Choose and implement a local data storage solution (e.g., SwiftData, Core Data, Realm).
- [ ] **Emotion Selection UI:**
    - [ ] Design and implement a UI for users to select or input the emotion they are experiencing (e.g., categorized list, wheel, text input with suggestions).
    - [ ] Include a predefined list of common positive and negative emotions.
- [ ] **Guided Circuit Completion UI:**
    - [ ] Create a view sequence that guides the user through the verbal affirmation process: "I am feeling [Emotion] because I choose to believe I need to/must."
    - [ ] Allow users to mark the circuit as complete.
- [ ] **Basic Data Logging:**
    - [ ] Save the logged experience (emotion, timestamp, completion) to local storage.

### Sprint 0.1.2: Initial Constellation Visualization

- [ ] **Basic Constellation View:**
    - [ ] Create a 2D view that represents logged experiences as simple nodes (stars/dots) on a dark background.
    - [ ] Each completed circuit adds a new node.
    - [ ] Basic animation for a new node appearing.
- [ ] **Launch Screen & App Icon:**
    - [ ] Design and implement a new launch screen reflecting the "Neural Constellation" theme.
    - [ ] Design and implement a new app icon.
- [ ] **Basic Navigation:**
    - [ ] Simple navigation between the logging flow and the constellation view.

### Sprint 0.1.3: Enhancing the Constellation & Feedback

- [ ] **Visual Differentiation of Nodes:**
    - [ ] Vary color/size/glow of nodes based on emotion type (positive/negative) or category.
- [ ] **Basic Neural Pathway Animation:**
    - [ ] When a circuit is completed, animate a simple line connecting the new node to a central point or a previous related node (rudimentary pathway).
- [ ] **Encouragement Messages:**
    - [ ] Display a positive, encouraging message after a circuit is completed.
- [ ] **Settings:**
    - [ ] Basic settings page (e.g., option to clear all data with confirmation).

## Version 0.2.0: Immersive Constellation & Tracking

*Goal: Make the constellation more interactive and visually rich, introduce progress tracking.* 

- [ ] **Interactive Constellation:**
    - [ ] Allow users to pan/zoom the constellation view.
    - [ ] Tap on a node to see details (date, emotion).
- [ ] **Advanced Neural Pathway Visualization:**
    - [ ] More sophisticated animations for pathway formation (e.g., glowing energy flow).
    - [ ] Pathways strengthen or brighten with repeated engagement with similar emotions.
- [ ] **"My Inner Cosmos" / Progress Page:**
    - [ ] Dedicated page showing statistics (e.g., total circuits completed, streaks of daily practice, breakdown by emotion type).
    - [ ] Visual representation of overall constellation growth/complexity.
- [ ] **Custom Emotion Input:**
    - [ ] Allow users to add custom emotion labels if not in the predefined list.
- [ ] **Refined UI/UX:**
    - [ ] Polish animations, transitions, and overall visual appeal based on the "Neural Constellation" theme.
    - [ ] Haptic feedback for key interactions.

## Version 0.3.0: Personalization & Deeper Insights

*Goal: Allow more user customization and provide deeper insights into their patterns.*

- [ ] **Constellation Themes/Customization:**
    - [ ] Offer different color palettes or visual styles for the constellation (e.g., different nebula backgrounds, pathway styles).
- [ ] **Reflection/Journaling:**
    - [ ] Option to add a brief note or reflection to each logged experience.
- [ ] **Pattern Recognition & Insights:**
    - [ ] Simple analytics to highlight patterns (e.g., "You've focused on reframing 'anxiety' 5 times this week. Great job!").
- [ ] **Reminder Notifications:**
    - [ ] Option to set gentle reminders to engage with the practice.

## Future Considerations (Post 0.3.0)

- [ ] **Advanced 3D Constellation:** Explore a fully 3D interactive environment.
- [ ] **Guided Meditations/Sessions:** Integrate audio guides for the practice.
- [ ] **Community/Sharing (Optional & Privacy-Focused):** Allow users to share anonymized constellation images or progress.
- [ ] **iCloud Sync & Backup.**
- [ ] **Wearable Integration (e.g., Apple Watch prompts/logging).**
- [ ] **Accessibility Enhancements (VoiceOver, dynamic type, etc.).**

---
## PREVIOUS ROADMAP (Archived 2025-05-27)

*(The following roadmap was for a previous app concept: HorizonFrame, focused on personal code and insight collection.)*

## Version 0.2.0: Core Feature Enhancements

## Version 0.2.0: Core Feature Enhancements

_(This version will be achieved upon completion of Sprints 0.1.3, 0.1.4, etc. below. Tasks are ordered by approximate priority within sprints.)_

### Sprint 0.1.3 (Target: Current Development Cycle)

- [x] **AlignView Add Behavior:** Change the "Craft a new intention..." field so that new statements are added to the *bottom* of the personal code list, instead of the top. (From old v0.2.1) (Completed: 2025-05-24 15:57)
- [ ] **AlignView Edit Action (Definition & Implementation):** Define and implement the specific interaction for editing a personal code statement via swipe-to-reveal (e.g., inline TextEditor, modal, or navigation to a dedicated edit view). (From old v0.2.1)
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
    *   Status (2025-05-24): Swipe-to-reveal actions (for delete/edit) are not currently working in the macOS simulator despite several debugging attempts (ScrollView, LazyVStack, gesture simplification). Further investigation or alternative (e.g., device testing) needed.
    - [ ] _Consolidates: "Implement swipe-to-reveal edit action (mechanism for editing TBD: inline expansion or dedicated plinth)" from old v0.2.0 and the 3-dot menu item that was moved._
- [ ] **AlignView Styling & Polish:** Refine visual appearance of swipe actions, add field, and row presentation. Add haptic feedback. (From old v0.2.1)
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **AlignView Accessibility:** Ensure new swipe interactions are accessible. (From old v0.2.1)
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **AlignView: Implement drag-to-rearrange for personal code statements.**
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **SettingsView: Enhance 'Clear All Data' button safety.**
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).

### Sprint 0.1.4 (Target: Next Development Cycle)

- [ ] **Collect Page UI & Functional Parity (Editing):** Enable editing of personal code statements on the Collect page, similar to the Align page. (From old v0.2.0)
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **Collect Page UI & Functional Parity (Interactions):** 
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
    - [ ] Allow dragging personal code statements to the Insight Collection (or copying).
    - [ ] Allow copying insights from the Insight Collection to Personal Code.
- [ ] **Alignment Streak & Progress (Display):** Introduce a page displayed after completing a daily alignment, showing the current streak (consecutive days of alignment). (From old v0.2.0)
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **Alignment Streak & Progress (Calendar/List):** Enhance the Progress Tab to display a calendar view or list showing which days alignment was completed, and how many times per day if multiple alignments occurred. (From old v0.2.0)
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).

*(Note: Items marked [x] from the old 0.2.0 like "Implement inline adding of new statements" are considered complete and prerequisites for these sprints, so they are not re-listed as to-do.)*

## Version 0.3.0: Notifications & Customization

- [ ] **Customizable Insight Notifications:**
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
    - [ ] Introduce a system to send notifications containing randomly selected insights from the user's Insight Collection.
    - [ ] Allow users to customize notification frequency and timing (e.g., morning, evening, specific times) in the Settings page.

## Future Considerations (Post 0.3.0)

### Workflow & Tooling Refinements
- [ ] **Review Todoist Usage:** Evaluate the current Todoist board and decide on its role (if any) within the new development workflow, ensuring task sources are clear (Daily Briefing, Roadmap).
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **Review Obsidian Usage:** Evaluate the current Obsidian setup and decide on its role (if any) within the new development workflow, ensuring task sources are clear (Daily Briefing, Roadmap).
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **Review MetaPrompts:** Evaluate existing LLM prompts in MetaPrompts folder and identify any that need updating to align with current project goals and workflow. Additionally, identify any additional prompts that may be needed for the upkeep of this meta-system.
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).

- [ ] **Settings Page UI Revision:** A comprehensive UI overhaul for the Settings page to improve organization and user experience as more options are added.
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **Advanced Statistics & Trends:** More detailed analytics in the Progress Tab.
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **Cloud Sync & Backup:** Options for users to back up and sync their data.
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).
- [ ] **Export Options:** More robust data export formats.
    *   **User Vision:** (Placeholder for USER to detail the exact requirements/vision for this task).

---

*This roadmap helps guide development efforts. Specific features and timelines are subject to change based on user feedback and development capacity.*
