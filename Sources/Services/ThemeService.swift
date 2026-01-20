import UIKit

final class ThemeService {
    static let shared = ThemeService()

    private let themeKey = "isDarkMode"

    var isDarkModeEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: themeKey) }
        set { UserDefaults.standard.set(newValue, forKey: themeKey) }
    }

    func applyTheme(to window: UIWindow?) {
        window?.overrideUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
    }
}
