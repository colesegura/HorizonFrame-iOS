Below are **ready-to-paste first drafts** of your two key onboarding docs.

Copy each block into the appropriate file in your repo.

---

### **1.** 

### **README.md**

###  **— project overview & quick-start**

```
# HorizonFrame – iOS

> *A daily “alignment” journal that surfaces your personal code and life insights, nudging you toward intentional living.*

---

## ✨ Why HorizonFrame?

Most habit apps track what you *do*. HorizonFrame focuses on *who you want to be*.  
The app helps you:

1. **Craft a Personal Code** – short, powerful statements that capture the life you intend to live.  
2. **Reflect Daily** – a one-minute “alignment” session every morning cycles through those statements and logs completion.  
3. **Collect Insights** – drop quotes, revelations, or lessons into an “Insight Bank”; the app sends them back via spaced notifications.  
4. **Track Progress** – view your streak and mindset alignment statistics (coming soon).

---

## 🚀 Quick Start (local build)

| Step | Command / Click |
|------|-----------------|
| 1 | Clone: `git clone https://github.com/<you>/HorizonFrame-iOS.git` |
| 2 | `cd HorizonFrame-iOS && open Horizon-Frame.xcodeproj` |
| 3 | Xcode toolbar ▸ **Scheme** ➜ *Horizon-Frame* |
| 4 | Run on iOS 18+ simulator or device (`⌘R`) |
| 5 | First launch requests notification permission → accept |

> **Minimum:** Xcode 16.2 • iOS 18.0 SDK  
> **Bundle ID:** `com.colesegura.HorizonFrame`

---

## 🗺 Current Status — May 2025

- **MVP milestone 0.1** in TestFlight ✅  
- Implementing **local notifications for Insight Bank** (logic done, UX polishing)  
- Next focus → add basic “Progress” page + unit tests

*(update this section whenever the milestone shifts)*

---

## 🏗 Repo Structure (high-level)
```

HorizonFrame-iOS/

├── Horizon-Frame.xcodeproj/   – Xcode project

├── Models/                    – Plain Swift data structs

├── ViewModels/                – ObservableObjects (MVVM)

├── Views/                     – SwiftUI files (sub-folders per feature)

├── Services/                  – NotificationService, persistence wrappers

├── Docs/                      – Architecture.md, DevLog.md, TASKS.md, …

└── README.md                  – you are here

```
A detailed breakdown of layers, classes, and future modules lives in **Docs/Architecture.md**.

---

## 🧩 Main Dependencies

| Framework         | Purpose                         |
|-------------------|---------------------------------|
| **SwiftUI**       | Declarative UI (iOS 18)         |
| **Combine**       | State & publisher bridges       |
| **UserNotifications** | Local daily Insight pings      |
| **SwiftData** *(road-map)* | Replace UserDefaults for persistence |

No third-party packages yet – pure Apple stack for easier onboarding.  
We use **Swift Package Manager** (SPM) for future libs.

---

## 🛠 Contributing (internal)

1. Read `Docs/Onboarding.md` (20-min setup guide).  
2. Pick the top open card in **Todoist ▸ Current Sprint**, self-assign.  
3. Commit often (`feat: …`, `fix: …`, `docs: …`).  
4. Append a bullet to `Docs/DevLog.md` under today’s date.  
5. Open a PR → another dev (or the LLM) reviews, squash-merge.

Style guide & branch naming rules live in `Docs/CodeStyle.md`.

---

## 📄 License

_Proprietary © Cole Segura 2025 – contact for permitted uses._
```

  

---

