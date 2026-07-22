import Foundation

@MainActor
final class UserProfileStore: ObservableObject {
    static let shared = UserProfileStore()

    @Published var firstName: String { didSet { UserDefaults.standard.set(firstName, forKey: "profile.firstName") } }
    @Published var lastName: String { didSet { UserDefaults.standard.set(lastName, forKey: "profile.lastName") } }
    @Published var email: String { didSet { UserDefaults.standard.set(email, forKey: "profile.email") } }
    @Published var avatarEmoji: String { didSet { UserDefaults.standard.set(avatarEmoji, forKey: "profile.avatarEmoji") } }

    private init() {
        let d = UserDefaults.standard
        firstName = d.string(forKey: "profile.firstName") ?? ""
        lastName = d.string(forKey: "profile.lastName") ?? ""
        email = d.string(forKey: "profile.email") ?? ""
        avatarEmoji = d.string(forKey: "profile.avatarEmoji") ?? "🧑🏽"
    }

    var displayName: String {
        let full = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
        return full.isEmpty ? "Guest" : full
    }
}
