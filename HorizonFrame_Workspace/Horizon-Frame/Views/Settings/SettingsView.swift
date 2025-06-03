import SwiftUI

public struct SettingsView: View {
    @EnvironmentObject private var data: AppData
    @State private var notifsEnabled = true

    public var body: some View {
        ZStack {
            Form {
            Section(header: Text("Notifications")) { // Style header
                Toggle("Enable daily insights", isOn: $notifsEnabled)
                    .onChange(of: notifsEnabled) { oldValue, newValue in
                        if newValue {
                            NotificationService.schedule(insights: data.insights)
                        } else {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        }
                    }
            }

            Section {
                Button("Export JSON (Coming soon)") { /* Action placeholder */ }

                Button("Clear all data", role: .destructive) {
                    data.personalCode.removeAll()
                    data.insights.removeAll()
                }
            } header: { Text("Data") }

            Section {
                Text("Version 0.1.1")
            }
            .scrollContentBackground(.hidden) // Ensure form background is transparent
        } // Closes Form
    } // Closes ZStack
    }
}
