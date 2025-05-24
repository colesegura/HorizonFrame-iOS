### Living Technical Specification

# HorizonFrame Architecture (Version 0.1)

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
2.  Write your code. If your changes affect the app's architecture, **update this document**.
3.  Run tests using `⌘U` in Xcode.
4.  Submit a Pull Request (PR) on GitHub. Your PR should be "squash merged" (combining all your commits into one) once approved.

---

_Keep this document up-to-date:_ Whenever you introduce a new service, change how a module works, or add a new library, please update the relevant sections here. This document will help new team members (and AI assistants!) quickly understand how HorizonFrame is built.

---

### How to Iterate on This Document

1.  When starting a new major component, you might copy relevant sections from here as a starting point for more detailed design documents.
2.  Commit any changes to this document: `docs: update architecture for [your feature/change]`.
3.  If you change a folder structure, class name, or technology choice, open `Docs/Architecture.md`, adjust the relevant line(s), and commit this change along with your code changes.
4.  Update the **Current Status** line in the main `README.md` file whenever you complete a major milestone or start a new one.
