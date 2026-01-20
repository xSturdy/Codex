import PhotosUI
import UIKit

final class ProfileViewController: UIViewController {
    private let viewModel = ProfileViewModel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let profileImageView = UIImageView()
    private var badgeCollectionView: UICollectionView!

    private enum Setting: Int, CaseIterable {
        case reminder
        case darkMode
        case share
        case language
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "tab_profile".localized
        view.backgroundColor = UIColor.systemBackground
        setupProfileHeader()
        setupTableView()
        setupBadgesCollection()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLanguageChange), name: .languageDidChange, object: nil)
    }

    @objc private func handleLanguageChange() {
        title = "tab_profile".localized
        tableView.reloadData()
    }

    private func setupProfileHeader() {
        profileImageView.image = viewModel.profileImage()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        profileImageView.addGestureRecognizer(tap)

        let headerView = UIView()
        headerView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            profileImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        tableView.tableHeaderView = headerView
        headerView.frame.size.height = 140
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupBadgesCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
        badgeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        badgeCollectionView.backgroundColor = UIColor.clear
        badgeCollectionView.register(BadgeCell.self, forCellWithReuseIdentifier: BadgeCell.reuseIdentifier)
        badgeCollectionView.dataSource = self

        let footerView = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "badges".localized
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)

        footerView.addSubview(titleLabel)
        footerView.addSubview(badgeCollectionView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),

            badgeCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            badgeCollectionView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            badgeCollectionView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            badgeCollectionView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -16),
            badgeCollectionView.heightAnchor.constraint(equalToConstant: 280)
        ])

        tableView.tableFooterView = footerView
        footerView.frame.size.height = 340
    }

    @objc private func selectPhoto() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    private func updateReminder(enabled: Bool) {
        if enabled {
            NotificationService.shared.requestAuthorization()
            let storedDate = UserDefaults.standard.object(forKey: "reminderTime") as? Date ?? Date()
            NotificationService.shared.scheduleDailyReminder(at: storedDate)
        } else {
            NotificationService.shared.cancelDailyReminder()
        }
        UserDefaults.standard.set(enabled, forKey: "reminderEnabled")
    }

    private func updateDarkMode(enabled: Bool) {
        ThemeService.shared.isDarkModeEnabled = enabled
        ThemeService.shared.applyTheme(to: view.window)
    }

    private func showTimePicker() {
        let alert = UIAlertController(title: "reminder".localized, message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.date = UserDefaults.standard.object(forKey: "reminderTime") as? Date ?? Date()
        alert.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 48),
            datePicker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -16),
            datePicker.heightAnchor.constraint(equalToConstant: 200)
        ])
        alert.addAction(UIAlertAction(title: "save".localized, style: .default) { _ in
            UserDefaults.standard.set(datePicker.date, forKey: "reminderTime")
            NotificationService.shared.scheduleDailyReminder(at: datePicker.date)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    private func showLanguagePicker() {
        let alert = UIAlertController(title: "language".localized, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "english".localized, style: .default) { _ in
            LocalizationService.shared.currentLanguage = "en"
        })
        alert.addAction(UIAlertAction(title: "turkish".localized, style: .default) { _ in
            LocalizationService.shared.currentLanguage = "tr"
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    private func shareCard() -> UIImage {
        let cardView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 420))
        cardView.backgroundColor = UIColor.systemBrown
        let backgroundImageView = UIImageView(image: UIImage(named: AssetAndLinks.shareCardBackgroundImage))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = cardView.bounds
        cardView.addSubview(backgroundImageView)

        let overlay = UIView(frame: cardView.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        cardView.addSubview(overlay)

        let titleLabel = UILabel()
        titleLabel.text = "Face Yoga"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = UIColor.white

        let streakLabel = UILabel()
        streakLabel.text = String(format: "streak_title".localized, viewModel.streakCount)
        streakLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        streakLabel.textColor = UIColor.white

        let statsLabel = UILabel()
        statsLabel.text = "\("total_minutes".localized): \(viewModel.totalMinutes)\n\("programs_completed".localized): \(viewModel.programsCompleted)"
        statsLabel.numberOfLines = 0
        statsLabel.textColor = UIColor.white

        let stack = UIStackView(arrangedSubviews: [titleLabel, streakLabel, statsLabel])
        stack.axis = .vertical
        stack.spacing = 12

        cardView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            stack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -32),
            stack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24)
        ])

        let renderer = UIGraphicsImageRenderer(size: cardView.bounds.size)
        return renderer.image { _ in
            cardView.drawHierarchy(in: cardView.bounds, afterScreenUpdates: true)
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Setting.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        guard let setting = Setting(rawValue: indexPath.row) else { return cell }
        switch setting {
        case .reminder:
            cell.textLabel?.text = "reminder".localized
            let toggle = UISwitch()
            toggle.isOn = UserDefaults.standard.bool(forKey: "reminderEnabled")
            toggle.addTarget(self, action: #selector(reminderToggled(_:)), for: .valueChanged)
            cell.accessoryView = toggle
            cell.detailTextLabel?.text = ""
        case .darkMode:
            cell.textLabel?.text = "dark_mode".localized
            let toggle = UISwitch()
            toggle.isOn = ThemeService.shared.isDarkModeEnabled
            toggle.addTarget(self, action: #selector(darkModeToggled(_:)), for: .valueChanged)
            cell.accessoryView = toggle
        case .share:
            cell.textLabel?.text = "share".localized
            cell.accessoryType = .disclosureIndicator
        case .language:
            cell.textLabel?.text = "language".localized
            cell.detailTextLabel?.text = LocalizationService.shared.currentLanguage == "tr" ? "turkish".localized : "english".localized
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let setting = Setting(rawValue: indexPath.row) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        switch setting {
        case .reminder:
            showTimePicker()
        case .darkMode:
            break
        case .share:
            let image = shareCard()
            let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(controller, animated: true)
        case .language:
            showLanguagePicker()
        }
    }

    @objc private func reminderToggled(_ sender: UISwitch) {
        updateReminder(enabled: sender.isOn)
    }

    @objc private func darkModeToggled(_ sender: UISwitch) {
        updateDarkMode(enabled: sender.isOn)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.badges.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCell.reuseIdentifier, for: indexPath) as! BadgeCell
        cell.configure(badge: viewModel.badges[indexPath.item])
        return cell
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let item = results.first?.itemProvider, item.canLoadObject(ofClass: UIImage.self) else { return }
        item.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
            guard let self = self, let image = object as? UIImage else { return }
            DispatchQueue.main.async {
                self.profileImageView.image = image
                self.viewModel.saveProfileImage(image)
            }
        }
    }
}
