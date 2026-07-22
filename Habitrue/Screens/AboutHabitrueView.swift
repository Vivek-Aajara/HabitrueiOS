import SwiftUI

struct AboutHabitrueView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderBar(title: "About Habitrue") { dismiss() }

            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        Text("⛩️")
                            .font(.system(size: 48))
                            .frame(width: 88, height: 88)
                            .appGlassCircle(tint: AppTheme.accent, isInteractive: false)

                        Text("Habitue")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(AppTheme.textPrimary)

                        Text("Version 1.0.0")
                            .font(.system(size: 13))
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 12)

                    Text("Habitue ties your habits to the places they actually happen. Arrive at the gym and \"Work Out\" surfaces automatically; get home and \"Read for 30 minutes\" is waiting — no generic time-based reminders to ignore.")
                        .font(.system(size: 15))
                        .foregroundStyle(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)

                    SettingsSection(title: "MORE") {
                        SettingsRow(title: "Rate Habitue", action: {})
                        Divider().padding(.leading, 16)
                        SettingsRow(title: "Privacy Policy", action: {})
                        Divider().padding(.leading, 16)
                        SettingsRow(title: "Terms of Service", action: {})
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
    AboutHabitrueView()
}
