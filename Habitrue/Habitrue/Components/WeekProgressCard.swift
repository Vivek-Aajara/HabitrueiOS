import SwiftUI

struct WeekProgressCard: View {
    let kicker: String
    let heading: String
    let subKicker: String    
    let days: [WeekDayStatus]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(kicker)
                .font(.system(size: 13))
                .foregroundStyle(AppTheme.textSecondary)
            Text(heading)
                .font(.system(size: 22, weight: .bold))
            Text(subKicker)
                .font(.system(size: 13))
                .foregroundStyle(AppTheme.textSecondary)

            HStack(spacing: 8) {
                ForEach(days) { day in
                    DayPill(day: day)
                }
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppTheme.padding)
        .background(AppTheme.cardLight, in: RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }
}

private struct DayPill: View {
    let day: WeekDayStatus
    var body: some View {
        Text(day.label)
            .font(.system(size: 12, weight: .bold))
            .foregroundStyle(day.isCompleted ? .white : AppTheme.textSecondary.opacity(0.7))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(day.isCompleted ? AppTheme.accent : Color.black.opacity(0.05))
            )
    }
}

#Preview {
    WeekProgressCard(
        kicker: "改善", heading: "This week", subKicker: "今週",
        days: ["SUN","MON","TUE","WED","THU","FRI","SAT"].enumerated().map {
            WeekDayStatus(label: $0.element, isCompleted: $0.offset < 2)
        }
    ).padding()
}
