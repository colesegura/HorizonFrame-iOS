import SwiftUI

struct AlignView: View {
    @EnvironmentObject var vm: AlignViewModel
    @State private var playSession: Session?

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

    var body: some View {
        VStack(spacing: 16) { 
            HStack {
                Button {
                    vm.goToPreviousDay()
                } label: {
                    Image(systemName: "arrow.left")
                }
                Spacer()
                Text(vm.selectedDate, style: .date).bold() 
                Spacer()
                Button {
                    vm.goToNextDay()
                } label: {
                    Image(systemName: "arrow.right")
                }
            }
            .padding(.horizontal)
            .padding(.top)

            if let next = vm.upcomingSessionsForSelectedDate.first {
                VStack(alignment: .leading, spacing: 4) {
                    Text(next.passage.title).font(.headline)
                    if let date = next.date {
                        Text(date, style: .time)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
                .expandingButton {
                    playSession = next
                }
                .padding(.horizontal)
                .cardStyle()
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text("All Clear!")
                        .font(.title.bold())
                    Text(currentDayCompletionMessage)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40) 
                .padding(.horizontal)
            }

            List {
                if !vm.upcomingSessionsForSelectedDate.isEmpty {
                    Section("Upcoming for \(vm.selectedDate, formatter: dateFormatter)") {
                        ForEach(vm.upcomingSessionsForSelectedDate) { s in
                            SessionRow(session: s)
                        }
                    }
                }
                
                if !vm.completedSessionsForSelectedDate.isEmpty {
                    Section("Completed on \(vm.selectedDate, formatter: dateFormatter)") {
                        ForEach(vm.completedSessionsForSelectedDate) { s in
                            SessionRow(session: s)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden) // Make List background transparent
        }
        .background(Color.clear) // Ensure the VStack itself is also transparent
        .navigationTitle("Align")
        .sheet(item: $playSession) { sessionToPlay in
            AlignmentPlayerContainer(session: sessionToPlay) {
                vm.markFirstUpcomingDone()
            }
            .presentationDetents([.large])
            .interactiveDismissDisabled() 
        }
    }
}

private struct SessionRow: View {
    let session: Session

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(session.passage.title)
                if let date = session.date {
                    Text(date, style: .time).font(.caption).foregroundColor(.secondary)
                }
            }
            Spacer()
            Image(systemName: session.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(session.isCompleted ? .green : .secondary)
        }
    }
}