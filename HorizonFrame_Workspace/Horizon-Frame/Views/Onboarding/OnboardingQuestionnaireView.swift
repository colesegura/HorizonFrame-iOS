import SwiftUI

struct OnboardingQuestionnaireView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Progress Bar
            ProgressView(value: viewModel.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .accentColor))
                .padding(.bottom, 20)

            if let question = viewModel.currentQuestion {
                // Question Text
                Text(question.text)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .id(question.id) // Ensures view updates on question change

                Spacer()

                // Answer Buttons
                VStack(spacing: 15) {
                    ForEach(question.answers, id: \.self) { answer in
                        Button(action: {
                            withAnimation {
                                viewModel.answerQuestion(answer: answer)
                            }
                        }) {
                            Text(answer)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(16)
                        }
                    }
                }
            } else {
                Text("Loading questions...")
            }
        }
        .padding()
    }
}
