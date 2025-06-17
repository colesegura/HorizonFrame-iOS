import SwiftUI

struct PassageTextRendererView: View {
    let passageLines: [String]
    let currentLineIndex: Int
    let textFrameWidth: CGFloat // The width the text should occupy, matching video width

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(Array(passageLines.enumerated()), id: \.offset) { index, line in
                Text(line)
                    .font(index == currentLineIndex ? .title3.weight(.heavy) : .title3.weight(.regular))
                    .foregroundColor(index == currentLineIndex ? .white : .gray.opacity(0.8))
                    .frame(width: textFrameWidth, alignment: .leading) // Ensure lines take specified width
                    .padding(.vertical, 2)
            }
        }
        .padding() // Add some padding around the text block
        .background(Color.clear) // Crucial: transparent background
    }
}

#if DEBUG
struct PassageTextRendererView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleLines = [
            "This is the first line of the passage.",
            "The second line follows, a bit longer perhaps.",
            "And finally, the third line to conclude."
        ]
        PassageTextRendererView(passageLines: sampleLines, currentLineIndex: 1, textFrameWidth: 300)
            .background(Color.blue) // Preview with a colored background to see transparency
            .previewLayout(.sizeThatFits)
    }
}
#endif
