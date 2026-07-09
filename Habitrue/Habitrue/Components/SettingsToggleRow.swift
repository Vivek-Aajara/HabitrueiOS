import SwiftUI

// Ex. Approach: HStack [title, Spacer, Toggle] — Toggle bound via @Binding
// so the parent (SettingsView) owns the actual state.
struct SettingsToggleRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(AppTheme.textPrimary)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(AppTheme.accent)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    SettingsToggleRow(title: "Push Notifications", isOn: .constant(true)).padding()
}
