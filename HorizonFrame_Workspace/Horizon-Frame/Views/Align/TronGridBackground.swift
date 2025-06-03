import SwiftUI

public struct TronGridBackground: View {
    public var body: some View {
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
