import SwiftUI

/// Displays all lines of a passage but highlights one at a time.  Tap to advance.
struct LineFocusText: View {
    let lines: [String]
    @State private var idx = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(lines.indices, id: \.self) { i in
                Text(lines[i])
                    .font(i == idx ? .largeTitle.bold() : .title2)
                    .foregroundColor(i == idx ? .white : .gray)
                    .opacity(i <= idx ? 1 : 0)
                    .animation(.easeInOut(duration: 0.3), value: idx)
            }
        }
        .onTapGesture {
            if idx < lines.count - 1 { idx += 1 }
        }
    }
}
