import SwiftUI

@main
struct HorizonFrameApp: App {
    // Register AppDelegate for app lifecycle events
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // Initialize view models for each feature (using dummy data)
    @StateObject private var exploreVM = ExploreViewModel()
    @StateObject private var collectVM = CollectViewModel()
    @StateObject private var alignVM   = AlignViewModel()
    @StateObject private var settingsVM = SettingsViewModel() // Added SettingsViewModel

    var body: some Scene {
        WindowGroup {
            KineticFramesLaunchView()
        }
    }
}