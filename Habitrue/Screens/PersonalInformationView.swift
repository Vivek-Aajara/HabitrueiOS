import SwiftUI

struct PersonalInformationView: View {
    @ObservedObject var profile: UserProfileStore
    @Environment(\.dismiss) private var dismiss
    @State private var isSaved = false

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderBar(title: "Personal Information") { dismiss() }

            ScrollView {
                VStack(spacing: 20) {
                    AuthTextField(icon: "person.fill", placeholder: "First Name", text: $profile.firstName)
                    AuthTextField(icon: "person.fill", placeholder: "Last Name", text: $profile.lastName)
                    AuthTextField(icon: "envelope.fill", placeholder: "Email Address", text: $profile.email)

                    PrimaryButton(title: isSaved ? "Saved" : "Save Changes") {
                        isSaved = true
                        Task {
                            try? await Task.sleep(nanoseconds: 1_200_000_000)
                            isSaved = false
                        }
                    }
                }
                .padding(AppTheme.padding)
            }
        }
        .background(AppTheme.appBackground)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PersonalInformationView(profile: .shared)
}
