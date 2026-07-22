import SwiftUI

struct AuthTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    @Binding var isRevealed: Bool

    init(icon: String, placeholder: String, text: Binding<String>,
         isSecure: Bool = false, isRevealed: Binding<Bool> = .constant(false)) {
        self.icon = icon
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
        self._isRevealed = isRevealed
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(AppTheme.textSecondary)
                .frame(width: 20)

            Group {
                if isSecure && !isRevealed {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .font(.system(size: 16))
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)

            if isSecure {
                Button {
                    isRevealed.toggle()
                } label: {
                    Image(systemName: isRevealed ? "eye.slash" : "eye.slash.fill")
                        .foregroundStyle(AppTheme.textSecondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .appGlassControl(cornerRadius: 14, tint: AppTheme.fieldBackground, isInteractive: false)
    }
}

#Preview {
    VStack(spacing: 14) {
        AuthTextField(icon: "envelope.fill", placeholder: "Email Address", text: .constant(""))
        AuthTextField(icon: "lock.fill", placeholder: "Password", text: .constant(""),
                      isSecure: true, isRevealed: .constant(false))
    }
    .padding()
}
