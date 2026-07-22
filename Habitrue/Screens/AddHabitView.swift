import SwiftUI

struct AddHabitView: View {
    @StateObject private var viewModel = AddHabitViewModel()
    @Environment(\.dismiss) private var dismiss
    var onSave: (Habit) -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                AppGlassEffectContainer(spacing: 18) {
                    VStack(alignment: .leading, spacing: 18) {
                        formCard {
                            FormSectionLabel(title: "Habit name")
                            AuthTextField(icon: "pencil", placeholder: "e.g. Morning run", text: $viewModel.name)
                        }

                        formCard {
                            FormSectionLabel(title: "Note")
                            HabitNoteEditor(text: $viewModel.note)
                        }

                        formCard {
                            FormSectionLabel(title: "Frequency")
                            FrequencyPicker(selection: $viewModel.frequency)
                        }

                        formCard {
                            FormSectionLabel(title: "Icon")
                            IconPickerGrid(selection: $viewModel.icon)
                        }

                        formCard {
                            FormSectionLabel(title: "Color")
                            ColorPickerRow(selection: $viewModel.color)
                                .padding(.vertical, 4)
                        }

                        SettingsToggleRow(title: "Add location anchor", isOn: $viewModel.hasLocationAnchor)
                            .appGlassCard(cornerRadius: 16)
                    }
                    .padding(AppTheme.padding)
                }
            }
            .background(AppTheme.appBackground)
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(AppTheme.textSecondary)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(viewModel.buildHabit())
                        dismiss()
                    }
                    .disabled(!viewModel.isValid)
                    .foregroundStyle(viewModel.isValid ? AppTheme.accent : AppTheme.textSecondary)
                    .fontWeight(.semibold)
                }
            }
        }
    }

    private func formCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            content()
        }
        .padding(14)
        .appGlassCard(cornerRadius: 18)
    }
}

private struct HabitNoteEditor: View {
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text("Why does this habit matter today?")
                    .font(.system(size: 16))
                    .foregroundStyle(AppTheme.textSecondary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
            }

            TextEditor(text: $text)
                .font(.system(size: 16))
                .foregroundStyle(AppTheme.textPrimary)
                .scrollContentBackground(.hidden)
                .frame(minHeight: 104)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
        }
        .appGlassControl(cornerRadius: 14, tint: AppTheme.fieldBackground, isInteractive: false)
    }
}

#Preview {
    AddHabitView(onSave: { _ in })
}
