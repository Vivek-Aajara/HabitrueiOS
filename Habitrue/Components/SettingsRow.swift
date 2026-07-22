import SwiftUI

// Ex. Approach: Button > HStack [title, Spacer, chevron] — identical skeleton
// to MenuRow but with a trailing affordance, since this row navigates further.
struct SettingsRow: View {
    let title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundStyle(AppTheme.textPrimary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppTheme.textSecondary.opacity(0.6))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SettingsRow(title: "Personal Information", action: {}).padding()
}
