import SwiftUI

@main
struct HorizonFrameApp: App {
    init() { NotificationService.requestPermission() }

    var body: some Scene {
        WindowGroup { ContentView().preferredColorScheme(.dark) }
    }
}
