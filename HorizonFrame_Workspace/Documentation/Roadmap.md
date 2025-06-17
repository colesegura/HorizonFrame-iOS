# HorizonFrame Project Roadmap

This document outlines planned features and improvements for the HorizonFrame application. It is a living document and will be updated as priorities evolve. The app's core purpose is to help users maintain and reflect on their personal code and insights.

## Version 0.1.0: Core Feature Implementation

*Goal: Complete core functionality for personal code and insight management.*

### Sprint 0.1.3 (Current)

- [x] **CollectView Core Functionality:**
    - [x] Add delete functionality for personal code and insights
    - [x] Implement visual feedback system
    - [x] Add submit functionality to insight text field
    - [x] Improve UI spacing and visual hierarchy
    - [x] Add proper button states and validation
- [ ] Notifications
- [ ] Daily Notification at 8am to that brings the user to the align page
- [ ] ability to turn this feature on or off, and edit what time, and how many times per day they want to be notified to do this.
- [ ] set a goal for how many times per day they want to align, and show a progress bar for how many times they have aligned that week. Default should be twice a day, once in the morning, once in the evening.
- [ ] similar thing for insight notifications. default setting to once an hour, a different insight in the push notification each hour.
- [ ] create an onboarding process that is used at the beginning of using the app, allowing the user to define these settings before hand. 
- [ ] onboarding should also include logging in, or creating a new account. The onboarding have different parts. the first part should be at the beginning of using the app. this part allows the user to define everything, and learn how this app will benefit them. I want it to gently let the user know that they'll be able to use all the features for free at first, and then the notifications will only be able to send one insight, rather than many different ones throughout the day.
- [ ] create a live activity widget to be visible during the day on the lock screen. 
- [ ] The widget will show a stock tracking style view of the user's screen time throughout the day. It will also show one insight, updated each hour.

## Version 0.2.0: HorizonFrame Expansion - Onboarding, Community & Content

*Goal: Introduce a comprehensive onboarding experience, content discovery and creation tools, community interaction features, and a foundational monetization structure to significantly expand HorizonFrame's capabilities and user engagement.*

### Onboarding Experience
- [ ] **Onboarding - Welcome Page:** Design and implement the initial welcome screen for new users.
    *   **User Vision:** Display a welcoming message ("Welcome to HorizonFrame."), explain the core belief ("We believe that to live the life you want, it's crucial to stay grounded in what you believe in."), state the app's challenge/purpose ("Our challenge to you is for you to align yourself with the person you want to become each day."), and prompt the user to start by choosing a sample passage. Options should include "The Lord's Prayer," "Psalm 32," 3-5 other pre-defined options, and an option to "Create your own." Conclude with a transition: "Now that you've chosen a passage, let's walk through the daily practice."
- [ ] **Onboarding - Begin Alignment Page Introduction:** Define and implement the UI/UX for how a user progresses through their selected passage during onboarding.
    *   **User Vision:** After passage selection, guide the user through a sample of the alignment process, where they meditate on each line of the passage. The specific interface for progressing through lines needs to be designed.
- [ ] **Onboarding - Alignment Completion Page Introduction:** Design and implement the screen shown after a user completes their first (or a sample) alignment during onboarding.
    *   **User Vision:** Show a message about completing the alignment. Introduce the concept of the consistency streak they've started or how their consistency will be tracked.
- [ ] **Onboarding - Create Wallpaper Page Introduction:** Introduce the wallpaper creation feature.
    *   **User Vision:** Briefly explain that to further reinforce their alignment, they can create a wallpaper, making each phone opening a chance for brief meditation. (Actual creation might be a later step or post-onboarding).

### Core App Features & Enhancements
- [ ] **Align Page - Default View & Empty State:** Refine the Align Page's initial presentation.
    *   **User Vision:** The first page the user sees on the Align tab should be the "Begin Alignment" page with a clear button to start. If the user has not created or added an alignment, provide guidance or prompts to do so.
- [ ] **Create Wallpaper Page - Full Feature:** Design and implement the full functionality for users to create wallpapers from their alignments.
    *   **User Vision:** Allow users to generate an aesthetic wallpaper from their chosen passage/alignment for their iPhone, reinforcing their meditation.

### Content Discovery & Management (Explore & Collection)
- [x] **UI Unification & Video Backgrounds:** Refactored `Explore`, `Collect`, and `Align` views to use a consistent two-column `PassageCardView` grid. Implemented full-screen, looping video backgrounds in `PassageDetailView` for an immersive experience.
- [ ] **Explore Page - Core Functionality:** Develop the Explore page for users to discover and add new alignments.
    *   **User Vision:** Users can find and add popular alignments to their collection. They can choose to add a found alignment to their daily alignment routine.
- [ ] **Explore Page - Interaction & Menus:** Implement a 3-dot context menu for alignment items in the Explore page.
    *   **User Vision:** Menu options to include: "See less like this," "Add to collection" (with a confirmation step, and options to "Add to Daily Alignment - Main" or "Add to New Daily Alignment" which would prompt to "Set Time for New Daily Alignment").
- [ ] **Explore Page - Content Categories & Curation:** Implement content categorization and display logic.
    *   **User Vision:** Display alignments under sections like "For You" (personalized suggestions), "Trending," "Most Added," and "Popular with Friends." Also, allow browsing by "Categories" such as Bible, Psalms, Proverbs, Philosophy, etc.
