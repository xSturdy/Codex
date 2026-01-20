import UIKit

final class TipOfDayView: UIView {
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let tipLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = DesignSystem.mutedColor
        layer.cornerRadius = 18

        iconView.image = UIImage(named: AssetAndLinks.iconLightbulb)
        iconView.tintColor = DesignSystem.accentColor
        iconView.contentMode = .scaleAspectFit

        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = DesignSystem.primaryText

        tipLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        tipLabel.textColor = DesignSystem.secondaryText
        tipLabel.numberOfLines = 0

        let textStack = UIStackView(arrangedSubviews: [titleLabel, tipLabel])
        textStack.axis = .vertical
        textStack.spacing = 4

        let container = UIStackView(arrangedSubviews: [iconView, textStack])
        container.axis = .horizontal
        container.spacing = 12
        container.alignment = .top

        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    func configure(tip: DailyTip) {
        titleLabel.text = "tip_of_day".localized
        tipLabel.text = tip.text
    }
}
