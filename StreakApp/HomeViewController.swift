import UIKit

final class HomeViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tabBarView = UIView()
    private let headerStackView = UIStackView()
    private let streakCardView = CardView()
    private let sectionHeaderView = UIStackView()
    private let exerciseCardView = CardView()
    private let tipCardView = CardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        setupScrollView()
        setupHeader()
        setupStreakCard()
        setupExerciseSection()
        setupTipCard()
        setupTabBar()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tabBarView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupHeader() {
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.distribution = .equalSpacing
        headerStackView.translatesAutoresizingMaskIntoConstraints = false

        let titleStack = UIStackView()
        titleStack.axis = .vertical
        titleStack.spacing = 6
        titleStack.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = "Bugün"
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .appTextPrimary

        let dateLabel = UILabel()
        dateLabel.text = "20 Ocak, Cumartesi"
        dateLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dateLabel.textColor = .appTextSecondary

        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(dateLabel)

        let iconStack = UIStackView()
        iconStack.axis = .horizontal
        iconStack.spacing = 12
        iconStack.translatesAutoresizingMaskIntoConstraints = false

        let bellButton = makeCircleIconButton(systemName: "bell.fill")
        let profileButton = makeCircleIconButton(systemName: "person.fill")

        iconStack.addArrangedSubview(bellButton)
        iconStack.addArrangedSubview(profileButton)

        headerStackView.addArrangedSubview(titleStack)
        headerStackView.addArrangedSubview(iconStack)

        contentView.addSubview(headerStackView)

        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            headerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }

    private func setupStreakCard() {
        streakCardView.translatesAutoresizingMaskIntoConstraints = false

        let iconView = UIImageView(image: UIImage(systemName: "flame.fill"))
        iconView.tintColor = .appAccent
        iconView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = "7 Günlük Seri"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .appTextPrimary

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Işılışıl görünüyorsun!"
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subtitleLabel.textColor = .appTextSecondary

        let progressTrack = UIView()
        progressTrack.backgroundColor = .appDivider
        progressTrack.layer.cornerRadius = 4
        progressTrack.translatesAutoresizingMaskIntoConstraints = false

        let progressFill = UIView()
        progressFill.backgroundColor = .appAccent
        progressFill.layer.cornerRadius = 4
        progressFill.translatesAutoresizingMaskIntoConstraints = false

        progressTrack.addSubview(progressFill)

        let countBadge = UILabel()
        countBadge.text = "7"
        countBadge.textAlignment = .center
        countBadge.font = .systemFont(ofSize: 22, weight: .bold)
        countBadge.textColor = .appAccent
        countBadge.backgroundColor = .appBadge
        countBadge.layer.cornerRadius = 28
        countBadge.layer.masksToBounds = true
        countBadge.translatesAutoresizingMaskIntoConstraints = false

        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, progressTrack])
        textStack.axis = .vertical
        textStack.spacing = 10
        textStack.translatesAutoresizingMaskIntoConstraints = false

        streakCardView.addSubview(iconView)
        streakCardView.addSubview(textStack)
        streakCardView.addSubview(countBadge)
        contentView.addSubview(streakCardView)

        NSLayoutConstraint.activate([
            streakCardView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 24),
            streakCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            streakCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            iconView.leadingAnchor.constraint(equalTo: streakCardView.leadingAnchor, constant: 20),
            iconView.topAnchor.constraint(equalTo: streakCardView.topAnchor, constant: 18),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.widthAnchor.constraint(equalToConstant: 24),

            textStack.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(equalTo: countBadge.leadingAnchor, constant: -16),
            textStack.centerYAnchor.constraint(equalTo: streakCardView.centerYAnchor),

            progressTrack.heightAnchor.constraint(equalToConstant: 8),
            progressFill.leadingAnchor.constraint(equalTo: progressTrack.leadingAnchor),
            progressFill.topAnchor.constraint(equalTo: progressTrack.topAnchor),
            progressFill.bottomAnchor.constraint(equalTo: progressTrack.bottomAnchor),
            progressFill.widthAnchor.constraint(equalTo: progressTrack.widthAnchor, multiplier: 0.7),

            countBadge.trailingAnchor.constraint(equalTo: streakCardView.trailingAnchor, constant: -18),
            countBadge.centerYAnchor.constraint(equalTo: streakCardView.centerYAnchor),
            countBadge.heightAnchor.constraint(equalToConstant: 56),
            countBadge.widthAnchor.constraint(equalToConstant: 56),

            streakCardView.bottomAnchor.constraint(equalTo: progressTrack.bottomAnchor, constant: 20)
        ])
    }

    private func setupExerciseSection() {
        sectionHeaderView.axis = .horizontal
        sectionHeaderView.distribution = .equalSpacing
        sectionHeaderView.alignment = .center
        sectionHeaderView.translatesAutoresizingMaskIntoConstraints = false

        let sectionTitle = UILabel()
        sectionTitle.text = "Günün Egzersizi"
        sectionTitle.font = .systemFont(ofSize: 22, weight: .semibold)
        sectionTitle.textColor = .appTextPrimary

        let seeAllButton = UIButton(type: .system)
        seeAllButton.setTitle("Tümünü Gör", for: .normal)
        seeAllButton.setTitleColor(.appLink, for: .normal)
        seeAllButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)

        sectionHeaderView.addArrangedSubview(sectionTitle)
        sectionHeaderView.addArrangedSubview(seeAllButton)

        exerciseCardView.translatesAutoresizingMaskIntoConstraints = false

        let imageView = UIImageView(image: UIImage(systemName: "figure.yoga"))
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.backgroundColor = .appImageBackground
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20

        let completedBadge = BadgeView(text: "TAMAMLANDI", systemImage: "checkmark")
        completedBadge.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = "Şişliği İndir"
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .appTextPrimary

        let descriptionLabel = UILabel()
        descriptionLabel.text = "Yüzündeki ödemi attın ve cildini canlandırdın. Bugünlük harika bir başlangıç yaptın."
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.textColor = .appTextSecondary
        descriptionLabel.numberOfLines = 0

        let primaryButton = UIButton(type: .system)
        primaryButton.setTitle("Tekrar Yap", for: .normal)
        primaryButton.setTitleColor(.white, for: .normal)
        primaryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        primaryButton.backgroundColor = .appAccent
        primaryButton.layer.cornerRadius = 18
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        primaryButton.tintColor = .white
        primaryButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)

        let secondaryStack = UIStackView()
        secondaryStack.axis = .horizontal
        secondaryStack.spacing = 12
        secondaryStack.distribution = .fillEqually
        secondaryStack.translatesAutoresizingMaskIntoConstraints = false

        let changeButton = outlineButton(title: "Değiştir", systemImage: "arrow.left.arrow.right")
        let saveButton = outlineButton(title: "Kaydet", systemImage: "bookmark.fill")

        secondaryStack.addArrangedSubview(changeButton)
        secondaryStack.addArrangedSubview(saveButton)

        exerciseCardView.addSubview(imageView)
        exerciseCardView.addSubview(completedBadge)
        exerciseCardView.addSubview(titleLabel)
        exerciseCardView.addSubview(descriptionLabel)
        exerciseCardView.addSubview(primaryButton)
        exerciseCardView.addSubview(secondaryStack)

        contentView.addSubview(sectionHeaderView)
        contentView.addSubview(exerciseCardView)

        NSLayoutConstraint.activate([
            sectionHeaderView.topAnchor.constraint(equalTo: streakCardView.bottomAnchor, constant: 26),
            sectionHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            sectionHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            exerciseCardView.topAnchor.constraint(equalTo: sectionHeaderView.bottomAnchor, constant: 16),
            exerciseCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            exerciseCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            imageView.topAnchor.constraint(equalTo: exerciseCardView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: exerciseCardView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: exerciseCardView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 220),

            completedBadge.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            completedBadge.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 16),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: exerciseCardView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: exerciseCardView.trailingAnchor, constant: -18),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            primaryButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 18),
            primaryButton.leadingAnchor.constraint(equalTo: exerciseCardView.leadingAnchor, constant: 18),
            primaryButton.trailingAnchor.constraint(equalTo: exerciseCardView.trailingAnchor, constant: -18),
            primaryButton.heightAnchor.constraint(equalToConstant: 52),

            secondaryStack.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: 14),
            secondaryStack.leadingAnchor.constraint(equalTo: primaryButton.leadingAnchor),
            secondaryStack.trailingAnchor.constraint(equalTo: primaryButton.trailingAnchor),
            secondaryStack.heightAnchor.constraint(equalToConstant: 44),
            secondaryStack.bottomAnchor.constraint(equalTo: exerciseCardView.bottomAnchor, constant: -18)
        ])
    }

    private func setupTipCard() {
        tipCardView.translatesAutoresizingMaskIntoConstraints = false
        tipCardView.backgroundColor = .appTipBackground

        let iconCircle = UIView()
        iconCircle.backgroundColor = .white
        iconCircle.layer.cornerRadius = 22
        iconCircle.translatesAutoresizingMaskIntoConstraints = false

        let icon = UIImageView(image: UIImage(systemName: "lightbulb.fill"))
        icon.tintColor = .appLink
        icon.translatesAutoresizingMaskIntoConstraints = false

        iconCircle.addSubview(icon)

        let titleLabel = UILabel()
        titleLabel.text = "Günün İpucu"
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .appTextPrimary

        let tipLabel = UILabel()
        tipLabel.text = "Egzersiz sonrası bol su içmek, yüz kaslarındaki toksinlerin atılmasına yardımcı olur."
        tipLabel.font = .systemFont(ofSize: 14, weight: .regular)
        tipLabel.textColor = .appTextSecondary
        tipLabel.numberOfLines = 0

        let textStack = UIStackView(arrangedSubviews: [titleLabel, tipLabel])
        textStack.axis = .vertical
        textStack.spacing = 6
        textStack.translatesAutoresizingMaskIntoConstraints = false

        tipCardView.addSubview(iconCircle)
        tipCardView.addSubview(textStack)
        contentView.addSubview(tipCardView)

        NSLayoutConstraint.activate([
            tipCardView.topAnchor.constraint(equalTo: exerciseCardView.bottomAnchor, constant: 24),
            tipCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            tipCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            tipCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            iconCircle.leadingAnchor.constraint(equalTo: tipCardView.leadingAnchor, constant: 16),
            iconCircle.topAnchor.constraint(equalTo: tipCardView.topAnchor, constant: 16),
            iconCircle.heightAnchor.constraint(equalToConstant: 44),
            iconCircle.widthAnchor.constraint(equalToConstant: 44),

            icon.centerXAnchor.constraint(equalTo: iconCircle.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: iconCircle.centerYAnchor),

            textStack.leadingAnchor.constraint(equalTo: iconCircle.trailingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(equalTo: tipCardView.trailingAnchor, constant: -16),
            textStack.centerYAnchor.constraint(equalTo: iconCircle.centerYAnchor),
            textStack.bottomAnchor.constraint(lessThanOrEqualTo: tipCardView.bottomAnchor, constant: -16)
        ])
    }

    private func setupTabBar() {
        tabBarView.backgroundColor = .appTabBackground
        tabBarView.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false

        let homeButton = tabButton(title: "Ana Sayfa", systemName: "house.fill", selected: true)
        let exploreButton = tabButton(title: "Keşfet", systemName: "compass", selected: false)
        let analyticsButton = tabButton(title: "Analiz", systemName: "chart.bar", selected: false)
        let profileButton = tabButton(title: "Profil", systemName: "person", selected: false)

        [homeButton, exploreButton, analyticsButton, profileButton].forEach { stack.addArrangedSubview($0) }

        tabBarView.addSubview(stack)

        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 76),

            stack.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -8),
            stack.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: -10)
        ])
    }

    private func makeCircleIconButton(systemName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = .appTextPrimary
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44),
            button.widthAnchor.constraint(equalToConstant: 44)
        ])
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.08
        button.layer.shadowOffset = CGSize(width: 0, height: 6)
        button.layer.shadowRadius = 10
        return button
    }

    private func outlineButton(title: String, systemImage: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.appTextPrimary, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appDivider.cgColor
        button.layer.cornerRadius = 16
        button.setImage(UIImage(systemName: systemImage), for: .normal)
        button.tintColor = .appTextPrimary
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        return button
    }

    private func tabButton(title: String, systemName: String, selected: Bool) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .center
        container.spacing = 4

        let icon = UIImageView(image: UIImage(systemName: systemName))
        icon.tintColor = selected ? .appAccent : .appTextSecondary

        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = selected ? .appAccent : .appTextSecondary

        container.addArrangedSubview(icon)
        container.addArrangedSubview(label)
        return container
    }
}

