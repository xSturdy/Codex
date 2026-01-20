import UIKit

final class ProgramCardView: UIView {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let regionsLabel = UILabel()
    let startButton = UIButton(type: .system)
    let badgeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = DesignSystem.cardColor
        layer.cornerRadius = 24
        DesignSystem.applyCardShadow(to: self)

        imageView.backgroundColor = DesignSystem.mutedColor
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.textColor = DesignSystem.primaryText

        detailLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        detailLabel.textColor = DesignSystem.secondaryText

        regionsLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        regionsLabel.textColor = DesignSystem.secondaryText
        regionsLabel.numberOfLines = 0

        startButton.setTitle("start".localized, for: .normal)
        startButton.backgroundColor = DesignSystem.accentColor
        startButton.tintColor = UIColor.white
        startButton.layer.cornerRadius = 22
        startButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 28, bottom: 12, right: 28)

        badgeLabel.text = "completed".localized
        badgeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        badgeLabel.textColor = UIColor.white
        badgeLabel.backgroundColor = DesignSystem.accentColor
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.isHidden = true

        let contentStack = UIStackView(arrangedSubviews: [titleLabel, detailLabel, regionsLabel, startButton])
        contentStack.axis = .vertical
        contentStack.spacing = 8
        contentStack.alignment = .leading

        addSubview(imageView)
        addSubview(contentStack)
        addSubview(badgeLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 180),

            contentStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

            badgeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            badgeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            badgeLabel.heightAnchor.constraint(equalToConstant: 24),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 90)
        ])
    }

    func configure(with program: Program, completed: Bool) {
        titleLabel.text = program.name
        detailLabel.text = "\(program.durationMinutes) min · \(program.difficulty.rawValue)"
        regionsLabel.text = "\("regions".localized): \(program.regions.map { $0.rawValue }.joined(separator: " • "))"
        imageView.image = UIImage(named: program.imageName)
        badgeLabel.isHidden = !completed
    }
}
