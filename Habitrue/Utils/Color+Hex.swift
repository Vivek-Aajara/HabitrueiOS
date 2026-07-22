import SwiftUI
import UIKit

// init(hex:) already exists in AppTheme.swift — only add the reverse conversion here.
extension Color {
    var hexString: String {
        guard let c = UIColor(self).cgColor.components, c.count >= 3 else { return "007AFF" }
        return String(format: "%02X%02X%02X", Int(c[0] * 255), Int(c[1] * 255), Int(c[2] * 255))
    }
}
