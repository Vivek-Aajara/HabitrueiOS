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

    init(raw: String, timesPerWeek: Int) {
        switch raw {
        case "weekly": self = .weekly
        case "timesPerWeek": self = .timesPerWeek(timesPerWeek)
        default: self = .daily
        }
    }

    var rawKey: String {
        switch self {
        case .daily: return "daily"
        case .weekly: return "weekly"
        case .timesPerWeek: return "timesPerWeek"
        }
    }

    var timesPerWeekValue: Int {
        if case .timesPerWeek(let n) = self { return n }
        return 0
    }
}
