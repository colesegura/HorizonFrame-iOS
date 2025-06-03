
---

## 2025-05-27: Pivot to "NeuroPaths - Neural Constellation" Concept

**Decision:**
The project will pivot from the "HorizonFrame" concept (a daily alignment journal) to a new concept named "NeuroPaths." The core theme will be "Neural Constellation."

**Context & Problem:**
The HorizonFrame concept, while sound, was perceived to have limited market differentiation and potential for viral engagement. A more compelling and visually unique direction was sought to align with current trends in mental wellness, neuroplasticity, and personalized digital experiences.

**Alternatives Considered:**
1.  **Continue with HorizonFrame:** Refine existing features and marketing.
2.  **Minor Theme Adjustment for HorizonFrame:** Keep core functionality but explore different UI themes (e.g., "Zen Garden," "Mindful Explorer").
3.  **Radical Pivot (Selected):** Develop a new core mechanic and theme (NeuroPaths).

**Reasoning for Decision:**
*   **Stronger Unique Value Proposition:** "NeuroPaths" offers a distinct approach by focusing on actively "rewiring" emotional responses and visualizing this internal journey as a personal "Neural Constellation." This is more tangible and engaging than a general alignment journal.
*   **Visual Appeal & Marketability:** The "Neural Constellation" theme lends itself to stunning, shareable visuals, which is advantageous for marketing on platforms like Instagram and TikTok.
*   **Alignment with Scientific Interest:** The concept taps into growing public interest in neuroplasticity and emotional intelligence.
*   **User Engagement Potential:** The idea of building and evolving a personal constellation offers a compelling long-term engagement loop.

**Consequences & Impact:**
*   **Documentation Overhaul:** Significant updates required for `Roadmap.md`, `UI_Theme_Exploration.md`, `MarketingStrategy.md`, `README.md`, `Architecture.md`, and this `Decisions.md`. All previous documentation related to HorizonFrame will be archived within these documents for potential future reference.
*   **Development Shift:** The development roadmap will be entirely revised to focus on NeuroPaths MVP features (emotion logging, guided circuit completion, basic constellation visualization).
*   **Potential for Reversion:** The pivot is undertaken with the understanding that if the NeuroPaths concept does not prove viable, the team can revert to the archived HorizonFrame documentation and plans.

**Stakeholders Notified:**
*   N/A (Currently a solo project with AI assistance).

---


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

**For a detailed explanation of our day-to-day process, roles of key documents (`DailyBriefing.md`, `Roadmap.md`, `DevLog.md`), and how to get started each day, please see our [Development Workflow Guide](WorkflowGuide.md).**

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

# NeuroPaths Architecture (Version 0.1 - Initial Concept)

_Last updated: 2025-05-27_

---

**Core Concept:**
NeuroPaths guides users through a process of identifying, acknowledging, and reframing emotions to "complete an emotional circuit." Progress is visualized as a personal "Neural Constellation" that grows and evolves with each completed circuit and reflection.

**1. High-Level Diagram (Conceptual - To Be Detailed)**

```
┌─────────────────────────────── App Layer (SwiftUI) ────────────────────────────────┐
│  EmotionInputView   CircuitGuidanceView   ConstellationView   JournalView  SettingsView │
│                                           ▼                                         │
│                     ViewModels (Manage Data for Views)                              │
│   EmotionInputVM   CircuitGuidanceVM   ConstellationVM   JournalVM   SettingsVM     │
└─────────────────────────────────────────────▲──────────────────────────────────────┘
                                              │
                               ———————————————––
                               |    Shared Services Layer    |
                               |–––––––––––––––––––––––|
                               | • AppData (Stores app data: emotions, circuits, constellation nodes, user settings) |
                               | • ConstellationEngine (Manages logic for constellation generation & evolution) |
                               | • PersistenceService (Defines how data will be saved - likely SwiftData) |
                               ———————————————––
                                              │
┌─────────────────────────────┴─────────────────────────────┐
│                             System Frameworks                                     │
│   Foundation · Combine · SwiftUI · SwiftData (once adopted) · (Potentially graphics frameworks for constellation) │
└───────────────────────────────────────────────────────────┘
```

**2. Key Modules and Their Responsibilities (Initial Thoughts)**

