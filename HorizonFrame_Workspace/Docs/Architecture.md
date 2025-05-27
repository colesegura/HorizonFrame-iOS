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

# ARCHIVED: HorizonFrame Architecture (Version 0.1 - Pre-NeuroPaths Pivot)

_Last updated: 2025-05-24_

---

## 1. High-Level Diagram

This diagram shows the main parts of the application and how they connect.

```
┌─────────────────────────────── App Layer (SwiftUI) ────────────────────────────────┐
│  TopTabBar   AlignView   CollectView   ProgressView   SettingsView                  │
│                                           ▼                                         │
│                     ViewModels (Manage Data for Views)                              │
│         AlignVM         CollectVM         SettingsVM                                │
└─────────────────────────────────────────────▲──────────────────────────────────────┘
                                              │
                                ———————————————––
                                |    Shared Services Layer    |
                                |–––––––––––––––––––––––|
                                | • AppData (Stores app data temporarily and saves some to disk) |
                                | • NotificationService (Handles app notifications) |
                                | • Persistence protocol (Defines how data will be saved permanently - future SwiftData) |
                                ———————————————––
                                              │
┌─────────────────────────────┴─────────────────────────────┐
│                             System Frameworks                                     │
│   Foundation · Combine · SwiftUI · UserNotifications (Core Apple technologies)    │
└───────────────────────────────────────────────────────────┘
```

---

## 2. Key Modules and Their Responsibilities

This table describes the main code components (modules or classes) and what they do. The "Directory" shows where to find these files within the `HorizonFrame_Workspace/Horizon-Frame/` folder.

