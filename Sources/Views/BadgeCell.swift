import UIKit

final class BadgeCell: UICollectionViewCell {
    static let reuseIdentifier = "BadgeCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.systemGray6
        contentView.layer.cornerRadius = 16

        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemBrown

        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2

        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .center

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(badge: Badge) {
        titleLabel.text = badge.title
        imageView.image = UIImage(named: badge.imageName) ?? UIImage(systemName: "seal.fill")
    }
}
