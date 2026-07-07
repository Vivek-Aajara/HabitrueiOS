import Foundation

enum HabitFrequency: Hashable {
    case daily
    case weekly
    case timesPerWeek(Int)

    var label: String {
        switch self {
        case .daily: return "Daily"
        case .weekly: return "Weekly"
        case .timesPerWeek(let n): return "\(n)x / week"
        }
    }
}
