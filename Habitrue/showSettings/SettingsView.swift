import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    var onLogout: () -> Void = {}
    @Environment(\.dismiss) private var dismiss

    @State private var showPersonalInfo = false
    @State private var showSecurity = false
    @State private var showHelpCenter = false
    @State private var showAbout = false

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderBar(title: "Settings") { dismiss() }

            ScrollView {
                AppGlassEffectContainer(spacing: 24) {
                    VStack(spacing: 24) {
                        SettingsSection(title: "ACCOUNT") {
                            SettingsRow(title: "Personal Information") { showPersonalInfo = true }
                            Divider().padding(.leading, 16)
                            SettingsRow(title: "Security & Password") { showSecurity = true }
                        }

                        SettingsSection(title: "PREFERENCES") {
                            SettingsToggleRow(title: "Push Notifications", isOn: $viewModel.pushNotificationsEnabled)
                            Divider().padding(.leading, 16)
                            SettingsToggleRow(title: "Night Mode", isOn: $isDarkModeEnabled)
                        }

                        SettingsSection(title: "SUPPORT") {
                            SettingsRow(title: "Help Center") { showHelpCenter = true }
                            Divider().padding(.leading, 16)
                            SettingsRow(title: "About Habitrue") { showAbout = true }
                        }

                        PrimaryButton(title: "Log Out", action: onLogout)
                            .padding(.top, 8)

                        Text("Version 1.0.0")
                            .font(.system(size: 13))
                            .foregroundStyle(AppTheme.textSecondary)
                            .padding(.bottom, 16)
                    }
                    .padding(.horizontal, AppTheme.padding)
                }
            }
        }
        .background(AppTheme.appBackground)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showPersonalInfo) { PersonalInformationView(profile: .shared) }
        .navigationDestination(isPresented: $showSecurity) { SecurityPasswordView() }
        .navigationDestination(isPresented: $showHelpCenter) { HelpCenterView() }
        .navigationDestination(isPresented: $showAbout) { AboutHabitrueView() }
    }
}

#Preview {
    SettingsView()
}
