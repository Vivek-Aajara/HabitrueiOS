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
                        kicker: "改善", heading: "This week", subKicker: "今週",
                        days: viewModel.weekDays
                    )

                    StreakCard(
                        days: viewModel.streakDays,
                        kanji: "日",
                        quote: "Success is the sum of small efforts, repeated day in and day out."
                    )

                    Text("Today's habit")
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 4)

                    ForEach(viewModel.todayHabits) { habit in
                        TodayHabitCard(habit: habit) {
                            viewModel.toggleDone(habit)
                        }
                    }
                }
                .padding(.horizontal, AppTheme.padding)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .background(AppTheme.background.ignoresSafeArea())
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

    private var profileMenuOverlay: some View {
        ZStack(alignment: .trailing) {
            Color.black.opacity(0.35)
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

#Preview {
    HomeView()
}
