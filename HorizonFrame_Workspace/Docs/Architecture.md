### Living technical spec

# HorizonFrame Architecture (spec v0.1)

_Last updated 2025-05-24

---

## 1. Bird’s-eye Diagram
```

┌─────────────────────────────── App Layer (SwiftUI) ────────────────────────────────┐

│  TopTabBar   AlignView   CollectView   ProgressView   SettingsView                │

│                                                                               ▼   │

│                            ViewModels (Combine @Published)                        │

│           AlignVM          CollectVM            SettingsVM                         │

└─────────────────────────────────────────────▲──────────────────────────────────────┘

│

———————————————––

|            Shared Services Layer             |

|–––––––––––––––––––––––|

|  • AppData (in-memory + UserDefaults cache)  |

|  • NotificationService (UserNotifications)   |

|  • Persistence protocol (future SwiftData)   |

———————————————––

│

┌─────────────────────────────┴─────────────────────────────┐

│                   System Frameworks                       │

│   Foundation · Combine · SwiftUI · UserNotifications      │

└───────────────────────────────────────────────────────────┘

````
---

## 2. Key Modules & Responsibilities

| Module / Class          | Directory                                  | Responsibility                                                                                                                          |
| ----------------------- | ------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------- |
| **AppData**             | `ViewModels/AppData.swift`                 | Stores `personalCode:[String]` & `insights:[Insight]`, syncs with `UserDefaults`; schedules notifications when insights change.         |
| **NotificationService** | `Services/NotificationService.swift`       | One-shot wrapper around `UNUserNotificationCenter`. Requests permission on first launch; schedules N evenly-spaced daily notifications. |
| **TabRouter**           | `ViewModels/TabRouter.swift`               | Simple state object controlling which top tab is active using `@Published current: Tab`.                                                |
| **AlignView**           | `Views/Align/AlignView.swift`              | Morning flow: iterates through `personalCode`, animates color change & progress button.                                                 |
|                         |                                            |  • AlignEditSheet _(new view)_ – modal sheet triggered by the tools-menu button in AlignView to edit personalCode.                      |
| **CollectView**         | `Views/Collect/CollectView.swift`          | CRUD for `personalCode` lines and `Insight` entries; pushes new tasks to Todoist via Obsidian plugin (out-of-app).                      |
| **OnboardingOverlay**   | `Views/Components/OnboardingOverlay.swift` | Translucent walkthrough overlay shown once per feature, state stored in `UserDefaults`.                                                 |

---

## 3. Data Model (current)

```swift
struct Insight: Identifiable, Codable, Hashable {
    var id = UUID()
    var text: String
    var created = Date()
}
````

Persistence path:

```
UserDefaults
├─ personalCodeKey → Data (JSON-encoded [String])
└─ insightsKey     → Data (JSON-encoded [Insight])
```

### **Future → SwiftData**
_Decision 2025-05-29:_ adopt **SwiftData** once iOS 18 APIs are stable.
Rationale: schema evolution + CloudKit sync for multi-device.

---

## **4. Navigation & Routing**

- Single ContentView hosts TopTabBar (custom, not TabView).
- View selection via switch router.current – keeps memory small and avoids heavy TabView instantiation.
- Future deep-link plan: use URL navigation (SwiftUI .onOpenURL) mapping /align, /collect, etc., plus @Environment(\.router) injection.
---

## **5. Framework / Library Decisions**

|**Concern**|**Decision**|**Alternatives considered**|
|---|---|---|
|UI toolkit|**SwiftUI** (iOS 18)|UIKit (rejected: slower iteration)|
|Local storage|UserDefaults wrapper (MVP) → **SwiftData** roadmap|Core Data, Realm|
|Notification scheduling|UserNotifications|Background refresh tasks (overkill)|
|State management|**Combine** + @Observable (when we bump toolchain)|Redux-style (overhead)|
|Testing|XCTest (unit)|Quick/Nimble later|
|Documentation Management|**Obsidian** with local vault (`HorizonFrame_Workspace`)|Direct GitHub repo sync for notes (previously considered/used)|

---

## **6. Build & CI**
- **Xcode 16.2** minimum.
- DEVELOPMENT_ASSET_PATHS cleared to avoid path warnings after folder changes.
- CI TBD (GitHub Actions runner once unit tests added).
---
## **7. Open Technical Todos**

1. Replace UserDefaults with SwiftData & migrate existing JSON blobs.
2. Add analytics wrapper (Firebase? custom).
3. Implement “Progress” graphs using Swift Charts.
4. Write UI tests for Align flow (Iterate → button enabled).
5. Accessibility audit (VoiceOver friendly color contrast).
---
## **8. Contributing Workflow (tech)**
1. **Feature branch** off main.
2. Write code + **update this doc** if architecture shifts.
3. Run ⌘U tests.
4. PR → squash merge.

---

_Keep this file alive:_ whenever you introduce a new service, refactor a module, or adopt a library, add a bullet or edit the tables. In six months this doc will be the fastest way for any LLM or junior dev to “load the entire mental model” of HorizonFrame in minutes.

---

### How to iterate

1. **Paste** each block into its new file.  
2. Commit: `docs: add initial README & Architecture spec v0.1`.  
3. As soon as you change a folder, class name, or tech choice, open `Docs/Architecture.md`, tweak the relevant line, and commit alongside the code change.  
4. Update the **Current Status** line in README whenever you finish a milestone or start a new one.
