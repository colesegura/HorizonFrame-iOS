import SwiftUI

struct AnimatedGradientBackground: View {
    @State private var gradientColors: [Color] = [
        Color(hex: "030303"), // Even darker gray
        Color(hex: "0a0a0a"), // Near black
        Color(hex: "000005"), // Extremely dark blue
        Color(hex: "050005"), // Extremely dark purple
        Color(hex: "030100")  // Extremely dark brown/orange
    ]
    @State private var startPoint = UnitPoint(x: 0, y: 0)
    @State private var endPoint = UnitPoint(x: 1, y: 1)

    // Timer to change animation properties
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: startPoint, endPoint: endPoint)
            .edgesIgnoringSafeArea(.all)
            .onReceive(timer) { _ in
                withAnimation(.easeInOut(duration: 12.0)) {
                    // Shift colors
                    self.gradientColors.shuffle() // Simple way to change, or cycle them
                    
                    // Animate start and end points for a flowing effect
                    self.startPoint = UnitPoint(x: CGFloat.random(in: -0.5...0.5), y: CGFloat.random(in: -0.5...0.5))
                    self.endPoint = UnitPoint(x: CGFloat.random(in: 0.5...1.5), y: CGFloat.random(in: 0.5...1.5))
                }
            }
    }
}

// Helper to initialize Color from hex string (often useful)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
