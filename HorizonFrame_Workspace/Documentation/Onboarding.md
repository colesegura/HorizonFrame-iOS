# HorizonFrame iOS: New Contributor Onboarding

Welcome to the HorizonFrame iOS project! This guide will walk you through setting up your development environment and making your first contribution.

## Getting Started: Local Build Instructions

| Step | Action                                                                 |
| :--- | :--------------------------------------------------------------------- |
| 1    | **Clone the Repository:**
|      |    - **Using Command Line:** `git clone https://github.com/YourUsername/HorizonFrame-iOS.git` (replace `YourUsername` with the appropriate GitHub organization or your username if it's a fork).
|      |    - **Using GitHub Desktop:** Go to `File > Clone Repository` and select the HorizonFrame-iOS repository.
| 2    | **Open the Project in Xcode:**
|      |    - **Using Command Line:** Navigate to the cloned project directory (e.g., `cd HorizonFrame-iOS`) and then open the Xcode project: `open Horizon-Frame.xcodeproj`.
|      |    - **Using Finder/GitHub Desktop:** Locate the cloned `HorizonFrame-iOS` folder. Inside, find and double-click `Horizon-Frame.xcodeproj` to open it in Xcode.
| 3    | **Select the Scheme:** In Xcode's toolbar (usually at the top, next to the play/stop buttons), ensure the selected **Scheme** is `Horizon-Frame`.
| 4    | **Run the App:**
|      |    - Choose an iOS 18.0 (or newer) simulator (e.g., "iPhone 15 Pro") or a connected physical iOS device from the device list next to the scheme.
|      |    - Press the "Run" button (the play icon) or use the shortcut `⌘R`.
| 5    | **Permissions:** On the first launch, the app will request permission to send notifications. Please accept this, as it's a core feature for the Insight Bank reminders.

## Minimum Requirements

*   **Xcode:** Version 16.2 or newer
*   **iOS SDK:** iOS 18.0 Software Development Kit or newer
*   **macOS:** A version compatible with the required Xcode version.

## Bundle Identifier

The unique identifier for this application is `com.colesegura.HorizonFrame`.

## Next Steps

Once you have the project running:

1.  Familiarize yourself with our **[Development Workflow Guide](WorkflowGuide.md)** to understand our day-to-day processes.
2.  Check `Docs/DailyBriefing.md` for current tasks or `Docs/Roadmap.md` for longer-term goals.

Happy coding!