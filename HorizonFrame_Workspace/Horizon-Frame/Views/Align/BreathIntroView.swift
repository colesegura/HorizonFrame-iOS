//
//  BreathIntroView.swift
//

import SwiftUI
import Combine

/// Expanding / contracting circle that guides one deep breath.
/// When the contraction completes, `onFinish()` fires.
struct BreathIntroView: View {
    var onFinish: () -> Void
    
    @State private var progress: CGFloat = 0      // 0 ➜ 1 ➜ 0
    @State private var inhale = true
    private let cycle = 4.0                       // seconds for a full inhale or exhale
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [.white.opacity(0.15), .white.opacity(0.02)],
                        center: .center,
                        startRadius: 0,
                        endRadius: 300
                    )
                )
                .frame(width: 60 + progress * 260,
                       height: 60 + progress * 260)
                .blur(radius: 30)
                .animation(.easeInOut(duration: cycle), value: progress)
                .onAppear { breathe() }
        }
        // Subtle instruction
        .overlay(
            Text(inhale ? "Inhale" : "Exhale")
                .font(.system(size: 20, weight: .light, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
                .padding(.top, 420)
        )
    }
    
    private func breathe() {
        progress = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + cycle) {
            inhale.toggle()
            progress = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + cycle) {
                onFinish()
            }
        }
    }
}
