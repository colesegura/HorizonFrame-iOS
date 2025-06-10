import SwiftUI

struct MainAppView: View {
    @State private var selectedTab: AppTab = .align // Default tab

    // EnvironmentObjects for the actual views
    // These will be passed down from KineticFramesLaunchView or HorizonFrameApp
    @EnvironmentObject var alignVM: AlignViewModel
    @EnvironmentObject var collectVM: CollectViewModel
    @EnvironmentObject var exploreVM: ExploreViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel

    var body: some View {
        ZStack {
            // Animated Gradient Background will be the base layer from KineticFramesLaunchView
            
            // Content Area
            // The selectedTab.view() helper will provide the correct NavigationView
            // We use a Group to switch views to ensure transitions can be applied if needed.
            Group {
                selectedTab.view(
                    alignVM: alignVM,
                    collectVM: collectVM,
                    exploreVM: exploreVM,
                    settingsVM: settingsVM
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure it takes full space
            .padding(.bottom, 70) // Add padding to the bottom of the content view to avoid overlap with custom tab bar


            // Custom Tab Bar at the bottom
            VStack {
                Spacer() // Pushes tab bar to the bottom
                CustomTabBarView(selectedTab: $selectedTab)
            }
            // .edgesIgnoringSafeArea(.bottom) // Let's not ignore safe area for the tab bar itself initially
        }
        // No .onAppear for UITabBar.appearance().isHidden = true, as we are not using a TabView here.
    }
}

#if DEBUG
struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        // For the preview to work, KineticFramesLaunchView would typically set this up.
        // Here, we simulate it.
        KineticFramesLaunchView()
//        MainAppView()
//            .environmentObject(AlignViewModel())
//            .environmentObject(CollectViewModel())
//            .environmentObject(ExploreViewModel())
//            .environmentObject(SettingsViewModel())
//            .background(AnimatedGradientBackground().ignoresSafeArea())
    }
}
#endif
