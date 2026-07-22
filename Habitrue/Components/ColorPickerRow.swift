import SwiftUI

// Ex. Approach: HStack of ForEach over a Color array — each swatch is a
// Circle with a selected-state ring drawn via .overlay, no Button chrome needed.
struct ColorPickerRow: View {
    @Binding var selection: Color
    let colors: [Color] = [
        Color(hex: "6C5CE7"), Color(hex: "00B894"), Color(hex: "E17055"),
        Color(hex: "0984E3"), Color(hex: "FDCB6E"), Color(hex: "E84393")
    ]

    var body: some View {
        HStack(spacing: 14) {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .fill(color)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.textPrimary.opacity(selection == color ? 0.6 : 0), lineWidth: 2)
                            .padding(-4)
                    )
                    .appGlassCircle(tint: color)
                    .onTapGesture { selection = color }
            }
        }
    }
}

#Preview {
    ColorPickerRow(selection: .constant(Color(hex: "6C5CE7"))).padding()
}
