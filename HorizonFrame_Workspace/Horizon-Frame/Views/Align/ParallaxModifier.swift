import SwiftUI
import CoreMotion

/// Adds subtle device-tilt parallax.
struct ParallaxModifier: ViewModifier {
    var xTilt: Double
    var yTilt: Double
    var strength: Double = 10
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(-xTilt * strength), axis: (1,0,0))
            .rotation3DEffect(.degrees(yTilt  * strength), axis: (0,1,0))
    }
}

/// Lightweight motion manager.
final class ParallaxManager: ObservableObject {
    @Published var xTilt: Double = 0
    @Published var yTilt: Double = 0
    
    private let cm = CMMotionManager()
    init() {
        cm.deviceMotionUpdateInterval = 1/60
        cm.startDeviceMotionUpdates(to: .main) { [weak self] m,_ in
            guard let a = m?.attitude else { return }
            self?.xTilt = a.pitch
            self?.yTilt = a.roll
        }
    }
    deinit { cm.stopDeviceMotionUpdates() }
}
