import SwiftUI

@main
struct HorizonFrameApp: App {
    init() { NotificationService.requestPermission() }

    var body: some Scene {
        WindowGroup { KineticFramesLaunchView().preferredColorScheme(.dark) }
    }
}
