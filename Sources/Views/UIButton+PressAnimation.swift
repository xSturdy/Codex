import UIKit

extension UIButton {
    func animatePress() {
        UIView.animate(withDuration: 0.12, animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            self.alpha = 0.85
        }) { _ in
            UIView.animate(withDuration: 0.12) {
                self.transform = .identity
                self.alpha = 1.0
            }
        }
    }
}
