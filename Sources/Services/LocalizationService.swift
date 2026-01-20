import Foundation

extension Notification.Name {
    static let languageDidChange = Notification.Name("languageDidChange")
}

final class LocalizationService {
    static let shared = LocalizationService()

    private let languageKey = "selectedLanguage"

    var currentLanguage: String {
        get { UserDefaults.standard.string(forKey: languageKey) ?? "en" }
        set {
            UserDefaults.standard.set(newValue, forKey: languageKey)
            NotificationCenter.default.post(name: .languageDidChange, object: nil)
        }
    }

    func localizedString(for key: String) -> String {
        let language = currentLanguage
        let fileName = language == "tr" ? "Localization/Localizable.tr" : "Localization/Localizable"
        guard let path = Bundle.main.path(forResource: fileName, ofType: "strings"),
              let dictionary = NSDictionary(contentsOfFile: path) as? [String: String] else {
            return key
        }
        return dictionary[key] ?? key
    }
}

extension String {
    var localized: String {
        LocalizationService.shared.localizedString(for: self)
    }
}
