//
//  AlignEchoToProgress.swift
//  HorizonFrame
//
//  Echo animation that shoots to the Progress tab.
//
import SwiftUI

struct AlignEchoToProgress: View {
    @State private var travel = false
    
    var body: some View {
        GeometryReader { geo in
            Circle()
                .fill(Color.accentColor)
                .frame(width: 14, height: 14)
                .position(
                    x: travel ? geo.size.width * 0.85 : geo.size.width / 2,
                    y: travel ? geo.size.height - 34  : geo.size.height / 2
                )
                .scaleEffect(travel ? 0.8 : 1.2)
                .opacity(travel ? 0 : 1)
                .animation(.easeInOut(duration: 0.9), value: travel)
                .onAppear { travel = true }
        }
        .allowsHitTesting(false)
    }
}
