# Habitrue App Readiness

## Current App State

Habitrue now has a complete SwiftUI app shell with splash, login, sign-up, home, add-habit, profile menu, settings, reusable components, Liquid Glass support, and a persisted Night Mode toggle.

## Implemented Readiness Work

- Dynamic light and night color system in `AppTheme`.
- Gradient app background that adapts to light and night mode.
- Persisted Night Mode setting using `@AppStorage("isDarkModeEnabled")`.
- App-wide color-scheme application from `RootView`.
- Liquid Glass helper modifiers with older-iOS fallbacks.
- Reusable glass containers for grouped Liquid Glass rendering.
- Disabled primary button state for invalid login and registration forms.
- Trimmed habit names before saving.
- Safer streak logic that prevents negative streak values.
- Today/week progress updates when habits are marked done.

## App Store Checklist

- Replace mock authentication in `AuthViewModel` with a production auth backend.
- Add Sign in with Apple if third-party login buttons remain visible.
- Remove or implement Google/Facebook buttons before submission.
- Add a privacy policy URL in App Store Connect.
- Add `PrivacyInfo.xcprivacy` if the final app collects, tracks, or accesses protected data.
- Confirm app icon, launch screen, display name, version, and build number.
- Add real screenshots for light and night mode.
- Test on small iPhone, large iPhone, iPad if supported, and dark/light appearances.
- Run a Release build and archive from Xcode.
- Verify no placeholder user name, sample habits, or mock data should ship.

## Production Notes

The current app is UI-ready, but not backend-ready. Login and registration intentionally simulate success. Before App Store submission, connect real account creation, login, logout, data persistence, and privacy disclosures that match the final data behavior.
