import SwiftUI

// Ex. Approach: VStack for [kicker label, card], card itself is a plain
// VStack(spacing:0) so caller-supplied rows control their own dividers —
// keeps this component ignorant of what kind of rows it holds.
struct SettingsSection<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(AppTheme.textSecondary)
                .padding(.horizontal, 4)

            VStack(spacing: 0) {
                content
            }
            .background(AppTheme.cardLight, in: RoundedRectangle(cornerRadius: 18))
        }
    }
}

#Preview {
    SettingsSection(title: "ACCOUNT") {
        SettingsRow(title: "Personal Information", action: {})
        Divider().padding(.leading, 16)
        SettingsRow(title: "Security & Password", action: {})
    }
    .padding()
}
