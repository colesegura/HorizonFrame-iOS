# HorizonFrame Project Roadmap

This document outlines planned features and improvements for HorizonFrame. It is a living document and will be updated as priorities evolve.

## Version 0.2.0: Core Feature Enhancements

- [ ] **Alignment Streak & Progress:**
    - [ ] Introduce a page displayed after completing a daily alignment, showing the current streak (consecutive days of alignment).
    - [ ] Enhance the Progress Tab to display a calendar view or list showing which days alignment was completed, and how many times per day if multiple alignments occurred.
- [x] **Personal Code Editing (Align Page - Scroll & Sculpt Implemented):**
    - [x] Implement inline adding of new statements.
    - [x] Implement swipe-to-reveal delete action with confirmation.
    - [ ] Implement swipe-to-reveal edit action (mechanism for editing TBD: inline expansion or dedicated plinth).
    - [ ] _(Moved to v0.2.1)_ ~~triggered by the 3-dot menu. This includes modifying, adding, and deleting statements.~~
- [ ] **Collect Page UI & Functional Parity:**
    - [x] Update the Personal Code display on the Collect page to visually match the Align page (grey text on black background, white "Add new line" option).
    - [ ] Enable editing of personal code statements on the Collect page, similar to the Align page.
    - [ ] Allow dragging personal code statements to the Insight Collection (or copying).
    - [ ] Allow copying insights from the Insight Collection to Personal Code.
- [ ] **Insight Collection Styling:**
    - [x] Ensure the Insight Collection display format (text fields, backgrounds) matches the Personal Code styling for consistency.

## Version 0.2.1: Refinements & UI Polish

- [ ] **AlignView Add Behavior:** Change the "Craft a new intention..." field so that new statements are added to the *bottom* of the personal code list, instead of the top.
- [ ] **AlignView Edit Action:** Define and implement the specific interaction for editing a personal code statement via swipe-to-reveal (e.g., inline TextEditor, modal, or navigation to a dedicated edit view).
- [ ] **AlignView Styling & Polish:** Refine visual appearance of swipe actions, add field, and row presentation. Add haptic feedback.
- [ ] **AlignView Accessibility:** Ensure new swipe interactions are accessible.

## Version 0.3.0: Notifications & Customization

- [ ] **Customizable Insight Notifications:**
    - [ ] Introduce a system to send notifications containing randomly selected insights from the user's Insight Collection.
    - [ ] Allow users to customize notification frequency and timing (e.g., morning, evening, specific times) in the Settings page.

## Future Considerations (Post 0.3.0)

### Workflow & Tooling Refinements
- [ ] **Review Todoist Usage:** Evaluate the current Todoist board and decide on its role (if any) within the new development workflow, ensuring task sources are clear (Daily Briefing, Roadmap).
- [ ] **Review Obsidian Usage:** Evaluate the current Obsidian setup and decide on its role (if any) within the new development workflow, ensuring task sources are clear (Daily Briefing, Roadmap).
- [ ] **Review MetaPrompts:** Evaluate existing LLM prompts in MetaPrompts folder and identify any that need updating to align with current project goals and workflow. Additionally, identify any additional prompts that may be needed for the upkeep of this meta-system.

- [ ] **Settings Page UI Revision:** A comprehensive UI overhaul for the Settings page to improve organization and user experience as more options are added.
- [ ] **Advanced Statistics & Trends:** More detailed analytics in the Progress Tab.
- [ ] **Cloud Sync & Backup:** Options for users to back up and sync their data.
- [ ] **Export Options:** More robust data export formats.

---

*This roadmap helps guide development efforts. Specific features and timelines are subject to change based on user feedback and development capacity.*
