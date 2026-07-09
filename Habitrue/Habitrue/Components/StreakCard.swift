import SwiftUI

struct StreakCard: View {
    let days: Int
    let kanji: String
    let quote: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Current streak")
                    .font(.system(size: 15))
                    .foregroundStyle(.white.opacity(0.7))
                Spacer()
                Text("🍁")
                    .font(.system(size: 26))
            }

            Text("\(days) days")
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.white)

            Text(kanji)
                .font(.system(size: 14))
                .foregroundStyle(.white.opacity(0.6))

            Text(quote)
                .font(.system(size: 15))
                .foregroundStyle(.white.opacity(0.85))
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppTheme.padding)
        .appGlassCard(tint: AppTheme.cardDark)
    }
}

#Preview {
    StreakCard(days: 10, kanji: "日", quote: "Success is the sum of small efforts, repeated day in and day out.")
        .padding()
}
