import UIKit

final class ProgramCell: UITableViewCell {
    static let reuseIdentifier = "ProgramCell"

    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let regionsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.clear

        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        detailLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        detailLabel.textColor = UIColor.darkGray
        regionsLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        regionsLabel.textColor = UIColor.gray
        regionsLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [titleLabel, detailLabel, regionsLabel])
        stack.axis = .vertical
        stack.spacing = 4
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(program: Program) {
        titleLabel.text = program.name
        detailLabel.text = "\(program.durationMinutes) min · \(program.difficulty.rawValue)"
        regionsLabel.text = "\("regions".localized): \(program.regions.map { $0.rawValue }.joined(separator: " • "))"
    }
}
