import SwiftUI

struct TodayHabitCard: View {
    let habit: Habit
    var onMarkDone: () -> Void
    var onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 14) {
                Text(habit.emoji)
                    .font(.system(size: 28))
                    .frame(width: 58, height: 58)
                    .appGlassCircle(tint: habit.color, isInteractive: false)

                VStack(alignment: .leading, spacing: 5) {
                    Text(habit.title)
                        .font(.system(size: 19, weight: .bold))
                        .foregroundStyle(AppTheme.textPrimary)
                        .lineLimit(2)

                    Text(habit.subtitleLocalized.isEmpty ? habit.frequency.label : habit.subtitleLocalized)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(habit.color)
                }

                Spacer(minLength: 8)

                if habit.isDone {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(habit.color)
                }

                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppTheme.textSecondary)
                        .frame(width: 32, height: 32)
                        .appGlassCircle(tint: AppTheme.textSecondary, isInteractive: false)
                }
                .buttonStyle(.plain)
            }

            Text(habit.prompt)
                .font(.system(size: 15))
                .foregroundStyle(AppTheme.textPrimary.opacity(0.78))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 2)

            Button(action: onMarkDone) {
                HStack(spacing: 8) {
                    Image(systemName: habit.isDone ? "arrow.uturn.backward.circle.fill" : "checkmark.circle.fill")
                        .font(.system(size: 17, weight: .semibold))
                    Text(habit.isDone ? "Undo completion" : "Mark habit done")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundStyle(AppTheme.textOnAccent)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .appGlassControl(cornerRadius: 18, tint: habit.isDone ? habit.color : AppTheme.accent)
            }
            .buttonStyle(.plain)
        }
        .padding(20)
        .appGlassCard()
    }
}

#Preview {
    TodayHabitCard(
        habit: Habit(title: "Morning focus routine", subtitleLocalized: "Daily", emoji: "⛩️",
                     prompt: "Complete one small action today to keep your streak alive."),
        onMarkDone: {}, onDelete: {}
    )
    .padding()
}
