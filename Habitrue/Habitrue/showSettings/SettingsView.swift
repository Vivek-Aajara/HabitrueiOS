import SwiftUI

// Ex. Approach: custom header row (back chevron + title) instead of the
// system nav bar, then ScrollView > VStack of SettingsSection cards —
// same backbone pattern as every other screen in this app.
struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    var onLogout: () -> Void = {}
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black)
                }
                .buttonStyle(.plain)
                Text("Settings")
                    .font(.system(size: 26, weight: .bold))
                Spacer()
            }
            .padding(.horizontal, AppTheme.padding)
            .padding(.top, 8)
            .padding(.bottom, 16)

            ScrollView {
                VStack(spacing: 24) {
                    SettingsSection(title: "ACCOUNT") {
                        SettingsRow(title: "Personal Information", action: {})
                        Divider().padding(.leading, 16)
                        SettingsRow(title: "Security & Password", action: {})
                    }

                    SettingsSection(title: "PREFERENCES") {
                        SettingsToggleRow(title: "Push Notifications",
                                          isOn: $viewModel.pushNotificationsEnabled)
                        Divider().padding(.leading, 16)
                        SettingsToggleRow(title: "Dark Mode",
                                          isOn: $viewModel.darkModeEnabled)
                    }

                    SettingsSection(title: "SUPPORT") {
                        SettingsRow(title: "Help Center", action: {})
                        Divider().padding(.leading, 16)
                        SettingsRow(title: "About Habitrue", action: {})
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
        .background(AppTheme.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SettingsView()
}
