import Foundation

struct Habit: Identifiable {
    let id = UUID()
    var title: String
    var subtitleLocalized: String
    var emoji: String
    var prompt: String
    var isDone: Bool = false
}

struct WeekDayStatus: Identifiable {
    let id = UUID()
    let label: String   
    var isCompleted: Bool
}
