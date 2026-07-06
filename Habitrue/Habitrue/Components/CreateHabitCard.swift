import SwiftUI

struct CreateHabitCard: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 14) {
                Circle()
                    .fill(AppTheme.accent)
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(.white)
                    )
                Text("Create your habit")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
            .background(AppTheme.cardDark, in: RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CreateHabitCard(action: {}).padding()
}
