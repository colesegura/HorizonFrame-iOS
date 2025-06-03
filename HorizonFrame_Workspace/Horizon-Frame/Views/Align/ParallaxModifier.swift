//
//  ParallaxModifier.swift
//

import SwiftUI
import CoreMotion

/// ViewModifier that tilts a view based on gyroscope data.
struct ParallaxModifier: ViewModifier {
    var xTilt: Double
    var yTilt: Double
    var strength: Double = 12
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(-xTilt * strength),
                axis: (x: 1, y: 0, z: 0)
            )
            .rotation3DEffect(
                .degrees(yTilt * strength),
                axis: (x: 0, y: 1, z: 0)
            )
    }
}

/// Simple CMMotionManager wrapper.
final class ParallaxManager: ObservableObject {
    @Published var xTilt: Double = 0
    @Published var yTilt: Double = 0
    
    private let manager = CMMotionManager()
    
    init() {
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 1/60
            manager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in // Added error handling
                if let error = error {
                    print("Error getting device motion updates: \(error.localizedDescription)")
                    return
                }
                guard let m = motion else { return }
                self?.xTilt = m.attitude.pitch
                self?.yTilt = m.attitude.roll
            }
        } else {
            print("Device motion is not available.")
        }
    }
    
    deinit { manager.stopDeviceMotionUpdates() }
}
