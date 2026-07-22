import SwiftUI

struct SplashView: View {
    var onFinished: () -> Void

    @State private var scale: CGFloat = 0.7
    @State private var opacity: Double = 0

    var body: some View {
        ZStack {
            AppTheme.appBackground

            Image("HabitrueLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                .shadow(color: AppTheme.accent.opacity(0.24), radius: 24, y: 12)
                .scaleEffect(scale)
                .opacity(opacity)
        }
        .onAppear {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.7)) {
                scale = 1
                opacity = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    onFinished()
                }
            }
        }
    }
}

#Preview {
    SplashView(onFinished: {})
}
