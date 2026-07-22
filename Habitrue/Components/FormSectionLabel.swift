import SwiftUI

// Ex. Approach: single Text with consistent styling, extracted so every
// form section header in AddHabitView looks identical without repeating modifiers.
struct FormSectionLabel: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(AppTheme.textSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    FormSectionLabel(title: "Frequency").padding()
}
