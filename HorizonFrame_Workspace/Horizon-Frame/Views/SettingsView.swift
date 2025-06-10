import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: SettingsViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Example Setting", isOn: $viewModel.exampleSetting)
                }
                // Add more settings sections and items here
            }
            .scrollContentBackground(.hidden) // Make Form background transparent
            .background(Color.clear) // Ensure the Form's parent (NavigationView's content area) is also clear
            .navigationTitle("Settings")
        }
        .background(Color.clear) // Attempt to make NavigationView itself transparent, might have limitations
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsViewModel())
    }
}
