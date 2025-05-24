import SwiftUI

public struct AlignView: View {
    @EnvironmentObject private var data: AppData
    @State private var index = 0
    @State private var hasOnboarded = UserDefaults.standard.bool(forKey: "alignOnboarded")
    @State private var isInEditMode: Bool = false

    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(Date.now.formatted(date: .long, time: .omitted))
                        .font(.footnote).foregroundColor(.white.opacity(0.6))
                    Spacer()
                    Button {
                        isInEditMode.toggle()
                    } label: {
                        Image(systemName: isInEditMode ? "checkmark.circle.fill" : "ellipsis.circle")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                }
                Spacer().frame(height: 20)
                ForEach(Array(data.personalCode.enumerated()), id: \.offset) { idx, line in
                    HStack {
                        if isInEditMode {
                            // Placeholder Edit Button
                            Button {
                                // Action for editing this specific line
                                print("Edit line: \(line)")
                            } label: {
                                Image(systemName: "pencil.circle")
                                    .foregroundColor(.gray)
                            }
                            // Placeholder Delete Button
                            Button {
                                // Action for deleting this specific line
                                data.personalCode.remove(at: idx)
                                // Adjust index if necessary, or simply refresh view
                                if index >= data.personalCode.count && data.personalCode.count > 0 {
                                    index = data.personalCode.count - 1
                                }
                            } label: {
                                Image(systemName: "minus.circle")
                                    .foregroundColor(.gray)
                            }
                            Spacer().frame(width: 10) // Space between buttons and text
                        }

                        Text(line)
                            .font(.title2)
                            .fontWeight(idx == index && !isInEditMode ? .bold : .regular) // Only bold if not in edit mode
                            .foregroundColor(idx == index && !isInEditMode ? .white : Color.white.opacity(0.6))
                            .onTapGesture {
                                if !isInEditMode {
                                    advance()
                                }
                            }
                            .animation(.easeInOut, value: index)
                        
                        if !isInEditMode {
                             Spacer() // Ensure text takes full width when not editing
                        }
                    }
                    .padding(.leading, isInEditMode ? 0 : 0) // Optional: adjust leading padding if needed for alignment
                    .animation(.default, value: isInEditMode) // Animate the row changes
                }
                if isInEditMode {
                    Button("Add New Statement") {
                        data.personalCode.append("New statement")
                    }
                    .padding(.top)
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
