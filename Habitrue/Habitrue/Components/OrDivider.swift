import SwiftUI

struct OrDivider: View {
    var body: some View {
        HStack(spacing: 12) {
            Rectangle().fill(AppTheme.textSecondary.opacity(0.25)).frame(height: 1)
            Text("OR")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(AppTheme.textSecondary)
            Rectangle().fill(AppTheme.textSecondary.opacity(0.25)).frame(height: 1)
        }
    }
}

#Preview {
    OrDivider().padding()
}
