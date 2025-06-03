//
//  AlignView.swift
//  HorizonFrame
//
//  Tron × Transcendental overhaul – 2025‑06‑03
//

import SwiftUI
import CoreMotion

public struct AlignView: View {
    @EnvironmentObject private var data: AppData
    
    private enum Phase { case gate, ripple, breath, cards, done }
    @State private var phase: Phase = .gate
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            switch phase {
            case .gate:
                ReadyGateView {
                    withAnimation(.easeInOut(duration: 0.5)) { phase = .ripple }
                }
                .transition(.opacity)
                
            case .ripple:
                RipplePortalView { phase = .breath }
                    .transition(.opacity)
                
            case .breath:
                BreathIntroView {
                    withAnimation(.easeInOut(duration: 0.6)) { phase = .cards }
                }
                .transition(.opacity)
                
            case .cards:
                CardPager(statements: data.personalCode) {
                    withAnimation(.easeInOut(duration: 0.6)) { phase = .done }
                }
                .transition(.opacity)
                
            case .done:
                DoneView {
                    withAnimation(.easeInOut(duration: 0.6)) { phase = .gate }
                }
                .transition(.opacity)
            }
        }
    }
}

// MARK: - Neon “Ready” gate

private struct ReadyGateView: View {
    var onBegin: () -> Void
    @State private var glow = false
    
    var body: some View {
        ZStack {
            TronGridBackground()
            Text("Begin Alignment")
                .font(.title.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 44)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.cyan, lineWidth: 2)
                        .shadow(color: .cyan, radius: glow ? 22 : 8)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: glow)
                )
                .onAppear { glow = true }
                .onTapGesture { onBegin() }
        }
    }
}

// MARK: - Ripple portal transition

private struct RipplePortalView: View {
    var onFinish: () -> Void
    @State private var progress: CGFloat = 0
    
    var body: some View {
        TimelineView(.animation) { _ in
            Canvas { ctx, size in
                let maxR = hypot(size.width, size.height)
                let rings = 6
                for i in 0..<rings {
                    let pct = (progress + CGFloat(i)/CGFloat(rings)).truncatingRemainder(dividingBy: 1)
                    var p = Path()
                    p.addArc(center: .init(x: size.width/2, y: size.height/2),
                             radius: pct*maxR,
                             startAngle: .degrees(0),
                             endAngle: .degrees(360),
                             clockwise: false)
                    ctx.stroke(p, with: .color(Color.cyan.opacity(1 - pct)), lineWidth: 8*(1-pct))
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 1.2)) { progress = 1 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { onFinish() }
        }
    }
}

// MARK: - Completion page

private struct DoneView: View {
    var onClose: () -> Void
    @State private var shine = false
    
    var body: some View {
        ZStack {
            TronGridBackground()
            VStack(spacing: 28) {
                Text("Alignment Complete")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundStyle(
                        LinearGradient(colors: [.magenta, .cyan],
                                       startPoint: .leading, endPoint: .trailing)
                    )
                    .shadow(color: .cyan, radius: shine ? 26 : 10)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: shine)
                
                Button {
                    onClose()
                } label: {
                    Text("Return")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 36)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.cyan.opacity(0.25))
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cyan, lineWidth: 2))
                        )
                }
            }
            .onAppear { shine = true }
        }
    }
}

// MARK: - Neon grid backdrop (shared)

private struct TronGridBackground: View {
    var body: some View {
        GeometryReader { geo in
            Canvas { ctx, size in
                let gap: CGFloat = 30
                for x in stride(from: 0, through: size.width, by: gap) {
                    var v = Path()
                    v.move(to: .init(x: x, y: 0))
                    v.addLine(to: .init(x: x, y: size.height))
                    ctx.stroke(v, with: .color(Color.cyan.opacity(0.12)), lineWidth: 0.7)
                }
                for y in stride(from: 0, through: size.height, by: gap) {
                    var h = Path()
                    h.move(to: .init(x: 0, y: y))
                    h.addLine(to: .init(x: size.width, y: y))
                    ctx.stroke(h, with: .color(Color.cyan.opacity(0.12)), lineWidth: 0.7)
                }
            }
            .ignoresSafeArea()
        }
    }
}
//
//  BreathIntroView.swift
//  HorizonFrame
//
//  Tron × Transcendental breathing orb – 2025‑06‑03
//

import SwiftUI
import Combine

struct BreathIntroView: View {
    var onFinish: () -> Void
    
    @State private var phase: CGFloat = 0          // 0 ➜ 1 ➜ 0
    private let cycle = 4.0                        // seconds per half‑cycle
    
    var body: some View {
        ZStack {
            TronGridBackground()
            
            Circle()
                .fill(AngularGradient(
                    gradient: Gradient(colors: [.magenta, .cyan, .magenta]),
                    center: .center))
                .frame(width: 120 + phase*220,
                       height: 120 + phase*220)
                .blur(radius: 50)
                .shadow(color: .cyan.opacity(0.6), radius: 38)
                .animation(.easeInOut(duration: cycle), value: phase)
        }
        .overlay(
            Text(phase < 0.5 ? "Inhale" : "Exhale")
                .font(.title3.weight(.medium))
                .foregroundColor(.white.opacity(0.9))
                .padding(.top, 420)
        )
        .onAppear { breathe() }
    }
    
    private func breathe() {
        phase = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + cycle) {
            phase = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + cycle) {
                onFinish()
            }
        }
    }
}
//
//  CardPager.swift
//  HorizonFrame
//
//  Tweaked for completion callback – 2025‑06‑03
//

import SwiftUI
import CoreMotion

struct CardPager: View {
    let statements: [String]
    var onCompleted: () -> Void
    
    @State private var current = 0
    @State private var flipped = false
    @StateObject private var motion = ParallaxManager()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.0001) // keeps gestures active
            
            TabView(selection: $current) {
                ForEach(statements.indices, id: \.self) { index in
                    PersonalCodeCard(text: statements[index],
                                     flipped: index == current ? $flipped : .constant(false))
                        .modifier(ParallaxModifier(xTilt: motion.xTilt,
                                                   yTilt: motion.yTilt))
                        .padding(.horizontal, 20)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: current) { idx in
                flipped = false
                guard statements.indices.contains(idx) else { return }
                if idx == statements.count - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        onCompleted()
                    }
                }
            }
        }
    }
}
