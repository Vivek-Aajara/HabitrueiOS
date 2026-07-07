import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    var onLoginSuccess: () -> Void
    var onSignUpTapped: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer(minLength: 40)

                Image("HabitrueLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 84, height: 84)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

                VStack(spacing: 6) {
                    Text("Welcome Back")
                        .font(.system(size: 30, weight: .bold))
                    Text("Please sign in to continue")
                        .font(.system(size: 16))
                        .foregroundStyle(AppTheme.textSecondary)
                }

                VStack(spacing: 14) {
                    AuthTextField(icon: "envelope.fill", placeholder: "Email Address",
                                  text: $viewModel.loginEmail)

                    AuthTextField(icon: "lock.fill", placeholder: "Password",
                                  text: $viewModel.loginPassword,
                                  isSecure: true, isRevealed: $viewModel.isLoginPasswordRevealed)

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.system(size: 13))
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    PrimaryButton(title: "Login", isLoading: viewModel.isLoading) {
                        viewModel.login(onSuccess: onLoginSuccess)
                    }
                }
                .padding(20)
                .background(AppTheme.cardLight, in: RoundedRectangle(cornerRadius: AppTheme.cornerRadius))

                Spacer(minLength: 30)

                Button(action: onSignUpTapped) {
                    (Text("Don't have an account? ")
                        .foregroundStyle(AppTheme.textSecondary)
                     + Text("Sign Up")
                        .foregroundStyle(AppTheme.accent)
                        .fontWeight(.semibold))
                    .font(.system(size: 15))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, AppTheme.padding)
            .padding(.top, 12)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    LoginView(viewModel: AuthViewModel(), onLoginSuccess: {}, onSignUpTapped: {})
}
