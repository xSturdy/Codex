import UIKit

final class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let streakView = StreakView()
    private let routineLabel = UILabel()
    private let programCard = ProgramCardView()
    private let tipView = TipOfDayView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "tab_home".localized
        view.backgroundColor = UIColor.systemBackground
        setupLayout()
        configure()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLanguageChange), name: .languageDidChange, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }

    @objc private func handleLanguageChange() {
        title = "tab_home".localized
        routineLabel.text = "todays_routine".localized
        programCard.startButton.setTitle("start".localized, for: .normal)
        programCard.badgeLabel.text = "completed".localized
        tipView.configure(tip: viewModel.tip)
        configure()
    }

    private func setupLayout() {
        routineLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        routineLabel.textColor = UIColor.black
        routineLabel.text = "todays_routine".localized

        scrollView.alwaysBounceVertical = true

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(streakView)
        contentView.addSubview(routineLabel)
        contentView.addSubview(programCard)
        contentView.addSubview(tipView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        streakView.translatesAutoresizingMaskIntoConstraints = false
        routineLabel.translatesAutoresizingMaskIntoConstraints = false
        programCard.translatesAutoresizingMaskIntoConstraints = false
        tipView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            streakView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            streakView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            streakView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            routineLabel.topAnchor.constraint(equalTo: streakView.bottomAnchor, constant: 24),
            routineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            routineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            programCard.topAnchor.constraint(equalTo: routineLabel.bottomAnchor, constant: 16),
            programCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            programCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            tipView.topAnchor.constraint(equalTo: programCard.bottomAnchor, constant: 24),
            tipView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            tipView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            tipView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])

        programCard.startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }

    private func configure() {
        streakView.update(streakCount: viewModel.streakCount)
        guard let program = viewModel.todayProgram else { return }
        let completed = viewModel.isProgramCompletedToday(program)
        programCard.configure(with: program, completed: completed)
        tipView.configure(tip: viewModel.tip)
    }

    @objc private func startTapped() {
        guard let program = viewModel.todayProgram else { return }
        ActiveProgramStore.shared.activateProgram(program.id)
        let detail = ProgramDetailViewController(viewModel: ProgramDetailViewModel(program: program))
        navigationController?.pushViewController(detail, animated: true)
    }
}
