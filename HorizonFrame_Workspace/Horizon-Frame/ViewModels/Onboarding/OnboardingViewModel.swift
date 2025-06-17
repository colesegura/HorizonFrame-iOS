import Foundation
import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {

    enum OnboardingStep {
        case welcome
        case questionnaire
        case generatingReport
        case paywall
    }

    @Published var currentStep: OnboardingStep = .welcome
    
    // --- Questionnaire Properties ---
    @Published private(set) var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    private(set) var userAnswers: [String] = []

    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentQuestionIndex) / Double(questions.count)
    }

    init() {
        loadQuestions()
    }

    // --- State Management ---
    
    func advance() {
        switch currentStep {
        case .welcome:
            currentStep = .questionnaire
        case .questionnaire:
            // This case is handled by answerQuestion()
            break
        case .generatingReport:
            currentStep = .paywall
        case .paywall:
            // This will be handled by the paywall's complete button
            break
        }
    }

    func advanceToPaywall() {
        currentStep = .paywall
    }
    
    func answerQuestion(answer: String) {
        userAnswers.append(answer)
        
        if currentQuestionIndex < questions.count - 1 {
            // Move to the next question
            currentQuestionIndex += 1
        } else {
            // End of questionnaire, move to the next step
            print("User answers: \(userAnswers)")
            currentStep = .generatingReport
        }
    }

    func completeOnboarding(isPresented: Binding<Bool>) {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        isPresented.wrappedValue = false
    }
    
    func goToWelcome() {
        currentQuestionIndex = 0
        userAnswers = []
        currentStep = .welcome
    }
    
    // --- Data Loading ---
    
    private func loadQuestions() {
        // In a real app, this would come from a plist, JSON, or a server.
        self.questions = [
            Question(text: "What's your primary goal for using this app?", answers: ["Clarity", "Focus", "Motivation", "Peace"]),
            Question(text: "How often do you want to check in with your personal code?", answers: ["Daily", "A few times a week", "Weekly", "When I feel like it"]),
            Question(text: "Which area of your life needs the most alignment right now?", answers: ["Career", "Relationships", "Health", "Personal Growth"]),
            Question(text: "What time of day are you most reflective?", answers: ["Morning", "Afternoon", "Evening", "Late Night"])
        ]
    }
}
