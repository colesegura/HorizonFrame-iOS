import SwiftUI

enum AppTab: CaseIterable, Identifiable {
    case align, collect, explore, settings

    var id: Self { self }

    var title: String {
        switch self {
        case .align: return "Align"
        case .collect: return "Collect"
        case .explore: return "Explore"
        case .settings: return "Settings"
        }
    }

    var iconName: String {
        switch self {
        case .align: return "target"
        case .collect: return "folder.fill"
        case .explore: return "safari.fill"
        case .settings: return "gear"
        }
    }
    
    // Add a convenience to get the view associated with each tab
    @ViewBuilder
    func view(alignVM: AlignViewModel, collectVM: CollectViewModel, exploreVM: ExploreViewModel, settingsVM: SettingsViewModel) -> some View {
        switch self {
        case .align:
            NavigationView { AlignView().environmentObject(alignVM) }
        case .collect:
            NavigationView { CollectView().environmentObject(collectVM) }
        case .explore:
            NavigationView { ExploreView().environmentObject(exploreVM) }
        case .settings:
            NavigationView { SettingsView().environmentObject(settingsVM) }
        }
    }
}