private final class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.06
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 16
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class BadgeView: UIView {
    init(text: String, systemImage: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.85)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false

        let icon = UIImageView(image: UIImage(systemName: systemImage))
        icon.tintColor = .appSuccess
        icon.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .appSuccess
        label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(icon)
        addSubview(label)

        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 14),
            icon.widthAnchor.constraint(equalToConstant: 14),

            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UIColor {
    static let appBackground = UIColor(red: 0.96, green: 0.94, blue: 0.90, alpha: 1)
    static let appTextPrimary = UIColor(red: 0.35, green: 0.28, blue: 0.21, alpha: 1)
    static let appTextSecondary = UIColor(red: 0.43, green: 0.36, blue: 0.30, alpha: 1)
    static let appAccent = UIColor(red: 0.78, green: 0.37, blue: 0.27, alpha: 1)
    static let appBadge = UIColor(red: 0.97, green: 0.93, blue: 0.89, alpha: 1)
    static let appDivider = UIColor(red: 0.92, green: 0.90, blue: 0.87, alpha: 1)
    static let appLink = UIColor(red: 0.35, green: 0.46, blue: 0.36, alpha: 1)
    static let appImageBackground = UIColor(red: 0.53, green: 0.55, blue: 0.55, alpha: 1)
    static let appTipBackground = UIColor(red: 0.93, green: 0.91, blue: 0.87, alpha: 1)
    static let appTabBackground = UIColor(red: 0.97, green: 0.96, blue: 0.94, alpha: 1)
    static let appSuccess = UIColor(red: 0.36, green: 0.46, blue: 0.36, alpha: 1)
}
