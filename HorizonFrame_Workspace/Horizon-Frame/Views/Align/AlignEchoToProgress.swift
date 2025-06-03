//
//  AlignEchoToProgress.swift
//

import SwiftUI

/// Tiny glowing particle that shoots to the bottom-tab Progress icon after completion.
/// (Assumes Progress tab has systemName "chart.line.uptrend.xyaxis")
struct AlignEchoToProgress: View {
    @State private var travel = false
    
    var body: some View {
        GeometryReader { geo in
            Circle()
                .fill(.white)
                .frame(width: 12, height: 12)
                .shadow(color: .white, radius: 8) // Enhanced shadow for better glow
                .position(x: travel ? geo.size.width * 0.85 : geo.size.width / 2,
                          y: travel ? geo.size.height - 32       : geo.size.height / 2)
                .opacity(travel ? 0 : 1)
                .animation(.easeInOut(duration: 0.8), value: travel)
                .onAppear { travel = true }
        }
        .allowsHitTesting(false)
    }
}
