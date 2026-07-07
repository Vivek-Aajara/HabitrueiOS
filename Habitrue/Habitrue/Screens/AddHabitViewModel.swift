import SwiftUI

@MainActor
final class AddHabitViewModel: ObservableObject {
    @Published var name = ""
    @Published var frequency: HabitFrequency = .daily
    @Published var icon = "🎯"
    @Published var color: Color = AppTheme.accent
    @Published var hasLocationAnchor = false

    var isValid: Bool { !name.trimmingCharacters(in: .whitespaces).isEmpty }

    func buildHabit() -> Habit {
        Habit(
            title: name,
            emoji: icon,
            frequency: frequency,
            color: color
        )
    }
}
