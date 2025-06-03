//
//  AlignView.swift
//  HorizonFrame
//
//  Created by Cole & GPT on 2025-06-03.
//  Copyright © 2025.
//

import SwiftUI
import CoreMotion   // For gyroscope-driven parallax

/// Root container shown when the user taps the Align tab.
public struct AlignView: View {
    @EnvironmentObject private var data: AppData
    @State private var showIntro = true
    @State private var didFinish = false      // triggers echo animation
    
    public init() {}  // Explicit because the file is public.
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if showIntro {
                BreathIntroView {
                    withAnimation(.easeInOut(duration: 0.6)) { showIntro = false }
                }
                .transition(.opacity)
            } else {
                CardPager(
                    statements: data.personalCode,
                    onCompleted: {
                        withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                            didFinish = true
                        }
                        // Slight delay so the glow has time to show.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            didFinish = false
                            showIntro = true   // next session starts with breath again
                        }
                    }
                )
                .transition(.opacity)
            }
            
            if didFinish {
                AlignEchoToProgress()
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
}