| Module / Class          | Directory (Tentative)                      | Responsibility                                                                                                                               |
| :---------------------- | :----------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------- |
| **AppData**             | `ViewModels/AppData.swift`                 | Stores user's emotional entries, completed circuits, constellation data (nodes, connections), and user preferences. Will sync with PersistenceService. |
| **ConstellationEngine** | `Services/ConstellationEngine.swift`       | Contains the logic for generating and updating the visual representation of the user's Neural Constellation based on their logged data.        |
| **EmotionInputView**    | `Views/EmotionInput/EmotionInputView.swift`| Allows users to select or input current emotions and initial thoughts/sensations.                                                            |
| **CircuitGuidanceView** | `Views/CircuitGuidance/CircuitGuidanceView.swift`| Guides the user through the steps of acknowledging, processing, and reframing the selected emotion to complete the circuit.                   |
| **ConstellationView**   | `Views/Constellation/ConstellationView.swift`| Displays the user's personal Neural Constellation. This will be a dynamic and evolving visualization.                                       |
| **JournalView**         | `Views/Journal/JournalView.swift`          | Allows users to review past entries, completed circuits, and reflections, perhaps with insights into patterns.                               |

**3. Core Data Model (Conceptual)**

*   **EmotionalEntry:** `id`, `timestamp`, `initialEmotion`, `intensity`, `situationDescription`, `physicalSensations`, `initialThoughts`.
*   **CompletedCircuit:** `id`, `emotionalEntryID`, `reframedEmotion`, `newPerspective`, `affirmation`, `timestamp`.
*   **ConstellationNode:** `id`, `type (e.g., emotion, insight, completed_circuit)`, `timestamp`, `associatedDataID`, `visualProperties (position, color, size)`.
*   **ConstellationConnection:** `id`, `fromNodeID`, `toNodeID`, `strength`, `type`.

**Persistence:**
*   Will use **SwiftData** for robust local storage.

---
<br>

---
**ARCHIVED DOCUMENTATION BELOW**
_The following architecture details pertain to the previous "HorizonFrame" app concept. It is preserved here for reference in case a reversion is needed. The project has pivoted to "NeuroPaths" as of 2025-05-27._
---
<br>
### Living Technical Specification
### 2025-05-27

**Session Focus: Major App Concept Pivot & Documentation Overhaul**

**Key Activities & Decisions:**
*   **Major Pivot:** Shifted the core concept of the HorizonFrame app. The new direction is an app tentatively named **NeuroPaths**, with the theme **"Neural Constellation."**
    *   **Purpose:** Guide users through a neurological reframing practice to acknowledge, neutralize, and transform emotional states by "completing an emotional circuit."
    *   **Visualization:** User progress and neural changes will be visualized as a growing, personal cosmic constellation.
*   **Documentation Overhaul (to reflect pivot while preserving old content for potential reversion):**
    *   **`Docs/UI_Theme_Exploration.md`:** Archived previous themes and added "NeuroPaths: Neural Constellation" as the primary theme, detailing its concept, color palette, iconography, and page-specific ideas.
    *   **`Docs/Roadmap.md`:** Archived the previous roadmap and created a new one for NeuroPaths, outlining initial MVP sprints (v0.1.0) focusing on core logging and basic constellation visualization, and future versions (v0.2.0, v0.3.0) for immersive features, tracking, and personalization.
    *   **`Docs/MarketingStrategy.md`:** Archived the previous strategy and developed a new one for NeuroPaths, focusing on its unique value proposition (rewiring reality, charting inner cosmos), target audience (mental wellness, neuroplasticity focus), content pillars (constellation growth, science of rewiring), and relevant hashtags.
*   **User Request:** Ensure all documentation changes allow for easy reversion to the previous "HorizonFrame" concept if this new direction is not pursued long-term. This was achieved by clearly marking new sections and archiving old content within the same documents.

**Problems or Questions (Issues):**
*   None directly related to the pivot itself. The main challenge will be the significant shift in development focus and feature set.

**What's Next (Next Steps):**
*   Begin implementation of the NeuroPaths MVP (v0.1.0) as outlined in the new roadmap, starting with Sprint 0.1.1 (Project Setup, Core Data Model, Emotion Selection UI, Guided Circuit Completion UI, Basic Data Logging).
*   Update `README.md` to reflect the new app name, concept, and high-level goals.
*   Review and update other relevant documentation (e.g., `Docs/Architecture.md`, `Docs/Decisions.md`) as the new concept solidifies.

---
# NeuroPaths Marketing Strategy (Concept: Neural Constellation)

