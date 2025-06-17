import SwiftUI

struct VideoFrameView: View {
    let passageLines: [String]
    let highlightedLineIndex: Int

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ForEach(passageLines.indices, id: \.self) { index in
                Text(passageLines[index])
                    .font(.system(size: index == highlightedLineIndex ? 52 : 46, weight: index == highlightedLineIndex ? .bold : .regular))
                    .foregroundColor(index == highlightedLineIndex ? .white : Color.white.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .animation(.easeInOut(duration: 0.3), value: highlightedLineIndex)
            }
        }
        .padding(.horizontal, 60)
        .frame(width: 1080, height: 1920, alignment: .center)
        .background(Color.clear) // Set background to clear to see video underneath
    }
}

struct VideoFrameView_Previews: PreviewProvider {
    static var previews: some View {
        // Example background for previewing
        let background = Image("HF_Vid_Waves_01_frame").resizable().scaledToFill().ignoresSafeArea()
        
        VideoFrameView(
            passageLines: [
                "The journey of a thousand miles",
                "begins with a single step.",
                "This is a preview of the view,",
                "showing how text will be styled."
            ],
            highlightedLineIndex: 1
        )
        .background(background)
    }
}
