# HorizonFrame GitHub Collaboration Workflow

This document outlines the standard Git and GitHub workflow for the HorizonFrame project. Adhering to this protocol ensures code stability, clear history, and effective collaboration.

## Core Principles

1.  **`main` Branch is Sacred:** The `main` branch must always represent a stable, working, and potentially shippable version of the application. No direct commits are allowed to `main`.
2.  **Feature Branches for All Work:** All development, including new features, bug fixes, and refactoring, must occur on separate feature branches.
3.  **Pull Requests (PRs) for Review:** All changes destined for `main` must be submitted via a Pull Request, reviewed, and then merged.

## Daily Quick-Start Checklist (GitHub Desktop)

> Run this 30-second routine every time you sit down to code so you and your teammate stay in sync.
>
> 1. **Quit Xcode** if it is open (protects `.xcodeproj` from merge conflicts).
> 2. In **GitHub Desktop**, verify the branch dropdown shows **main**, then pull the latest code:
>    • Toolbar **Pull origin** button  
>    • OR menu **Repository ▸ Pull**  (⌘⇧P)  
>    (If the button says **Fetch origin** first, click that, then Pull.)
> 3. **Branch ▸ New Branch…** → create `feature/<short-description>` off `main` and **Checkout**.
> 4. Code in Xcode. Build.
> 5. **Commit** frequently (bottom-left Summary field → *Commit to <branch>*).
> 6. **Push** (top-right *Push origin*) after each commit or at logical milestones.
> 7. When the feature is ready → *Create Pull Request* (banner in GitHub Desktop).
> 8. On GitHub: **Squash & Merge** the PR.
> 9. Back in GitHub Desktop: switch to `main` → **Pull origin**.
> 10. Optionally delete the finished branch (both local & remote).

---

## Critical Note: Handling Xcode Project File (`.xcodeproj`) Conflicts

**This is the most common and frustrating source of project-breaking issues in a collaborative Xcode project.** The `Horizon-Frame.xcodeproj` file (specifically, the `project.pbxproj` file within it) is a complex database that tracks all files, targets, and build settings. Git has no special understanding of this file and can easily corrupt it during a merge or rebase, leading to a cascade of errors.

**Golden Rule:** If you anticipate a merge will change the `.xcodeproj` file (e.g., files were added/removed), **quit Xcode completely *before* running `git pull`, `git merge`, or `git rebase`.** Reopen it only after the Git operation is complete.

### Recovery from a Corrupted Project File

If the project suddenly fails to build after a Git operation, with errors like "Cannot find file...", missing schemes, or incorrect target memberships, your `.xcodeproj` file is likely corrupted. Follow these steps methodically:

1.  **Problem: No Active Scheme / Play Button Disabled**
    *   **Symptom:** The scheme selector next to the play button says "No Scheme" or is missing entirely. The play button has a strikethrough.
    *   **Fix:** In the top menu bar, go to **Product > Scheme > Manage Schemes...** and click **"Autocreate Schemes Now"**.

2.  **Problem: Files Not Belonging to Main App Target**
    *   **Symptom:** Build fails with many errors. Clicking on a `.swift` file shows its "Target Membership" in the File Inspector (right-hand panel) is unchecked for `Horizon-Frame`.
    *   **Fix:** In the Project Navigator (left sidebar), select all your source code files (`Cmd+A`). In the File Inspector's "Target Membership" section, **check the box for `Horizon-Frame`**.

3.  **Problem: `Info.plist` Cannot Be Found**
    *   **Symptom:** Build error: `Build input file cannot be found: .../Info.plist`.
    *   **Fix:** 
        1.  Go to Project Settings (top item in navigator) > `Horizon-Frame` Target > **Build Settings** tab.
        2.  Search for **`Info.plist File`**.
        3.  The path is likely incorrect. Double-click to edit it and set it to the correct path: **`Horizon-Frame/Resources/Info.plist`**.

4.  **Save Your Work:** Once the project builds successfully again, **immediately commit the changes** to the `.xcodeproj` file to save the repaired state.

---

## Detailed Workflow Steps

1.  **Start a New Task/Feature:**
    *   **Ensure `main` is Up-to-Date Locally:**
        ```bash
        git checkout main
        git pull origin main
        ```
    *   **Create a Descriptive Feature Branch:** Branch off from `main`. Use a consistent naming convention (e.g., `feature/short-description`, `bugfix/issue-summary`, `ui/component-update`).
        ```bash
        git checkout -b <branch-type>/<your-branch-name>
        # Example: git checkout -b feature/user-profile-editing
        ```

