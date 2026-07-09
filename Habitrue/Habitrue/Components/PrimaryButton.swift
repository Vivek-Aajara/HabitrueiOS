import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isLoading: Bool = false
    var isDisabled: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Group {
                if isLoading {
                    ProgressView().tint(AppTheme.textOnAccent)
                } else {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .foregroundStyle(AppTheme.textOnAccent)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .appGlassControl(cornerRadius: 16, tint: isDisabled ? AppTheme.textSecondary.opacity(0.45) : AppTheme.accent)
            .opacity(isDisabled ? 0.72 : 1)
        }
        .buttonStyle(.plain)
        .disabled(isLoading || isDisabled)
    }
}

#Preview {
    VStack(spacing: 12) {
        PrimaryButton(title: "Login", action: {})
        PrimaryButton(title: "Loading", isLoading: true, action: {})
        PrimaryButton(title: "Disabled", isDisabled: true, action: {})
    }
    .padding()
}
