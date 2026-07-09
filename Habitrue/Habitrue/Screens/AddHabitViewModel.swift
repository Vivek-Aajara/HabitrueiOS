import SwiftUI

@MainActor
final class AddHabitViewModel: ObservableObject {
    @Published var name = ""
    @Published var note = ""
    @Published var frequency: HabitFrequency = .daily
    @Published var icon = "🎯"
    @Published var color: Color = AppTheme.accent
    @Published var hasLocationAnchor = false

    var isValid: Bool { !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

    func buildHabit() -> Habit {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedNote = note.trimmingCharacters(in: .whitespacesAndNewlines)

        return Habit(
            title: trimmedName,
            subtitleLocalized: frequency.label,
            emoji: icon,
            prompt: trimmedNote.isEmpty ? "Complete \(trimmedName) today to keep your streak alive." : trimmedNote,
            frequency: frequency,
            color: color
        )
    }
}