2.  **Develop on Your Feature Branch:**
    *   Make your code changes, add new files, etc.
    *   **Commit Frequently:** Make small, logical commits with clear and concise messages. This makes reviews easier and helps if you need to revert a specific change.
        ```bash
        git add .
        git commit -m "Feat: Add initial structure for user profile form"
        ```

3.  **Keep Your Branch Synchronized (Optional but Recommended for Long-Lived Branches):**
    *   Periodically update your feature branch with the latest changes from `main` to avoid large merge conflicts later.

    **GitHub Desktop:**  Repository ▸ **Fetch origin**  → Branch ▸ **Rebase current branch onto main…**  (or **Merge into current branch…** for a merge commit)

    **CLI:**
    ```bash
    git fetch origin
    git rebase origin/main   # Preferred for a cleaner history
    # OR
    # git merge origin/main  # Simpler, creates a merge commit
    ```
    *   Resolve any conflicts locally before pushing.

4.  **Push Your Feature Branch to Remote:**
    *   Regularly push your local feature branch to the remote repository. This backs up your work and makes it visible for collaboration.

    **GitHub Desktop:** click the blue **Push origin** button (top-right).

    **CLI:**
    ```bash
    git push -u origin <your-branch-name>  # First push sets tracking
    git push                              # Subsequent pushes
    ```

5.  **Create a Pull Request (PR):**
    *   When your feature is complete, tested, and ready for integration, go to the HorizonFrame repository on GitHub.
    *   GitHub will often show a prompt to "Compare & pull request" for recently pushed branches. Click this, or manually navigate to the "Pull requests" tab and click "New pull request."
    *   **Base Branch:** `main`
    *   **Compare Branch:** Your feature branch (e.g., `feature/user-profile-editing`)
    *   **Title:** Write a clear, descriptive title (e.g., "Feat: Implement User Profile Editing Functionality").
    *   **Description:** Provide a summary of the changes, the purpose of the PR, and any specific testing instructions or context for the reviewer. If it resolves an issue, link it (e.g., "Fixes #42").
    *   **Assign Reviewer(s):** Assign your teammate(s) to review the PR.

6.  **Code Review Process:**
    *   **Reviewer:** Carefully examine the changes in the "Files changed" tab. Check for correctness, style, potential bugs, and adherence to project standards. Provide feedback, ask questions, or request changes directly on the PR.
    *   **Author:** Address any feedback by making additional commits to your feature branch. The PR will update automatically. Discuss any points needing clarification.

7.  **Merge the Pull Request:**
    *   Once the PR is approved by the reviewer(s) and any automated checks (if configured) pass:
    *   The PR can be merged into `main`. Preferably, use the **"Squash and merge"** option on GitHub. This combines all commits from the feature branch into a single, clean commit on `main`, making the history easier to read. "Rebase and merge" is also a good option.
    *   **Delete the branch** after merging (GitHub provides a button for this). This keeps the repository's list of active branches clean.

8.  **Post-Merge Synchronization:**
    *   After a PR is merged into `main`, all team members should update their local `main` branch:
        ```bash
        git checkout main
        git pull origin main
        ```
    *   If you have other active feature branches, rebase them onto the newly updated `main`:
        ```bash
        git checkout <your-other-feature-branch>
        git rebase main
        ```

## Testing a Teammate's Branch (Reviewing a PR Locally)

If you need to test a teammate's branch locally before approving a PR:

1.  **Ensure Your Current Work is Saved:** Commit or stash any uncommitted changes on your current branch.
2.  **Fetch All Remote Updates:**
    ```bash
    git fetch origin
    ```
3.  **Checkout Their Branch Locally:**
    ```bash
    git checkout <teammates-branch-name>
    # Example: git checkout feature/new-login-screen
    ```
    Git will create a local copy of their branch that tracks the remote one.
4.  **Test the Code:** Run the app, perform tests, etc.
5.  **Provide Feedback:** Add your review comments to the PR on GitHub.
6.  **Switch Back to Your Work:**
    ```bash
    git checkout <your-original-branch>
    # If you stashed changes: git stash pop
    ```

By following this workflow, we maintain a high-quality codebase and a productive development environment.
