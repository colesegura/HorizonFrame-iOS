import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            switch viewModel.currentStep {
            case .welcome:
                OnboardingWelcomeView(viewModel: viewModel)
            case .questionnaire:
                OnboardingQuestionnaireView(viewModel: viewModel)
            case .generatingReport:
                OnboardingGeneratingReportView(viewModel: viewModel)
            case .paywall:
                OnboardingPaywallView(viewModel: viewModel, isPresented: $isPresented)
            }
        }
        .animation(.default, value: viewModel.currentStep)
    }
}
