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
        return labels.enumerated().map { index, label in
            WeekDayStatus(label: label, isCompleted: index < 2) // Sun & Mon done
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

    func toggleDone(_ habit: Habit) {
        guard let index = todayHabits.firstIndex(where: { $0.id == habit.id }) else { return }
        todayHabits[index].isDone.toggle()
        if todayHabits[index].isDone {
            streakDays += 1
        } else {
            streakDays -= 1
        }
    }

    func addHabit(_ habit: Habit) {
        todayHabits.append(habit)
    }
}
