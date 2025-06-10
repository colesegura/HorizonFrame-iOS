# HorizonFrame Architecture (Version 0.1)

_Last updated: 2025-06-05_

---

## 1. High-Level Diagram

This diagram shows the main parts of the application and how they connect.

```
┌────────────────────────────────── App Layer (SwiftUI) ───────────────────────────────────┐
│ KineticFramesLaunchView                                                                │
│  ├─ AnimatedGradientBackground (Global, very dark, slow-moving gradient)                │
│  └─ MainAppView                                                                        │
│     ├─ Current Tab's View (e.g., AlignView, CollectView, ExploreView, SettingsView)     │
│     └─ CustomTabBarView (Animated, text-only, expanding/collapsing frame)               │
│                                            ▼                                          │
│       (Views use ViewModels, @State, @AppStorage. AppTab enum defines tabs.)            │
└─────────────────────────────────────────────▲───────────────────────────────────────────┘
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
| **AppData**             | `ViewModels/AppData.swift`                 | Stores the user's `personalCode` (list of strings) and `insights` (list of Insight objects). It syncs this data with `UserDefaults` (a simple way to store small amounts of data on the device) and schedules notifications when insights change. (Note: Current views use local @State or @AppStorage primarily) |
| **NotificationService** | `Services/NotificationService.swift`       | A straightforward helper for using `UNUserNotificationCenter` (Apple's system for notifications). It asks for permission when the app first launches and schedules a set number of daily notifications, spaced out evenly. |
| **MainAppView**         | `Views/MainAppView.swift`                  | Hosts the `CustomTabBarView` and the content view for the currently selected tab. Manages the overall structure for the main application interface post-onboarding. |
| **CustomTabBarView**    | `Views/CustomTabBarView.swift`             | A custom animated tab bar that expands to show all tab options (text-only) and collapses to show only the selected tab's text, framed. Handles tab selection and navigation. |
| **AppTab**              | `Models/AppTab.swift`                      | Enum defining the application's main tabs (Align, Collect, Explore, Settings), including their titles and associated views. |
| **AnimatedGradientBackground** | `Views/AnimatedGradientBackground.swift` | Provides a global, very dark, slowly moving animated gradient background for the entire application, contributing to the immersive UI. |
| **FramedContentWrapper**| `Views/FramedContentWrapper.swift`         | A helper view that draws kinetic-style frame corners around its content. Used by `CustomTabBarView` for the selected tab item. |
| **AlignView**           | `Views/Align/AlignView.swift` (Tentative)  | Provides an alignment session interface. Users can start a session to view a series of alignment statements. Includes a simple progress indicator. Placeholder for timer/gesture controls and streak updates. |
| **CollectView**         | `Views/Collect/CollectView.swift` (Tentative)| Allows users to manage 'Personal Code' and 'Insights' via a segmented picker and lists. Includes placeholders for adding, editing, and deleting items. |
| **ExploreView**         | `Views/Explore/ExploreView.swift` (Tentative)| Displays curated and user-generated alignment content in scrollable sections (e.g., 'For You', 'Trending'). Items are presented as cards with context menus for actions. |
| **ProgressViewPage**    | `Views/Progress/ProgressViewPage.swift` (Tentative)| Shows user's alignment streak, a placeholder for a calendar view of completed dates, and summary stat cards for daily, weekly, and monthly progress. |
| **SettingsView**        | `Views/Settings/SettingsView.swift` (Tentative)| Provides options for managing alignment reminders (enable, time, daily goal), data management (export, clear), appearance (theme), and an 'About' section. |
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

*   The main application interface after onboarding is `KineticFramesLaunchView.swift`, which sets up the `AnimatedGradientBackground` and then presents `MainAppView.swift`.
*   `MainAppView.swift` contains the `CustomTabBarView` at the bottom and a content area that displays the view corresponding to the selected tab (Align, Collect, Explore, Settings), as defined in the `AppTab` enum.
*   The `CustomTabBarView` provides an animated, expanding/collapsing interface for tab selection, showing only text labels and a kinetic frame around the selected item.
*   Navigation within each tab's content view (e.g., `AlignView`) is typically handled by a `NavigationView` or `NavigationStack` embedded within that specific view.
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
    *   **Completion:** After the animation completes, this view transitions to `MainAppView`, which is displayed on top of the `AnimatedGradientBackground`.

### Animated Gradient Background

Integrated within `KineticFramesLaunchView` as the base layer for the entire application and also used directly by `CustomTabBarView` if its explicit background is made transparent:
*   **`AnimatedGradientBackground.swift`**:
    *   Provides a full-screen, very dark (near black), slowly moving linear gradient.
    *   Uses a `Timer` to cycle through an array of `Color` arrays, animating the gradient stops.
    *   Designed to be subtle and create an immersive, dynamic backdrop.
    *   Applied with `.edgesIgnoringSafeArea(.all)` in `KineticFramesLaunchView` to ensure it covers the entire screen, including under status and navigation bars.

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
- [ ] Update bundle identifiers, display names, etc.
