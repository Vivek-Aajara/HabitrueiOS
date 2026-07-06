import SwiftUI

struct TodayHabitCard: View {
    let habit: Habit
    var onMarkDone: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(habit.title)
                        .font(.system(size: 19, weight: .bold))
                    Text(habit.subtitleLocalized)
                        .font(.system(size: 13))
                        .foregroundStyle(AppTheme.textSecondary)
                }
                Spacer()
                Circle()
                    .fill(Color.blue.opacity(0.15))
                    .frame(width: 48, height: 48)
                    .overlay(Text(habit.emoji).font(.system(size: 22)))
            }

            Text(habit.prompt)
                .font(.system(size: 15))
                .foregroundStyle(.black.opacity(0.75))

            Button(action: onMarkDone) {
                Text(habit.isDone ? "Habit done ✓" : "Mark habit done")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(AppTheme.accent, in: RoundedRectangle(cornerRadius: 18))
            }
            .buttonStyle(.plain)
        }
        .padding(AppTheme.padding)
        .background(AppTheme.cardLight, in: RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }
}

#Preview {
    TodayHabitCard(
        habit: Habit(title: "Morning focus routine", subtitleLocalized: "朝の集中",
                     emoji: "⛩️", prompt: "Complete one small action today to keep your streak alive."),
        onMarkDone: {}
    ).padding()
}
