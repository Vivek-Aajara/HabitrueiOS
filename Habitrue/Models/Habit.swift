import SwiftUI

struct Habit: Identifiable {
    var id: UUID = UUID()
    var title: String
    var subtitleLocalized: String = ""
    var emoji: String = "🎯"
    var prompt: String = "Complete this habit today to keep your streak alive."
    var frequency: HabitFrequency = .daily
    var color: Color = AppTheme.accent
    var isDone: Bool = false
}

struct WeekDayStatus: Identifiable {
    let id = UUID()
    let label: String
    var isCompleted: Bool
}
