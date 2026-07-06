import SwiftUI

enum AppRoute {
    case splash
    case home
}

struct RootView: View {
    @State private var route: AppRoute = .splash

    var body: some View {
        ZStack {
            switch route {
            case .splash:
                SplashView { route = .home }
                    .transition(.opacity)
            case .home:
                HomeView()
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    RootView()
}
