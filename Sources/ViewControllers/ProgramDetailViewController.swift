import AVKit
import UIKit

final class ProgramDetailViewController: UIViewController {
    private let viewModel: ProgramDetailViewModel
    private let playerController = AVPlayerViewController()
    private let tableView = UITableView()
    private let completeButton = UIButton(type: .system)

    private var queuePlayer: AVQueuePlayer?
    private var currentSegmentIndex = 0

    init(viewModel: ProgramDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.program.name
        view.backgroundColor = DesignSystem.backgroundColor
        setupPlayer()
        setupLayout()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLanguageChange), name: .languageDidChange, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        queuePlayer?.play()
    }

    private func setupPlayer() {
        let items = viewModel.program.segments.map { segment in
            AVPlayerItem(url: URL(string: segment.videoURL) ?? URL(fileURLWithPath: "/dev/null"))
        }
        let queue = AVQueuePlayer(items: items)
        queuePlayer = queue
        playerController.player = queue
        playerController.showsPlaybackControls = true

        NotificationCenter.default.addObserver(self, selector: #selector(handleSegmentFinished), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }

    private func setupLayout() {
        addChild(playerController)
        view.addSubview(playerController.view)
        playerController.didMove(toParent: self)

        completeButton.setTitle("complete_program".localized, for: .normal)
        completeButton.backgroundColor = DesignSystem.accentColor
        completeButton.tintColor = UIColor.white
        completeButton.layer.cornerRadius = 20
        completeButton.isEnabled = false
        completeButton.alpha = 0.5
        completeButton.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)

        view.addSubview(tableView)
        view.addSubview(completeButton)

        playerController.view.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        completeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            playerController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),

            tableView.topAnchor.constraint(equalTo: playerController.view.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: completeButton.topAnchor, constant: -12),

            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            completeButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SegmentCell")
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
    }

    @objc private func handleLanguageChange() {
        completeButton.setTitle("complete_program".localized, for: .normal)
    }

    @objc private func handleSegmentFinished() {
        currentSegmentIndex += 1
        if currentSegmentIndex >= viewModel.program.segments.count {
            completeButton.isEnabled = true
            completeButton.alpha = 1.0
        }
    }

    @objc private func completeTapped() {
        HapticService.impact(style: .medium)
        completeButton.animatePress()
        viewModel.markCompletionIfNeeded()
        navigationController?.popViewController(animated: true)
    }
}

extension ProgramDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.program.segments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentCell", for: indexPath)
        let segment = viewModel.program.segments[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = segment.title
        content.secondaryText = "\(segment.durationMinutes) min"
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        cell.backgroundColor = DesignSystem.cardColor
        cell.layer.cornerRadius = 12
        return cell
    }
}
