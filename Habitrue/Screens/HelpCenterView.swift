import SwiftUI

struct HelpCenterView: View {
    @Environment(\.dismiss) private var dismiss

    private let faqs: [(q: String, a: String)] = [
        ("How do location-based reminders work?", "Habitue anchors a habit to a place. When you arrive, it surfaces at the top of your feed and can send a notification."),
        ("Why isn't my location habit triggering?", "Check that location permission is set to \"Always\" in iOS Settings and that background app refresh is enabled for Habitue."),
        ("Can I edit a habit's location later?", "Yes — open the habit and update its location anchor from the edit screen."),
        ("Is my data private?", "All habit and location data stays on your device. Nothing is uploaded to a server.")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderBar(title: "Help Center") { dismiss() }

            ScrollView {
                VStack(spacing: 16) {
                    SettingsSection(title: "FAQ") {
                        VStack(spacing: 0) {
                            ForEach(faqs.indices, id: \.self) { index in
                                DisclosureGroup(faqs[index].q) {
                                    Text(faqs[index].a)
                                        .font(.system(size: 14))
                                        .foregroundStyle(AppTheme.textSecondary)
                                        .padding(.top, 6)
                                }
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(AppTheme.textPrimary)
                                .padding(16)

                                if index < faqs.count - 1 {
                                    Divider().padding(.leading, 16)
                                }
                            }
                        }
                    }

                    SettingsSection(title: "CONTACT") {
                        SettingsRow(title: "Email Support", action: {})
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
    HelpCenterView()
}
