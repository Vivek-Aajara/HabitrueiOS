import SwiftUI

struct AppGlassEffectContainer<Content: View>: View {
    let spacing: CGFloat?
    @ViewBuilder let content: Content

    init(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        if #available(iOS 26.0, *) {
            GlassEffectContainer(spacing: spacing) {
                content
            }
        } else {
            content
        }
    }
}

extension View {
    @ViewBuilder
    func appGlassCard(cornerRadius: CGFloat = AppTheme.cornerRadius, tint: Color = AppTheme.cardLight) -> some View {
        if #available(iOS 26.0, *) {
            self
                .background(tint.opacity(0.24), in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .glassEffect(.regular.tint(tint.opacity(0.35)), in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        } else {
            self.background(tint, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
    }

    @ViewBuilder
    func appGlassControl(cornerRadius: CGFloat = 14, tint: Color = AppTheme.fieldBackground, isInteractive: Bool = true) -> some View {
        if #available(iOS 26.0, *) {
            self
                .background(tint.opacity(0.22), in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .glassEffect(
                    isInteractive ? .regular.tint(tint.opacity(0.35)).interactive() : .regular.tint(tint.opacity(0.35)),
                    in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                )
        } else {
            self.background(tint, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
    }

    @ViewBuilder
    func appGlassCircle(tint: Color, isInteractive: Bool = true) -> some View {
        if #available(iOS 26.0, *) {
            self
                .background(tint.opacity(0.22), in: Circle())
                .glassEffect(
                    isInteractive ? .regular.tint(tint.opacity(0.35)).interactive() : .regular.tint(tint.opacity(0.35)),
                    in: Circle()
                )
        } else {
            self.background(tint, in: Circle())
        }
    }
}
