# Development Practices

## Versioning Convention

This project adheres to Semantic Versioning (SemVer) using the `MAJOR.MINOR.PATCH` format:

*   **`MAJOR` (e.g., 1.0.0 → 2.0.0):** For incompatible API changes or very significant new features, architectural reworks, or paradigm shifts.
*   **`MINOR` (e.g., 0.1.0 → 0.2.0):** For adding new functionality in a backward-compatible manner. This includes new features, significant enhancements to existing features, or new screens/modules.
*   **`PATCH` (e.g., 0.1.0 → 0.1.1):** For backward-compatible bug fixes, minor UI tweaks, performance improvements, or documentation updates that don't add new features.

### Version History (Conceptual)

*   **0.1.0:** Initial MVP release.
*   **0.1.1 (Current Target):** UI refinements (Settings page backgrounds, forced dark mode).
*   **0.2.0 (Next Major Feature Set):** Alignment streak, enhanced Progress Tab, full Personal Code editing on Align page, Collect page UI parity with Align page, drag/copy between Personal Code and Insights, customizable notifications.

Subsequent versions will follow this pattern.

# HorizonFrame iOS - Code Style Guide

_This document is under active development. Its purpose is to define coding standards, naming conventions, and best practices for the HorizonFrame iOS project to ensure consistency and maintainability._

## Table of Contents

- [General Principles](#general-principles)
- [Naming Conventions](#naming-conventions)
  - [SwiftUI Views](#swiftui-views)
  - [ViewModels](#viewmodels)
  - [Models](#models)
  - [Services](#services)
  - [Functions & Methods](#functions--methods)
  - [Variables & Constants](#variables--constants)
- [Code Formatting](#code-formatting)
  - [Indentation](#indentation)
  - [Line Length](#line-length)
  - [Braces](#braces)
- [SwiftUI Specifics](#swiftui-specifics)
  - [View Composition](#view-composition)
  - [State Management](#state-management)
- [Comments & Documentation](#comments--documentation)
- [Error Handling](#error-handling)
- [Git Commit Messages](#git-commit-messages)

## General Principles

- **Clarity over Brevity:** Code should be easy to read and understand.
- **Consistency:** Adhere to the established styles and patterns within the project.
- **Simplicity (KISS):** Keep solutions as simple as possible.
- **DRY (Don't Repeat Yourself):** Avoid redundant code.

## Naming Conventions

*(Specific conventions will be detailed here.)*

### SwiftUI Views

- Suffix with `View` (e.g., `UserProfileView`).

### ViewModels

- Suffix with `ViewModel` (e.g., `UserProfileViewModel`).

### Models

- Use clear, descriptive nouns (e.g., `User`, `PersonalCodeItem`).

## Code Formatting

*(Details on formatting preferences will be added here. We may adopt a tool like SwiftLint in the future.)*

## Comments & Documentation

- Document public APIs and complex logic.
- Use Swift's documentation comment syntax (`///`).

## Git Commit Messages

- Follow conventional commit formats (e.g., `feat: ...`, `fix: ...`, `docs: ...`).

---

*This guide will be expanded collaboratively as the project evolves.*
