import UIKit

final class ProgramCell: UITableViewCell {
    static let reuseIdentifier = "ProgramCell"

    private let cardView = UIView()
    private let thumbnailView = UIImageView()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let regionsLabel = UILabel()
    private let chevronView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.clear

        cardView.backgroundColor = DesignSystem.cardColor
        cardView.layer.cornerRadius = 18
        DesignSystem.applyCardShadow(to: cardView)

        thumbnailView.backgroundColor = DesignSystem.mutedColor
        thumbnailView.layer.cornerRadius = 12
        thumbnailView.clipsToBounds = true
        thumbnailView.contentMode = .scaleAspectFill

        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = DesignSystem.primaryText
        detailLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        detailLabel.textColor = DesignSystem.secondaryText
        regionsLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        regionsLabel.textColor = DesignSystem.secondaryText
        regionsLabel.numberOfLines = 0

        chevronView.image = UIImage(named: AssetAndLinks.iconChevron)
        chevronView.tintColor = DesignSystem.secondaryText

        let textStack = UIStackView(arrangedSubviews: [titleLabel, detailLabel, regionsLabel])
        textStack.axis = .vertical
        textStack.spacing = 4

        cardView.addSubview(thumbnailView)
        cardView.addSubview(textStack)
        cardView.addSubview(chevronView)
        contentView.addSubview(cardView)

        cardView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        textStack.translatesAutoresizingMaskIntoConstraints = false
        chevronView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            thumbnailView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            thumbnailView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            thumbnailView.widthAnchor.constraint(equalToConstant: 64),
            thumbnailView.heightAnchor.constraint(equalToConstant: 64),

            textStack.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(equalTo: chevronView.leadingAnchor, constant: -12),
            textStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),

            chevronView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            chevronView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            chevronView.widthAnchor.constraint(equalToConstant: 16),
            chevronView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(program: Program) {
        titleLabel.text = program.name
        detailLabel.text = "\(program.durationMinutes) min · \(program.difficulty.rawValue)"
        regionsLabel.text = "\("regions".localized): \(program.regions.map { $0.rawValue }.joined(separator: " • "))"
        thumbnailView.image = UIImage(named: program.imageName)
    }
}
