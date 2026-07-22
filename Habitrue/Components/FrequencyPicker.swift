import SwiftUI

// Ex. Approach: HStack of ForEach over a fixed option array — each pill is a
// Button whose background swaps based on equality with the bound selection,
// same selected/unselected pattern as the week-day pills on Home.
struct FrequencyPicker: View {
    @Binding var selection: HabitFrequency
    let options: [HabitFrequency] = [.daily, .weekly, .timesPerWeek(3)]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(options, id: \.self) { option in
                let isSelected = selection == option
                Button {
                    selection = option
                } label: {
                    Text(option.label)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(isSelected ? AppTheme.textOnAccent : AppTheme.textSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .appGlassControl(cornerRadius: 12, tint: isSelected ? AppTheme.accent : AppTheme.fieldBackground)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    FrequencyPicker(selection: .constant(.daily)).padding()
}
