import SwiftUI

public struct SettingsView: View {
    @EnvironmentObject private var data: AppData
    @State private var notifsEnabled = true

    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Set black background for the whole view
            Form {
            Section(header: Text("Notifications")) {
                Toggle("Enable daily insights", isOn: $notifsEnabled)
                    .listRowBackground(Color.black)
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
                    .listRowBackground(Color.black)
                Button("Clear all data", role: .destructive) {
                    .listRowBackground(Color.black)
                    data.personalCode.removeAll()
                    data.insights.removeAll()
                }
            }

            Section {
                Text("Version 0.1.1")
                    .listRowBackground(Color.black)
                    .font(.footnote).foregroundColor(.secondary)
            }
            }
            .scrollContentBackground(.hidden) // Ensure form background is transparent
        }
    }
}
