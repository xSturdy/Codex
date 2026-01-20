import UIKit

final class ActiveProgramCell: UICollectionViewCell {
    static let reuseIdentifier = "ActiveProgramCell"

    private let titleLabel = UILabel()
    private let progressLabel = UILabel()
    private let progressView = UIProgressView(progressViewStyle: .default)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.shadowRadius = 8
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = UIColor.black
        progressLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        progressLabel.textColor = UIColor.darkGray
        progressView.trackTintColor = UIColor.systemGray5
        progressView.progressTintColor = UIColor.systemBrown

        let stack = UIStackView(arrangedSubviews: [titleLabel, progressLabel, progressView])
        stack.axis = .vertical
        stack.spacing = 8
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(program: Program, active: ActiveProgram) {
        titleLabel.text = program.name
        progressLabel.text = "Day \(active.currentDay)/\(active.planDays)"
        progressView.progress = Float(active.currentDay) / Float(active.planDays)
    }
}
