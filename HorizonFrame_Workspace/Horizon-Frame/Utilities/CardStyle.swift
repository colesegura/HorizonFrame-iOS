import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)
    }
}

extension View {
    func cardStyle() -> some View { self.modifier(CardStyle()) }
}
