import Foundation

// A simple struct to represent a single question in the onboarding questionnaire.
struct Question: Identifiable {
    let id = UUID()
    let text: String
    let answers: [String]
    // We can add other properties later, like question type (e.g., single choice, multiple choice)
}
