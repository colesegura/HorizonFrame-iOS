import SwiftUI

struct FillingCircleProgressView: View {
    let progress: Double

    var body: some View {
        ZStack {
            // Background track
            Circle()
                .stroke(lineWidth: 4.0)
                .opacity(0.3)
                .foregroundColor(.gray)

            // Foreground progress
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: 270.0)) // Start from the top
        }
        .animation(.linear, value: progress)
    }
}

#if DEBUG
struct FillingCircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            FillingCircleProgressView(progress: 0.25)
                .frame(width: 50, height: 50)
            FillingCircleProgressView(progress: 0.75)
                .frame(width: 50, height: 50)
            FillingCircleProgressView(progress: 1.0)
                .frame(width: 50, height: 50)
        }
        .padding()
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
#endif
