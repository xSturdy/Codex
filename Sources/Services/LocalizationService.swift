import Foundation

extension Notification.Name {
    static let languageDidChange = Notification.Name("languageDidChange")
}

final class LocalizationService {
    static let shared = LocalizationService()

    private let languageKey = "selectedLanguage"

    var currentLanguage: String {
        get { UserDefaults.standard.string(forKey: languageKey) ?? "tr" }
        set {
            UserDefaults.standard.set(newValue, forKey: languageKey)
            NotificationCenter.default.post(name: .languageDidChange, object: nil)
        }
    }

    func localizedString(for key: String) -> String {
        let language = currentLanguage
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

extension String {
    var localized: String {
        LocalizationService.shared.localizedString(for: self)
    }
}
