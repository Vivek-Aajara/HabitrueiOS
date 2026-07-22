import SwiftUI

struct SecurityPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var isBiometricEnabled = true
    @State private var errorMessage: String?
    @State private var showSuccess = false

    private var isValid: Bool {
        !currentPassword.isEmpty && newPassword.count >= 6 && newPassword == confirmPassword
    }

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderBar(title: "Security & Password") { dismiss() }

            ScrollView {
                VStack(spacing: 20) {
                    SettingsSection(title: "CHANGE PASSWORD") {
                        VStack(spacing: 14) {
                            AuthTextField(icon: "lock.fill", placeholder: "Current Password", text: $currentPassword, isSecure: true, isRevealed: .constant(false))
                            AuthTextField(icon: "lock.fill", placeholder: "New Password", text: $newPassword, isSecure: true, isRevealed: .constant(false))
                            AuthTextField(icon: "lock.fill", placeholder: "Confirm New Password", text: $confirmPassword, isSecure: true, isRevealed: .constant(false))
                        }
                        .padding(16)
                    }

                    SettingsSection(title: "DEVICE SECURITY") {
                        SettingsToggleRow(title: "Face ID / Touch ID", isOn: $isBiometricEnabled)
                    }

                    if let errorMessage {
                        Text(errorMessage).font(.system(size: 13)).foregroundStyle(.red)
                    }

                    PrimaryButton(title: showSuccess ? "Password Updated" : "Update Password") {
                        guard isValid else {
                            errorMessage = "Enter your current password and a matching new password of 6+ characters."
                            return
                        }
                        errorMessage = nil
                        showSuccess = true
                        currentPassword = ""; newPassword = ""; confirmPassword = ""
                    }
                }
                .padding(AppTheme.padding)
            }
        }
        .background(AppTheme.appBackground)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SecurityPasswordView()
}
