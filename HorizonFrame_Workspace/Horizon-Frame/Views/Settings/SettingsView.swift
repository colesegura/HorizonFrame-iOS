import SwiftUI

public struct SettingsView: View {
    @EnvironmentObject private var data: AppData
    @State private var notifsEnabled = true

    public var body: some View {
        Form {
            Section(header: Text("Notifications")) {
                Toggle("Enable daily insights", isOn: $notifsEnabled)
                    .onChange(of: notifsEnabled) { oldValue, newValue in
                        if newValue {
                            NotificationService.schedule(insights: data.insights)
                        } else {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        }
                    }
            }

            Section(header: Text("Data")) {
                Button("Export JSON (Coming soon)") { }
                Button("Clear all data", role: .destructive) {
                    data.personalCode.removeAll()
                    data.insights.removeAll()
                }
            }

            Section {
                Text("Version 0.1 MVP")
                    .font(.footnote).foregroundColor(.secondary)
            }
        }
        .scrollContentBackground(.hidden)
    }
}