- [ ] **Explore Page - Initial Content Population:** Populate the Explore page with a base set of example alignments.
    *   **User Vision:** Provide sufficient initial content to make the Explore page useful until the user base is large enough to contribute a significant amount of shared alignments.
- [x] **Collect Page - Passage Management (Completed 2025-06-11):** Refactored the `Collect` page to manage individual passages directly instead of collections. The new UI features "Active" and "Added" sections, a form for creating detailed passages (with text, author, category, tags), and swipe-to-delete functionality.

### Community & Sharing
- [ ] **Share Page - Social Sharing Functionality:** Implement functionality for users to share passages with friends.
    *   **User Vision:** When a user shares a passage, it generates an aesthetically pleasing image of the passage (similar to the wallpaper) on a stock background. This shared image, when clicked by a friend, will either take them to that passage within the HorizonFrame app (if installed) or to the App Store to download HorizonFrame.
- [ ] **Friends Page - User Accounts & Profiles:** Develop basic social networking features including user accounts and profiles.
    *   **User Vision:** Every user has an account. Users can choose to keep their profile private (allowing them to still view others' public passages and add friends) or make it public. Public profiles can create their own passages, and other users can visit their profile to see all passages they've created and those they've "reposted" or shared.

### Monetization
- [ ] **Subscription Model - Freemium Implementation:** Define and implement the freemium subscription model.
    *   **User Vision:** The free version of the app includes all core features. The limitation for free users is on the unlimited access to view and add others' alignments to their own collection from the Explore page. (Specific pricing model to be determined).

### Project & Growth Initiatives
- [ ] **Product Name Finalization:** Revisit and make a final decision on the product name.
    *   **User Vision:** Consider options like "Passage," "Passage.io," "Passage.ai," "Canticle," "Canticle.io," or retaining "HorizonFrame" (noting that the logo/animation already aligns with HorizonFrame).
- [ ] **Product Walkthrough Video Production:** Plan and create product walkthrough videos for marketing and user education.
    *   **User Vision:** Produce two versions: 1. Social Media Walkthrough (includes video of presenters, designed for LinkedIn, Instagram, X, YouTube, Facebook). 2. App Store Walkthrough (typically no presenter video/voice, uses captions).
- [ ] **Sound Design Exploration & Development:** Investigate and develop sound effects and music for the app and marketing materials.
    *   **User Vision:** Explore sound creation that pairs with in-app animations/effects and video content. (Research tools for sound development on Mac).
- [ ] **Marketing Strategy - Social Media Content:** Develop and execute a social media outreach strategy focusing on short-form videos.
    *   **User Vision:** Videos posted on all major platforms, created efficiently, and representative of the app experience. Utilize the same passage iteration animation as in the app, with voiceover, emotion-invoking music/background video, and concluding with HorizonFrame logo animation and audio.




- [ ] **CollectView Enhanced Features:**
    - [ ] Implement drag-and-drop between personal code and insights
    - [ ] Add sorting/filtering options for insights
    - [ ] Add categories or tags for insights

- [ ] **AlignView Improvements:**
    - [ ] Complete personal code editing functionality
    - [ ] Add visual feedback for actions
    - [ ] Implement proper error handling
    - [x] **Revamp Passage Viewing Experience (Universal & Align-Specific) (Related to Onboarding Alignment Introduction)**
        - [x] Universal Passage View: Transparent Nav Bar & Darkened Video Background (No distinct text background box)
        - [x] Universal Passage View: Consistent White Top Buttons & Simplified Back Button (Icon only)
        - [x] Align Passage View: Interactive Line-by-Line Progression (Tap-based, visual emphasis change)
        - [x] Align Passage View: Share as Animated Video (Text iterates over video background)

### Sprint 0.1.4 (Next)

- [ ] **Progress Tab Enhancements:**
    - [ ] Add alignment streak tracking
    - [ ] Show calendar view of completed alignments
    - [ ] Display daily/weekly/monthly statistics

- [ ] **Settings Page Improvements:**
    - [ ] Add notification preferences
    - [ ] Add data management options
    - [ ] Implement theme settings

## Version 0.2.0: Enhanced Features

*Goal: Improve user experience and add advanced functionality.*

- [ ] **Advanced Personal Code Management:**
    - [ ] Categories for personal code statements
    - [ ] Favorites/pinning functionality
    - [ ] Import/export capabilities

- [ ] **Insight Collection Enhancements:**
    - [ ] Rich text formatting
    - [ ] Tags and categories
    - [ ] Search functionality
    - [ ] Sorting options

- [ ] **UI/UX Improvements:**
    - [ ] Smoother animations
    - [ ] Haptic feedback
    - [ ] Dark/light theme support

## Version 0.3.0: Notifications & Cloud Integration

*Goal: Add smart notifications and cloud backup.*

- [ ] **Smart Notifications:**
    - [ ] Customizable reminder schedule
    - [ ] Context-aware notifications
    - [ ] Progress-based encouragement

- [ ] **Cloud Features:**
    - [ ] iCloud sync
    - [ ] Backup/restore
    - [ ] Cross-device support

## Future Considerations (Post 0.3.0)

- [ ] **Advanced Statistics & Trends:** More detailed analytics in the Progress Tab.
- [ ] **Export Options:** More robust data export formats.
- [ ] **Wearable Integration (e.g., Apple Watch prompts/logging).**
- [ ] **Accessibility Enhancements (VoiceOver, dynamic type, etc.).**

*This roadmap helps guide development efforts. Specific features and timelines are subject to change based on user feedback and development capacity.*
