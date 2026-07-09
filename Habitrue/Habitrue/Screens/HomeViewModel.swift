import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var streakDays: Int = 10
    @Published var isPresentingNewHabit = false
    @Published var isProfileMenuPresented = false
    @Published var showSettings = false

    let userName = "Aditya"
    let userTagline = "Keep your streak alive"

    @Published var weekDays: [WeekDayStatus] = {
        let labels = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        let todayIndex = Calendar.current.component(.weekday, from: Date()) - 1

        return labels.enumerated().map { index, label in
            WeekDayStatus(label: label, isCompleted: index < todayIndex)
        }
    }()

    @Published var todayHabits: [Habit] = [
        Habit(
            title: "Morning focus routine",
            subtitleLocalized: "朝の集中",
            emoji: "⛩️",
            prompt: "Complete one small action today to keep your streak alive."
        )
    ]

    var todayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "'Today,' MMMM d"
        return formatter.string(from: Date())
    }

    var completedHabitCount: Int {
        todayHabits.filter(\.isDone).count
    }

    func toggleDone(_ habit: Habit) {
        guard let index = todayHabits.firstIndex(where: { $0.id == habit.id }) else { return }

        todayHabits[index].isDone.toggle()
        streakDays = max(0, streakDays + (todayHabits[index].isDone ? 1 : -1))
        updateTodayProgress()
    }

    func addHabit(_ habit: Habit) {
        todayHabits.append(habit)
        updateTodayProgress()
    }

    private func updateTodayProgress() {
        let todayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        guard weekDays.indices.contains(todayIndex) else { return }

        weekDays[todayIndex].isCompleted = todayHabits.contains { $0.isDone }
    }
}
