import UIKit

final class FilterChipCell: UICollectionViewCell {
    static let reuseIdentifier = "FilterChipCell"

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.systemGray6
        contentView.layer.cornerRadius = 16
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.black
        label.textAlignment = .center
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.systemBrown : UIColor.systemGray6
            label.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }

    func configure(title: String) {
        label.text = title
    }
}
