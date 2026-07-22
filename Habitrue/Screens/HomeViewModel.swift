import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    private let repository: HabitRepository

    @Published var streakDays: Int = 10
    @Published var isPresentingNewHabit = false
    @Published var isProfileMenuPresented = false
    @Published var showSettings = false
    @Published var todayHabits: [Habit] = []

    let userTagline = "Keep your streak alive"

    @Published var weekDays: [WeekDayStatus] = {
        let labels = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        let todayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        return labels.enumerated().map { index, label in
            WeekDayStatus(label: label, isCompleted: index < todayIndex)
        }
    }()

    init(repository: HabitRepository? = nil) {
        self.repository = repository ?? HabitRepository()
        loadHabits()
    }

    func loadHabits() {
        todayHabits = repository.fetchAll()
        updateTodayProgress()
    }

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
        repository.save(todayHabits[index])
        updateTodayProgress()
    }

    func addHabit(_ habit: Habit) {
        repository.save(habit)
        todayHabits.append(habit)
        updateTodayProgress()
    }

    func deleteHabit(_ habit: Habit) {
        repository.delete(habit)
        todayHabits.removeAll { $0.id == habit.id }
        updateTodayProgress()
    }

    private func updateTodayProgress() {
        let todayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        guard weekDays.indices.contains(todayIndex) else { return }
        weekDays[todayIndex].isCompleted = todayHabits.contains { $0.isDone }
    }
}
