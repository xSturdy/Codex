import UIKit

final class StreakView: UIView {
    private let starStack = UIStackView()
    private let label = UILabel()
    private var stars: [UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        starStack.axis = .horizontal
        starStack.spacing = 6
        starStack.alignment = .center
        starStack.distribution = .fillEqually

        for _ in 0..<7 {
            let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
            imageView.tintColor = UIColor.systemBrown
            imageView.contentMode = .scaleAspectFit
            stars.append(imageView)
            starStack.addArrangedSubview(imageView)
        }

        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.label

        let stack = UIStackView(arrangedSubviews: [starStack, label])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func update(streakCount: Int) {
        let filledCount = min(streakCount, 7)
        for (index, star) in stars.enumerated() {
            star.tintColor = index < filledCount ? UIColor.systemBrown : UIColor.systemGray4
        }
        label.text = String(format: "streak_title".localized, streakCount)
    }
}
