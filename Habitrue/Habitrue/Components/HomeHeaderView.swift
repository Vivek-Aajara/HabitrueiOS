import SwiftUI

// Ex. Approach: HStack for horizontal layout (text block vs avatar),
// nested VStack for the stacked title/date text block.
struct HomeHeaderView: View {
    let title: String
    let dateText: String
    var onAvatarTap: () -> Void = {}

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 32, weight: .bold))
                Text(dateText)
                    .font(.system(size: 16))
                    .foregroundStyle(AppTheme.textSecondary)
            }
            Spacer()
            Button(action: onAvatarTap) {
                AvatarView(emoji: "🧑🏽")
            }
            .buttonStyle(.plain)
        }
    }
}

private struct AvatarView: View {
    let emoji: String
    var body: some View {
        Circle()
            .fill(
                LinearGradient(colors: [.orange.opacity(0.35), .pink.opacity(0.35)],
                               startPoint: .top, endPoint: .bottom)
            )
            .frame(width: 48, height: 48)
            .overlay(Text(emoji).font(.system(size: 22)))
    }
}

#Preview {
    HomeHeaderView(title: "Habitrue", dateText: "Today, July 4")
        .padding()
}
