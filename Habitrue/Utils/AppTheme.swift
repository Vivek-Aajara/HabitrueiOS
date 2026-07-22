import SwiftUI
import UIKit

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

    init(light: Color, dark: Color) {
        self.init(UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}

enum AppTheme {
    static let background = Color(light: Color(hex: "F2F2F5"), dark: Color(hex: "080A12"))
    static let backgroundTop = Color(light: Color(hex: "F8F8FB"), dark: Color(hex: "15172A"))
    static let backgroundBottom = Color(light: Color(hex: "ECEEF6"), dark: Color(hex: "05060B"))

    static let cardDark = Color(light: Color(hex: "17162A"), dark: Color(hex: "23243B"))
    static let cardLight = Color(light: .white, dark: Color(hex: "171927"))
    static let fieldBackground = Color(light: Color(hex: "E8E9F0"), dark: Color(hex: "252838"))

    static let accent = Color(hex: "6C5CE7")
    static let accentSecondary = Color(hex: "00CEC9")
    static let warning = Color(hex: "FDCB6E")

    static let textPrimary = Color(light: Color(hex: "151522"), dark: Color(hex: "F5F6FF"))
    static let textSecondary = Color(light: Color(hex: "8E8E93"), dark: Color(hex: "A7AABC"))
    static let textOnAccent = Color.white
    static let divider = Color(light: Color.black.opacity(0.08), dark: Color.white.opacity(0.10))
    static let scrim = Color(light: Color.black.opacity(0.35), dark: Color.black.opacity(0.58))

    static let cornerRadius: CGFloat = 24
    static let spacing: CGFloat = 16
    static let padding: CGFloat = 18

    static var appBackground: some View {
        LinearGradient(
            colors: [backgroundTop, background, backgroundBottom],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
