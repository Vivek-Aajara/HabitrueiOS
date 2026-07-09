import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: AuthViewModel
    var onRegisterSuccess: () -> Void
    var onLoginTapped: () -> Void

    var body: some View {
        ScrollView {
            AppGlassEffectContainer(spacing: 22) {
                VStack(spacing: 22) {
                    Spacer(minLength: 24)

                    Image("HabitrueLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 84, height: 84)
                        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                        .shadow(color: AppTheme.accent.opacity(0.18), radius: 18, y: 8)

                    VStack(spacing: 6) {
                        Text("Create Account")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(AppTheme.textPrimary)
                        Text("Start your journey with us")
                            .font(.system(size: 16))
                            .foregroundStyle(AppTheme.textSecondary)
                    }

                    VStack(spacing: 14) {
                        HStack(spacing: 12) {
                            AuthTextField(icon: "person.fill", placeholder: "First Name", text: $viewModel.firstName)
                            AuthTextField(icon: "person.fill", placeholder: "Last Name", text: $viewModel.lastName)
                        }

                        AuthTextField(icon: "envelope.fill", placeholder: "Email Address", text: $viewModel.signUpEmail)

                        AuthTextField(
                            icon: "lock.fill",
                            placeholder: "Password",
                            text: $viewModel.signUpPassword,
                            isSecure: true,
                            isRevealed: $viewModel.isSignUpPasswordRevealed
                        )

                        if let error = viewModel.errorMessage {
                            Text(error)
                                .font(.system(size: 13))
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        PrimaryButton(
                            title: "Register",
                            isLoading: viewModel.isLoading,
                            isDisabled: !viewModel.isSignUpValid
                        ) {
                            viewModel.register(onSuccess: onRegisterSuccess)
                        }
                    }
                    .padding(20)
                    .appGlassCard()

                    OrDivider()

                    HStack(spacing: 12) {
                        SocialLoginButton(symbol: "g.circle.fill", label: "Google")
                        SocialLoginButton(symbol: "f.circle.fill", label: "Facebook")
                    }

                    Button(action: onLoginTapped) {
                        (Text("Already have an account? ")
                            .foregroundStyle(AppTheme.textSecondary)
                         + Text("Login")
                            .foregroundStyle(AppTheme.accent)
                            .fontWeight(.semibold))
                        .font(.system(size: 15))
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 12)
                }
                .padding(.horizontal, AppTheme.padding)
                .padding(.top, 12)
            }
        }
        .background(AppTheme.appBackground)
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    SignUpView(viewModel: AuthViewModel(), onRegisterSuccess: {}, onLoginTapped: {})
}
