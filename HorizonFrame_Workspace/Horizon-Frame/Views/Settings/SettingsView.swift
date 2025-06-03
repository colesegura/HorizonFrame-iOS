import SwiftUI

public struct SettingsView: View {
    @EnvironmentObject private var data: AppData
    @State private var notifsEnabled = true

    public var body: some View {
        ZStack {
            TronGridBackground().ignoresSafeArea() // Add Tron background
            Color.black.ignoresSafeArea() // Set black background for the whole view
            Form {
            Section(header: Text("Notifications").font(.headline).foregroundColor(.cyan)) { // Style header
                Toggle("Enable daily insights", isOn: $notifsEnabled)
                    .foregroundColor(.white) // Style toggle label
                    .tint(.cyan) // Style toggle switch
                    .listRowBackground(Color.black.opacity(0.6))
                    .onChange(of: notifsEnabled) { oldValue, newValue in
                        if newValue {
                            NotificationService.schedule(insights: data.insights)
                        } else {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        }
                    }
            }

            Section(header: Text("Data").font(.headline).foregroundColor(.cyan)) { // Style header
                Button("Export JSON (Coming soon)") { /* Action placeholder */ }
                    .foregroundColor(.white) // Style button text
                    .listRowBackground(Color.black.opacity(0.6))
                Button("Clear all data", role: .destructive) {
                    data.personalCode.removeAll()
                    data.insights.removeAll()
                }
                .foregroundColor(.magenta) // Style destructive button text with Tron accent
                    data.personalCode.removeAll()
                    data.insights.removeAll()
                }
                .listRowBackground(Color.black.opacity(0.6))
            }

            Section {
                Text("Version 0.1.1")
                    .listRowBackground(Color.black.opacity(0.6))
                    .font(.footnote).foregroundColor(.white.opacity(0.7))
            }
            }
            .scrollContentBackground(.hidden) // Ensure form background is transparent
        }
        .preferredColorScheme(.dark) // Ensure dark color scheme for navigation elements if this view is in a NavStack
    }
}