| Module / Class          | Directory                                  | Responsibility                                                                                                                               |
| :---------------------- | :----------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------- |
| **AppData**             | `ViewModels/AppData.swift`                 | Stores the user's `personalCode` (list of strings) and `insights` (list of Insight objects). It syncs this data with `UserDefaults` (a simple way to store small amounts of data on the device) and schedules notifications when insights change. |
| **NotificationService** | `Services/NotificationService.swift`       | A straightforward helper for using `UNUserNotificationCenter` (Apple's system for notifications). It asks for permission when the app first launches and schedules a set number of daily notifications, spaced out evenly. |
| **TabRouter**           | `ViewModels/TabRouter.swift`               | A simple object that keeps track of which main tab is currently active in the app. It uses `@Published current: Tab` to announce changes.        |
| **AlignView**           | `Views/Align/AlignView.swift`              | Manages the morning reflection flow. It goes through the `personalCode` items, shows color changes, and handles the progress button.           |
|                         |                                            |  • `AlignEditSheet` (a new view) – A pop-up screen (modal sheet) started from a menu button in `AlignView` that lets the user edit their `personalCode`. |
| **CollectView**         | `Views/Collect/CollectView.swift`          | Allows users to create, read, update, and delete `personalCode` lines and `Insight` entries. It can also send new tasks to Todoist through an Obsidian plugin (this happens outside the app). |
| **OnboardingOverlay**   | `Views/Components/OnboardingOverlay.swift` | A semi-transparent guide that appears once for each new feature to help users understand it. Information about whether it has been shown is stored in `UserDefaults`. |

---

## 3. Current Data Model

This is how we currently structure the `Insight` data.

```swift
// An Insight object stores a piece of text, like a quote or a personal note.
struct Insight: Identifiable, Codable, Hashable {
    var id = UUID() // A unique identifier for each insight
    var text: String // The actual text content of the insight
    var created = Date() // The date when the insight was created
}
```

**How Data is Saved (Persistence Path):**

Currently, data is saved using `UserDefaults` in a simple format:
```
UserDefaults
├─ personalCodeKey → Data (JSON-encoded list of Strings)
└─ insightsKey     → Data (JSON-encoded list of Insight objects)
```
(JSON is a common text-based format for representing data.)

### **Future Plan: SwiftData**
_Decision (2025-05-29):_ We plan to adopt **SwiftData** (Apple's newer data storage framework) once the iOS 18 tools are finalized.
Reasoning: SwiftData will make it easier to change our data structure over time and potentially sync data across multiple devices using CloudKit.

---

## **4. Navigation and Routing (How Users Move Through the App)**

*   A single `ContentView` holds the `TopTabBar` (our custom tab bar, not Apple's default `TabView`).
*   Which view is shown is decided by `router.current`. This approach helps keep the app's memory usage low by not loading all views at once, which `TabView` might do.
*   **Future Plan for Deep Links:** We plan to allow users to open specific parts of the app using URLs (e.g., `yourapp://align`). This will use SwiftUI's `.onOpenURL` feature.

---

## **5. Framework and Library Decisions (Tools We Use)**

| Concern (What we need it for) | Decision (What we chose)                                  | Alternatives Considered                                     |
| :---------------------------- | :-------------------------------------------------------- | :---------------------------------------------------------- |
| UI Toolkit (Building the user interface) | **SwiftUI** (for iOS 18 and newer)                        | UIKit (Older Apple framework; SwiftUI allows for faster development) |
| Local Storage (Saving data on the device) | `UserDefaults` wrapper (for now) → **SwiftData** (planned) | Core Data, Realm (Other data storage options)             |
| Notification Scheduling       | `UserNotifications` (Apple's built-in system)             | Background refresh tasks (More complex than needed)         |
| State Management (Managing data flow in the app) | **Combine** + `@Observable` (when we update our tools) | Redux-style architecture (More complex for our current needs) |
| Testing                       | XCTest (Apple's testing framework)                        | Quick/Nimble (Other testing tools we might use later)       |
| Documentation Management      | **Obsidian** with a local vault (`HorizonFrame_Workspace`) | Direct GitHub repository sync for notes (previously used/considered) |

---

## **6. Build and Continuous Integration (CI)**
*   **Xcode Version:** Requires Xcode 16.2 or newer.
*   `DEVELOPMENT_ASSET_PATHS` setting was cleared to prevent warnings after project folder changes.
*   **Continuous Integration (CI):** To be determined. We plan to use GitHub Actions once we have unit tests. (CI is a process to automatically build and test the app whenever code changes are made).

---

## **7. Open Technical Tasks (Things We Still Need To Do)**

1.  Replace `UserDefaults` with **SwiftData** and move existing data to the new system.
2.  Add an analytics tool (e.g., Firebase, or a custom solution) to understand app usage.
3.  Implement "Progress" graphs using Swift Charts.
4.  Write UI tests for the "Align" feature (specifically, checking if the "Iterate" button enables correctly).
5.  Perform an accessibility audit (e.g., check color contrast for VoiceOver users).

---

## **8. Technical Contributing Workflow (How Developers Add Code)**
1.  Create a **feature branch** from the `main` branch for your work.
3.  Run tests using `⌘U` in Xcode.
4.  Submit a Pull Request (PR) on GitHub. Your PR should be "squash merged" (combining all your commits into one) once approved.

---

_Keep this document up-to-date:_ Whenever you introduce a new service, change how a module works, or add a new library, please update the relevant sections here. *(This document will evolve as the project grows.)*

## Core UI Animations

### Kinetic Frames Launch Animation

This animation is envisioned as the initial visual experience when the app launches, directly tying into the "HorizonFrame" branding.

**Concept:**

A series of 4-5 concentric, hollow square frames animate into place on a black background. Each frame is composed of four L-shaped white corner brackets, giving the appearance of a square with the middle section of each side missing. The frames slide in from off-screen (or scale/fade in) to create a satisfying "tunnel forming" or "framing" effect.

**Implementation Approach (SwiftUI):**

1.  **Frame Bracket View (`FrameCornerView.swift` - Suggestion):**
    *   Create a reusable SwiftUI `View` that draws a single L-shaped corner bracket.
    *   This could be done using a `Path` or by combining two `Rectangle` views.
    *   Parameters: `size` (for the length of the arms), `lineWidth`, `color`.

2.  **Single Kinetic Frame View (`KineticFrameView.swift` - Suggestion):**
    *   This view will compose one complete frame from four `FrameCornerView` instances.
    *   Parameters: `frameSize` (overall size of the square), `cornerSize` (size of the L-bracket arms), `lineWidth`, `color`.
    *   Use a `ZStack` or absolute positioning to place the four corners correctly.
    *   Add state variables for animation properties: `offset`, `scale`, `opacity`.

3.  **Launch Animation Container View (`KineticFramesLaunchView.swift`):**
    *   This view will manage and animate multiple `KineticFrameView` instances.
    *   Use a `ZStack` to layer the frames.
    *   Create an array of structs/objects to define the properties of each frame (e.g., final size, animation delay, initial off-screen position).
    *   **Animation Trigger:** Use `.onAppear` to trigger the animations.
    *   **Animation Logic:**
        *   For each `KineticFrameView`:
            *   **Initial State:** Positioned off-screen (e.g., `offset(x: -geometry.size.width)`) or scaled down (`scaleEffect(0.1)`) and transparent (`opacity(0)`).
            *   **Animation:** Use `withAnimation` to animate changes to `offset`, `scale`, and `opacity`.
            *   Apply different `delay()` modifiers to each frame to stagger their entrance.
            *   Use `easeInOut` or a custom spring animation for a smooth, satisfying feel.
        *   Example for one frame sliding from left:
            ```swift
            @State private var frameOffset: CGSize = CGSize(width: -UIScreen.main.bounds.width, height: 0)
            // ...
            KineticFrameView(...)
                .offset(frameOffset)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
                        frameOffset = .zero
                    }
                }
            ```
    *   **Completion:** After the animation completes, this view could transition to the main app content.

**Key SwiftUI Concepts:**

*   `@State` variables to drive animations.
*   `ZStack` for layering.
*   `.offset()`, `.scaleEffect()`, `.opacity()` modifiers.
*   `withAnimation { ... }` block.
*   `.delay()` animation modifier.
*   `Path` for custom shapes (for the L-brackets).
*   `GeometryReader` if precise positioning relative to screen size is needed for initial off-screen placement.

**Considerations:**

*   **Performance:** For a small number of frames (4-5), performance should be good. If many more were added, consider drawing optimizations.
*   **Customization:** The animation can be varied by changing initial positions (e.g., corners slide in diagonally, frames scale up from the center), durations, and delays.
*   **Haptics:** Consider adding subtle haptic feedback as frames "lock" into place.

---

### How to Iterate on This Document

1.  When starting a new major component, you might copy relevant sections from here as a starting point for more detailed design documents.
2.  Commit any changes to this document: `docs: update architecture for [your feature/change]`.
3.  If you change a folder structure, class name, or technology choice, open `Docs/Architecture.md`, adjust the relevant line(s), and commit this change along with your code changes.
4.  Update the **Current Status** line in the main `README.md` file whenever you complete a major milestone or start a new one.
