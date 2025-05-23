import SwiftUI

public struct AlignView: View {
    @EnvironmentObject private var data: AppData
    @State private var index = 0
    @State private var hasOnboarded = UserDefaults.standard.bool(forKey: "alignOnboarded")

    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(Date.now.formatted(date: .long, time: .omitted))
                        .font(.footnote).foregroundColor(.white.opacity(0.6))
                    Spacer()
                    Image(systemName: "ellipsis").foregroundColor(.white)
                }
                Spacer().frame(height: 20)
                ForEach(Array(data.personalCode.enumerated()), id: \.offset) { idx, line in
                    Text(line)
                        .font(.title2)
                        .fontWeight(idx == index ? .bold : .regular)
                        .foregroundColor(idx == index ? .white : Color.white.opacity(0.6))
                        .onTapGesture { advance() }
                        .animation(.easeInOut, value: index)
                }
                Spacer()
                ProgressButton(progress: Double(index + 1) / Double(data.personalCode.count)) {
                    index = 0     // reset
                }
            }
            .padding()
            if !hasOnboarded { OnboardingOverlay(text:
                """
                Welcome to HorizonFrame.\n\nHere you’ll craft a daily practice that aligns your intentions and vision with the life you want to live.
                """,
                cta: "Next") {
                    hasOnboarded = true
                    UserDefaults.standard.set(true, forKey: "alignOnboarded")
                }
            }
        }
        .onAppear { index = 0 }
    }

    private func advance() {
        guard index < data.personalCode.count - 1 else { return }
        index += 1
    }
}
