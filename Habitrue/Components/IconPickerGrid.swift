import SwiftUI

struct IconPickerGrid: View {
    @Binding var selection: String

    private let icons: [HabitIconOption] = [
        HabitIconOption(emoji: "🏃", title: "Run"),
        HabitIconOption(emoji: "📖", title: "Read"),
        HabitIconOption(emoji: "💧", title: "Water"),
        HabitIconOption(emoji: "🧘", title: "Mindful"),
        HabitIconOption(emoji: "🥗", title: "Food"),
        HabitIconOption(emoji: "😴", title: "Sleep"),
        HabitIconOption(emoji: "✍️", title: "Write"),
        HabitIconOption(emoji: "🎯", title: "Focus"),
        HabitIconOption(emoji: "🎸", title: "Music"),
        HabitIconOption(emoji: "🧹", title: "Tidy"),
        HabitIconOption(emoji: "💪", title: "Train"),
        HabitIconOption(emoji: "🌿", title: "Calm")
    ]

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(icons) { icon in
                let isSelected = selection == icon.emoji

                Button {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.75)) {
                        selection = icon.emoji
                    }
                } label: {
                    VStack(spacing: 6) {
                        Text(icon.emoji)
                            .font(.system(size: 26))
                            .frame(width: 44, height: 36)

                        Text(icon.title)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(isSelected ? AppTheme.textOnAccent : AppTheme.textSecondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)
                    }
                    .frame(maxWidth: .infinity, minHeight: 78)
                    .appGlassControl(cornerRadius: 16, tint: isSelected ? AppTheme.accent.opacity(0.62) : AppTheme.fieldBackground)
                    .overlay(alignment: .topTrailing) {
                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(AppTheme.textOnAccent)
                                .padding(8)
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(isSelected ? AppTheme.accent : AppTheme.divider, lineWidth: isSelected ? 2 : 1)
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(icon.title)
                .accessibilityAddTraits(isSelected ? .isSelected : [])
            }
        }
    }
}

private struct HabitIconOption: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
}

#Preview {
    IconPickerGrid(selection: .constant("🏃")).padding()
}
