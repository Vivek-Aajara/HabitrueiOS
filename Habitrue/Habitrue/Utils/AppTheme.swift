import SwiftUI

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: s).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

enum AppTheme {
    static let background = Color(hex: "F2F2F5")
    static let cardDark = Color(hex: "17162A")
    static let cardLight = Color.white
    static let accent = Color(hex: "6C5CE7")
    static let textSecondary = Color(hex: "8E8E93")

    static let cornerRadius: CGFloat = 24
    static let spacing: CGFloat = 16
    static let padding: CGFloat = 18
}
