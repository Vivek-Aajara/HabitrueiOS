import SwiftUI

// Ex. Approach: Button wrapping an HStack — text left, Spacer to push
// nothing right (no chevron here, matches the flat menu style in the design).
struct MenuRow: View {
    let title: String
    var tint: Color = .black
    var isBold: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: isBold ? .bold : .regular))
                .foregroundStyle(tint)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 0) {
        MenuRow(title: "Profile", action: {})
        MenuRow(title: "Settings", action: {})
        MenuRow(title: "Logout", tint: AppTheme.accent, isBold: true, action: {})
    }
    .padding()
}
