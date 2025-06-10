# HorizonFrame iOS App

Welcome to HorizonFrame, an iOS application designed to help users maintain and reflect on their personal code, beliefs, and insights through daily alignment practices.

## Core Purpose

HorizonFrame aims to provide a serene and focused space for users to:
*   Define and engage with their core "Alignments" (chosen passages, affirmations, personal code).
*   Capture and reflect on "Insights" related to their alignments and personal growth.
*   Build a consistent daily practice of mindfulness and self-reflection.

## Quick Start: Running the App

For detailed instructions on setting up your development environment and running the app for the first time, please see our **[New Contributor Onboarding Guide](Documentation/Onboarding.md)**.

**Minimum Requirements:**
*   **Xcode:** Version 16.2 or newer
*   **iOS SDK:** iOS 18.0 Software Development Kit or newer
*   **macOS:** A version compatible with the required Xcode version.

The bundle identifier is `com.colesegura.HorizonFrame`.

## Technology Stack

*   **Language:** Swift
*   **UI Framework:** SwiftUI
*   **Persistence:** Core Data (for local storage), @AppStorage (for simple preferences)
*   **Concurrency:** Swift Concurrency (async/await)
*   **Version Control:** Git, GitHub

## Repository Structure (Simplified)

```
HorizonFrame-iOS/
├── Horizon-Frame.xcodeproj       # Xcode Project File
├── Horizon-Frame/                # Main Application Target
│   ├── HorizonFrameApp.swift     # App Entry Point
│   ├── Assets.xcassets         # App Assets (Icons, Colors)
│   ├── CoreData/               # Core Data Model and Helpers
│   ├── Models/                 # Data Models
│   ├── Views/                  # SwiftUI Views
│   │   ├── Onboarding/
│   │   ├── Align/
│   │   ├── Collect/
│   │   ├── Explore/
│   │   ├── Progress/
│   │   └── Settings/
│   ├── ViewModels/             # ViewModels (if applicable)
│   └── Services/               # Services (e.g., NotificationService)
├── HorizonFrameTests/            # Unit Tests
├── HorizonFrameUITests/          # UI Tests
├── HorizonFrameWidgets/          # Widget Extension (currently disabled)
├── Documentation/                # Project Documentation (see below)
│   ├── WorkflowGuide.md
│   ├── DailyBriefing.md
│   ├── Roadmap.md
│   ├── DevLog.md
│   ├── Architecture.md
│   ├── Onboarding.md           # Contributor Onboarding
│   └── MetaPrompts/
│       ├── DailyStart_LLMPrompt.md
│       └── DailyFinish_LLMPrompt.md
├── Specs/                      # Feature Specifications
│   └── Onboarding.md           # User Onboarding Feature Spec
└── README.md                   # This file
```

## Development Workflow & Contribution

We follow a structured development workflow to ensure clarity and collaboration. Please familiarize yourself with our **[Development Workflow Guide](Documentation/WorkflowGuide.md)**. This guide explains our core documents, daily procedures, and documentation standards.

For new contributors, the **[New Contributor Onboarding Guide](Documentation/Onboarding.md)** provides essential setup information.

## Getting Involved

1.  Review the `Documentation/Roadmap.md` for planned features and `Documentation/DailyBriefing.md` for current tasks.
2.  Follow the process outlined in the `Documentation/WorkflowGuide.md`.

We look forward to your contributions!
