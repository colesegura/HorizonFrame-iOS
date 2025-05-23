import SwiftUI

struct ContentView: View {
    @StateObject private var router = TabRouter()
    @StateObject private var data   = AppData()

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {
                TopTabBar().environmentObject(router)
                Divider().opacity(0)          // Spacer between tabs & content
                Group {
                    switch router.current {
                    case .align:    AlignView()
                    case .collect:  CollectView()
                    case .progress: ProgressView_HF()
                    case .settings: SettingsView()
                    }
                }
                .environmentObject(data)
                .environmentObject(router)
            }
            .foregroundColor(.white)
            .font(.body)
        }
    }
}
