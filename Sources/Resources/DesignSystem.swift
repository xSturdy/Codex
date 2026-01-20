import UIKit

enum DesignSystem {
    static let backgroundColor = UIColor(red: 0.97, green: 0.95, blue: 0.92, alpha: 1.0)
    static let cardColor = UIColor.white
    static let primaryText = UIColor(red: 0.25, green: 0.2, blue: 0.15, alpha: 1.0)
    static let secondaryText = UIColor(red: 0.45, green: 0.4, blue: 0.34, alpha: 1.0)
    static let accentColor = UIColor(red: 0.73, green: 0.35, blue: 0.23, alpha: 1.0)
    static let mutedColor = UIColor(red: 0.93, green: 0.9, blue: 0.86, alpha: 1.0)

    static func applyCardShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
    }
}
