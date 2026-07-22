import SwiftUI

struct ScreenHeaderBar: View {
    let title: String
    var onBack: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(AppTheme.textPrimary)
            }
            .buttonStyle(.plain)

            Text(title)
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)

            Spacer()
        }
        .padding(.horizontal, AppTheme.padding)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
}

#Preview {
    ScreenHeaderBar(title: "Title", onBack: {})
}
