import SwiftUI

struct ProfileMenuView: View {
    let userName: String
    let tagline: String
    var avatarEmoji: String = "🧑🏽"
    var onClose: () -> Void
    var onProfileTap: () -> Void
    var onSettingsTap: () -> Void
    var onLogoutTap: () -> Void

    var body: some View {
        AppGlassEffectContainer(spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(AppTheme.textPrimary)
                    }
                    .buttonStyle(.plain)
                }

                Circle()
                    .fill(LinearGradient(colors: [.orange.opacity(0.35), .pink.opacity(0.35)], startPoint: .top, endPoint: .bottom))
                    .frame(width: 84, height: 84)
                    .appGlassCircle(tint: .orange, isInteractive: false)
                    .overlay(Text(avatarEmoji).font(.system(size: 40)))

                VStack(alignment: .leading, spacing: 4) {
                    Text(userName)
                        .font(.system(size: 26, weight: .bold))
                    Text(tagline)
                        .font(.system(size: 16))
                        .foregroundStyle(AppTheme.textSecondary)
                }

                Divider()

                VStack(spacing: 0) {
                    MenuRow(title: "Profile", action: onProfileTap)
                    Divider()
                    MenuRow(title: "Settings", action: onSettingsTap)
                    Divider()
                    MenuRow(title: "Logout", tint: AppTheme.accent, isBold: true, action: onLogoutTap)
                }

                Spacer()
            }
            .padding(20)
            .padding(.top, 8)
            .frame(maxHeight: .infinity, alignment: .top)
            .appGlassCard(cornerRadius: 0)
        }
    }
}

#Preview {
    ProfileMenuView(
        userName: "Vivek", tagline: "Keep your streak alive",
        onClose: {}, onProfileTap: {}, onSettingsTap: {}, onLogoutTap: {}
    )
}
