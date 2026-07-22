import SwiftUI

struct ProfileView: View {
    @ObservedObject var profile: UserProfileStore
    let streakDays: Int
    let completedHabits: Int
    let totalHabits: Int
    @Environment(\.dismiss) private var dismiss
    @State private var showPersonalInfo = false
    @State private var showSecurity = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScreenHeaderBar(title: "Profile") { dismiss() }

                ScrollView {
                    VStack(spacing: 20) {
                        Circle()
                            .fill(LinearGradient(colors: [.orange.opacity(0.35), .pink.opacity(0.35)], startPoint: .top, endPoint: .bottom))
                            .frame(width: 92, height: 92)
                            .appGlassCircle(tint: .orange, isInteractive: false)
                            .overlay(Text(profile.avatarEmoji).font(.system(size: 44)))

                        VStack(spacing: 4) {
                            Text(profile.displayName)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(AppTheme.textPrimary)
                            if !profile.email.isEmpty {
                                Text(profile.email)
                                    .font(.system(size: 14))
                                    .foregroundStyle(AppTheme.textSecondary)
                            }
                        }

                        HStack(spacing: 14) {
                            statCard(value: "\(streakDays)", label: "Day streak")
                            statCard(value: "\(completedHabits)/\(totalHabits)", label: "Today")
                        }

                        SettingsSection(title: "ACCOUNT") {
                            SettingsRow(title: "Personal Information") { showPersonalInfo = true }
                            Divider().padding(.leading, 16)
                            SettingsRow(title: "Security & Password") { showSecurity = true }
                        }
                    }
                    .padding(AppTheme.padding)
                }
            }
            .background(AppTheme.appBackground)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $showPersonalInfo) { PersonalInformationView(profile: profile) }
            .navigationDestination(isPresented: $showSecurity) { SecurityPasswordView() }
        }
    }

    private func statCard(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value).font(.system(size: 22, weight: .bold)).foregroundStyle(AppTheme.textPrimary)
            Text(label).font(.system(size: 12)).foregroundStyle(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .appGlassCard(cornerRadius: 16)
    }
}

#Preview {
    ProfileView(profile: .shared, streakDays: 10, completedHabits: 2, totalHabits: 4)
}
