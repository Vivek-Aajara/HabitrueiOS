import SwiftUI

struct CreateHabitCard: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 14) {
                Circle()
                    .fill(AppTheme.accent.opacity(0.72))
                    .frame(width: 56, height: 56)
                    .appGlassCircle(tint: AppTheme.accent)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(AppTheme.textOnAccent)
                    )
                Text("Create your habit")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppTheme.textOnAccent)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
            .appGlassCard(tint: AppTheme.accent)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CreateHabitCard(action: {}).padding()
}
