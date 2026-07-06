import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.spacing) {
                HomeHeaderView(title: "Habitrue", dateText: viewModel.todayText)

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
            Text("New Habit Screen")
        }
    }
}

#Preview {
    HomeView()
}
