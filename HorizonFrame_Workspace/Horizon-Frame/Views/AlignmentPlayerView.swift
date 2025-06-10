import SwiftUI
import AVFoundation

/// Full-screen black reader with line-focus + haptic feedback.
struct AlignmentPlayerView: View {
    let session: Session
    var onComplete: () -> Void

    // Split passage into non-empty lines
    private var lines: [String] {
        session.passage.content
            .components(separatedBy: .newlines)
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
    }

    @State private var index = 0
    private let haptic = UIImpactFeedbackGenerator(style: .light)

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 14) {
                ForEach(lines.indices, id: \.self) { i in
                    Text(lines[i])
                        .font(i == index ? .largeTitle.bold() : .title2)
                        .foregroundColor(i == index ? .white : .gray)
                        .opacity(i <= index ? 1 : 0)
                        .animation(.easeInOut(duration: 0.25), value: index)
                }
            }
            .padding()
        }
        .onTapGesture {
            haptic.impactOccurred()
            if index < lines.count - 1 {
                index += 1
            } else {
                onComplete()
            }
        }
    }
}