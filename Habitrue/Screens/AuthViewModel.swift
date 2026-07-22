import Foundation

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var loginEmail = ""
    @Published var loginPassword = ""
    @Published var isLoginPasswordRevealed = false

    @Published var firstName = ""
    @Published var lastName = ""
    @Published var signUpEmail = ""
    @Published var signUpPassword = ""
    @Published var isSignUpPasswordRevealed = false

    @Published var isLoading = false
    @Published var errorMessage: String?

    var isLoginValid: Bool {
        loginEmail.contains("@") && loginPassword.count >= 6
    }

    var isSignUpValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty
            && signUpEmail.contains("@") && signUpPassword.count >= 6
    }

    func login(onSuccess: @escaping () -> Void) {
        guard isLoginValid else {
            errorMessage = "Enter a valid email and a password of 6+ characters."
            return
        }
        errorMessage = nil
        isLoading = true

        Task {
            try? await Task.sleep(nanoseconds: 700_000_000)
            isLoading = false
            onSuccess()
        }
    }

    func register(onSuccess: @escaping () -> Void) {
            guard isSignUpValid else {
                errorMessage = "Fill every field with a valid email and 6+ char password."
                return
            }
            errorMessage = nil
            isLoading = true
            Task {
                try? await Task.sleep(nanoseconds: 700_000_000)
                UserProfileStore.shared.firstName = firstName
                UserProfileStore.shared.lastName = lastName
                UserProfileStore.shared.email = signUpEmail
                isLoading = false
                onSuccess()
            }
        }
}
