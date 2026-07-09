import SwiftUI

// Ex. Approach: NavigationStack wraps the ScrollView backbone so Settings
// can be pushed; the profile menu is a separate .overlay layer (dim scrim +
// slide-over panel) rather than a sheet, matching the trailing-edge drawer
// look in the design instead of a bottom sheet.
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    var onLogout: () -> Void = {}

    var body: some View {
        NavigationStack {
            ScrollView {
                AppGlassEffectContainer(spacing: AppTheme.spacing) {
                    VStack(spacing: AppTheme.spacing) {
                        HomeHeaderView(title: "Habitrue", dateText: viewModel.todayText) {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                viewModel.isProfileMenuPresented = true
                            }
                        }

                        CreateHabitCard {
                            viewModel.isPresentingNewHabit = true
                        }

                        WeekProgressCard(
                            kicker: "改善",
                            heading: "This week",
                            subKicker: "今週",
                            days: viewModel.weekDays
                        )

                        StreakCard(
                            days: viewModel.streakDays,
                            kanji: "日",
                            quote: "Success is the sum of small efforts, repeated day in and day out."
                        )

                        sectionHeader

                        if viewModel.todayHabits.isEmpty {
                            EmptyHabitsView {
                                viewModel.isPresentingNewHabit = true
                            }
                        } else {
                            ForEach(viewModel.todayHabits) { habit in
                                TodayHabitCard(habit: habit) {
                                    viewModel.toggleDone(habit)
                                }
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
                AddHabitView { habit in
                    viewModel.addHabit(habit)
                }
            }
            .navigationDestination(isPresented: $viewModel.showSettings) {
                SettingsView(onLogout: onLogout)
            }
            .overlay {
                if viewModel.isProfileMenuPresented {
                    profileMenuOverlay
                }
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
                    withAnimation(.easeInOut(duration: 0.25)) {
                        viewModel.isProfileMenuPresented = false
                    }
                }

            ProfileMenuView(
                userName: viewModel.userName,
                tagline: viewModel.userTagline,
                onClose: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        viewModel.isProfileMenuPresented = false
                    }
                },
                onProfileTap: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        viewModel.isProfileMenuPresented = false
                    }
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
