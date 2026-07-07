import SwiftUI

// Ex. Approach: LazyVGrid with fixed columns — the same grid primitive
// the project doc calls for in the calendar heatmap, applied here at
// smaller scale for a picker instead of a data visualization.
struct IconPickerGrid: View {
    @Binding var selection: String
    let icons = ["🏃", "📖", "💧", "🧘", "🥗", "😴", "✍️", "🎯", "🎸", "🧹"]
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 5)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(icons, id: \.self) { icon in
                let isSelected = selection == icon
                Button {
                    selection = icon
                } label: {
                    Text(icon)
                        .font(.system(size: 22))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isSelected ? AppTheme.accent.opacity(0.18) : AppTheme.fieldBackground)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isSelected ? AppTheme.accent : .clear, lineWidth: 2)
                        )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    IconPickerGrid(selection: .constant("🏃")).padding()
}
