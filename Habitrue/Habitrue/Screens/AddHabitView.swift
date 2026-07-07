import SwiftUI

// Ex. Approach: NavigationStack for the sheet's own title + toolbar buttons,
// ScrollView > VStack backbone for the form body — every section pairs a
// FormSectionLabel with one picker component, no inline styling here.
struct AddHabitView: View {
    @StateObject private var viewModel = AddHabitViewModel()
    @Environment(\.dismiss) private var dismiss
    var onSave: (Habit) -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        FormSectionLabel(title: "Habit name")
                        AuthTextField(icon: "pencil", placeholder: "e.g. Morning run",
                                      text: $viewModel.name)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        FormSectionLabel(title: "Frequency")
                        FrequencyPicker(selection: $viewModel.frequency)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        FormSectionLabel(title: "Icon")
                        IconPickerGrid(selection: $viewModel.icon)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        FormSectionLabel(title: "Color")
                        ColorPickerRow(selection: $viewModel.color)
                    }

                    SettingsToggleRow(title: "Add location anchor",
                                      isOn: $viewModel.hasLocationAnchor)
                        .background(AppTheme.cardLight, in: RoundedRectangle(cornerRadius: 14))
                }
                .padding(AppTheme.padding)
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(viewModel.buildHabit())
                        dismiss()
                    }
                    .disabled(!viewModel.isValid)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    AddHabitView(onSave: { _ in })
}
