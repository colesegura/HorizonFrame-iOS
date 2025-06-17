import SwiftUI

struct AlignView: View {
    @EnvironmentObject private var vm: AlignViewModel
    @EnvironmentObject private var storeManager: StoreManager
    @State private var playSession: Session?
    @State private var showSubscriptionSheet = false
    @State private var showReferralShare = false
    @State private var showPremiumStatusSheet = false

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }

    private func dayOfWeek(for date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        return df.string(from: date)
    }

    private var completionMessages: [String: String] = [
        "Sunday": "Sunday's serenity achieved. Rest well for the week ahead.",
        "Monday": "Monday's mission complete! You've started the week strong.",
        "Tuesday": "Tuesday's trials tackled. Keep the momentum going!",
        "Wednesday": "Well done on Wednesday! You're over the hump.",
        "Thursday": "Thursday's tasks dispatched. The weekend is in sight!",
        "Friday": "Fantastic Friday finish! Enjoy your well-earned respite.",
        "Saturday": "Saturday's sessions signed off. A perfect end to your efforts."
    ]

    private var currentDayCompletionMessage: String {
        let day = dayOfWeek(for: vm.selectedDate)
        return completionMessages[day] ?? "You've completed your alignments for the day. Rest and prepare for tomorrow!"
    }

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button { vm.goToPreviousDay() } label: { Image(systemName: "arrow.left") }
                Spacer()
                Text(vm.selectedDate, style: .date).bold().font(.title2)
                Spacer()
                Button { vm.goToNextDay() } label: { Image(systemName: "arrow.right") }
            }
            .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    if vm.upcomingSessionsForSelectedDate.isEmpty {
                        VStack(alignment: .center, spacing: 12) {
                            Text("All Clear!")
                                .font(.title.bold())
                                .foregroundColor(.white)
                            Text(currentDayCompletionMessage)
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 50)
                    } else {
                        SectionHeader(title: "Upcoming")
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(Array(vm.upcomingSessionsForSelectedDate.enumerated()), id: \.element.id) { index, session in
                                NavigationLink(destination: AlignPassageView(passage: session.passage, videoName: session.passage.videoName ?? "HF_Vid_Waves_01")) {
                                    PassageCardView(passage: session.passage)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    if !vm.completedSessionsForSelectedDate.isEmpty {
                        SectionHeader(title: "Completed")
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(vm.completedSessionsForSelectedDate) { session in
                                NavigationLink(destination: PassageDetailView(passage: session.passage)) {
                                    PassageCardView(passage: session.passage)
                                        .opacity(0.7)
                                        .overlay(
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 44))
                                                .foregroundColor(.green)
                                                .background(Color.white.opacity(0.5).clipShape(Circle()))
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.clear)
        .navigationTitle("Align")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    showReferralShare = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                Button {
                    if storeManager.isPremium {
                        showPremiumStatusSheet = true
                    } else {
                        showSubscriptionSheet = true
                    }
                } label: {
                    Image(systemName: storeManager.isPremium ? "crown.fill" : "crown")
                }
            }
        }
        .sheet(item: $playSession) { sessionToPlay in
            AlignmentPlayerContainer(session: sessionToPlay) {
                vm.markFirstUpcomingDone()
            }
            .presentationDetents([.large])
            .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showSubscriptionSheet) {
            SubscriptionOptionsView()
        }
        .sheet(isPresented: $showReferralShare) {
            ReferralView()
        }
        .sheet(isPresented: $showPremiumStatusSheet) {
            PremiumStatusView()
        }
    }
}

private struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title2).bold()
            .foregroundColor(.white.opacity(0.9))
            .padding(.bottom, -8)
    }
}