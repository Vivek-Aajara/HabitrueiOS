import SwiftUI

// Ex. Approach: same single-enum switcher as before, just more cases.
// One shared AuthViewModel instance lives here so switching login<->signUp
// doesn't lose typed-in state.
enum AppRoute {
    case splash
    case login
    case signUp
    case home
}

struct RootView: View {
    @State private var route: AppRoute = .splash
    @StateObject private var authViewModel = AuthViewModel()
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false

    var body: some View {
        ZStack {
            switch route {
            case .splash:
                SplashView { route = .login }
                    .transition(.opacity)
            case .login:
                LoginView(
                    viewModel: authViewModel,
                    onLoginSuccess: { route = .home },
                    onSignUpTapped: { route = .signUp }
                )
                .transition(.opacity)
            case .signUp:
                SignUpView(
                    viewModel: authViewModel,
                    onRegisterSuccess: { route = .home },
                    onLoginTapped: { route = .login }
                )
                .transition(.opacity)
            case .home:
                HomeView(onLogout: { route = .login })
                    .transition(.opacity)
            }
        }
        .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        .tint(AppTheme.accent)
        .animation(.easeInOut(duration: 0.25), value: isDarkModeEnabled)
    }
}

#Preview {
    RootView()
}