This document outlines a preliminary marketing strategy for **NeuroPaths**, an app designed to help users rewire their brains through a guided emotional circuit completion practice, visualized as a personal "Neural Constellation." The strategy focuses on leveraging short-form video platforms like Instagram Reels and TikTok.

## 1. Target Audience

*   **Primary:** Individuals (18-45) interested in mental wellness, personal development, neuroplasticity, mindfulness, and transformative practices. Active on Instagram, TikTok, and potentially YouTube Shorts. Value visually stunning, inspiring, and scientifically-grounded (even if artistically interpreted) content.
*   **Secondary:** Therapists, coaches, and wellness practitioners looking for tools to recommend to clients. Individuals exploring alternatives or complements to traditional mindfulness apps.

## 2. Core App Messaging & Value Proposition

*   **Tagline Ideas:**
    *   "NeuroPaths: Rewire Your Reality."
    *   "NeuroPaths: Chart Your Inner Cosmos."
    *   "NeuroPaths: Complete the Circuit. Change Your Mind."
*   **Value Proposition:** NeuroPaths empowers you to consciously reshape your emotional responses and build new neural pathways. Through a simple yet profound practice, witness your inner world transform into a vibrant, evolving "Neural Constellation," reflecting your journey towards alignment and well-being.
*   **Key Themes:** Neuroplasticity, Emotional Intelligence, Personal Transformation, Mindfulness 2.0, Conscious Change, Inner Peace, Resilience, Self-Mastery, Visualizing Progress.

## 3. Content Pillars for Instagram Reels & TikTok

*   **A. "Constellation Growth & Reveals":**
    *   Visually mesmerizing videos showcasing the Neural Constellation evolving. Time-lapses of a constellation growing over days/weeks.
    *   Satisfying animations of new neural pathways forming after a user completes a circuit.
    *   Use ethereal, inspiring, or trending audio that matches the cosmic/transformative vibe.
*   **B. "The Science of Rewiring (Simplified)":**
    *   Short, engaging explanations of neuroplasticity and how the app's practice helps (e.g., "Did you know you can actually change your brain? Here's how...").
    *   Animated infographics or text overlays explaining the "complete the circuit" concept.
*   **C. "Guided Practice Snippets":**
    *   Short demos of the guided affirmation process for a specific emotion (e.g., overcoming fear, cultivating joy).
    *   Focus on the calming and empowering nature of the practice.
*   **D. "Transformative Stories" (User-Generated or Illustrative):**
    *   (Future) Share anonymized testimonials or create illustrative stories of how the practice helps individuals navigate challenges or enhance positive states.
    *   Focus on relatable scenarios and emotional breakthroughs.
*   **E. "Aesthetic App Experience":**
    *   Showcasing the beauty of the app – the glowing constellations, smooth animations, and serene UI.
    *   Set to beautiful, ambient music.
*   **F. "Meet the Mind Behind NeuroPaths" (Optional - Founder Journey):**
    *   Authentic sharing of the inspiration and vision for the app.

## 4. Key Hashtag Strategy

*   **Core App Hashtags:** #NeuroPathsApp #NeuralConstellation #RewireYourBrain #CompleteTheCircuit #ChartYourCosmos
*   **Topic-Based Hashtags:** #Neuroplasticity #MentalWellness #EmotionalIntelligence #MindfulnessPractice #PersonalGrowthJourney #Transformation #SelfHealing #Meditation #PositivePsychology #BrainHealth
*   **Platform-Specific:** #TikTokWellness #InstagramGrowth #NewApp #SciArt #DigitalArt

## 5. Call to Actions (CTAs)

*   "Begin your neural journey. Download NeuroPaths (Link in Bio)!"
*   "Ready to rewire your reality? Try NeuroPaths."
*   "Discover the power of completing the circuit with NeuroPaths."
*   "Join a community shaping their inner worlds. #NeuroPathsApp"

## 6. Potential Influencer Collaboration Ideas

*   Partner with influencers in: mental health, neuroscience communication, mindfulness, personal development, spiritual growth, and even art/design (for the aesthetic appeal).
*   Seek creators who can authentically explain or demonstrate the practice and its benefits.
*   Collaborate on content that showcases the visual beauty of the app.

## 7. Metrics for Success

*   App Store Downloads & Conversion Rates (from views to installs).
*   Daily Active Users (DAU) & Monthly Active Users (MAU).
*   Session Length & Frequency of Use (engagement with the core practice).
*   Social Media Engagement & Reach.
*   User Reviews & Ratings.
