import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @ObservedObject private var profile = UserProfileStore.shared
    @State private var isProfilePresented = false
    @State private var habitPendingDelete: Habit?
    var onLogout: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
                AppGlassEffectContainer(spacing: AppTheme.spacing) {
                    VStack(spacing: AppTheme.spacing) {
                        HomeHeaderView(title: "Habitrue", dateText: viewModel.todayText, avatarEmoji: profile.avatarEmoji) {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                viewModel.isProfileMenuPresented = true
                            }
                        }

                        CreateHabitCard {
                            viewModel.isPresentingNewHabit = true
                        }

                        WeekProgressCard(kicker: "改善", heading: "This week", subKicker: "今週", days: viewModel.weekDays)

                        StreakCard(days: viewModel.streakDays, kanji: "日",
                                   quote: "Success is the sum of small efforts, repeated day in and day out.")

                        sectionHeader

                        if viewModel.todayHabits.isEmpty {
                            EmptyHabitsView { viewModel.isPresentingNewHabit = true }
                        } else {
                            ForEach(viewModel.todayHabits) { habit in
                                TodayHabitCard(
                                    habit: habit,
                                    onMarkDone: { viewModel.toggleDone(habit) },
                                    onDelete: { habitPendingDelete = habit }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, AppTheme.padding)
                    .padding(.top, 12)
                    .padding(.bottom, 28)
                }
            }
            .background(AppTheme.appBackground)
            .sheet(isPresented: $viewModel.isPresentingNewHabit) {
                AddHabitView { habit in viewModel.addHabit(habit) }
            }
            .sheet(isPresented: $isProfilePresented) {
                ProfileView(
                    profile: profile,
                    streakDays: viewModel.streakDays,
                    completedHabits: viewModel.completedHabitCount,
                    totalHabits: viewModel.todayHabits.count
                )
            }
            .navigationDestination(isPresented: $viewModel.showSettings) {
                SettingsView(onLogout: onLogout)
            }
            .overlay {
                if viewModel.isProfileMenuPresented {
                    profileMenuOverlay
                }
            }
            .confirmationDialog(
                "Delete this habit?",
                isPresented: Binding(get: { habitPendingDelete != nil }, set: { if !$0 { habitPendingDelete = nil } }),
                presenting: habitPendingDelete
            ) { habit in
                Button("Delete", role: .destructive) {
                    viewModel.deleteHabit(habit)
                    habitPendingDelete = nil
                }
                Button("Cancel", role: .cancel) {}
            } message: { habit in
                Text("\"\(habit.title)\" and its streak history will be removed.")
            }
        }
    }

    private var sectionHeader: some View {
        HStack {
            Text("Today's habits")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)
            Spacer()
            Text("\(viewModel.completedHabitCount)/\(viewModel.todayHabits.count)")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(AppTheme.textSecondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .appGlassControl(cornerRadius: 12, tint: AppTheme.fieldBackground, isInteractive: false)
        }
        .padding(.top, 4)
    }

    private var profileMenuOverlay: some View {
        ZStack(alignment: .trailing) {
            AppTheme.scrim
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) { viewModel.isProfileMenuPresented = false }
                }

            ProfileMenuView(
                userName: profile.displayName,
                tagline: viewModel.userTagline,
                avatarEmoji: profile.avatarEmoji,
                onClose: { withAnimation(.easeInOut(duration: 0.25)) { viewModel.isProfileMenuPresented = false } },
                onProfileTap: {
                    viewModel.isProfileMenuPresented = false
                    isProfilePresented = true
                },
                onSettingsTap: {
                    viewModel.isProfileMenuPresented = false
                    viewModel.showSettings = true
                },
                onLogoutTap: onLogout
            )
            .frame(width: 300)
            .ignoresSafeArea()
            .transition(.move(edge: .trailing))
        }
    }
}

private struct EmptyHabitsView: View {
    var action: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(AppTheme.accent)
                .frame(width: 58, height: 58)
                .appGlassCircle(tint: AppTheme.accent, isInteractive: false)

            Text("No habits for today")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)

            Text("Create a habit with an icon, color, and note so it is easy to act on later.")
                .font(.system(size: 14))
                .foregroundStyle(AppTheme.textSecondary)
                .multilineTextAlignment(.center)

            Button(action: action) {
                Text("Create habit")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppTheme.textOnAccent)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .appGlassControl(cornerRadius: 16, tint: AppTheme.accent)
            }
            .buttonStyle(.plain)
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity)
        .padding(22)
        .appGlassCard()
    }
}

#Preview {
    HomeView()
}
