import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var pushNotificationsEnabled = true
    @Published var darkModeEnabled = false
}
