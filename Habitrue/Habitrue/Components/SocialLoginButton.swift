import SwiftUI

struct SocialLoginButton: View {
    let symbol: String       
    let label: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: symbol)
                    .font(.system(size: 16, weight: .semibold))
                Text(label)
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(AppTheme.fieldBackground, in: RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: 12) {
        SocialLoginButton(symbol: "g.circle.fill", label: "Google")
        SocialLoginButton(symbol: "f.circle.fill", label: "Facebook")
    }
    .padding()
}
