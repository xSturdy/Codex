import UIKit

final class ProgressViewController: UIViewController {
    private let viewModel = ProgressViewModel()
    private let streakView = StreakView()
    private let totalMinutesLabel = UILabel()
    private let programsCompletedLabel = UILabel()
    private let calendarView = UICalendarView()
    private let noteTextView = UITextView()
    private let saveButton = UIButton(type: .system)
    private let noteLabel = UILabel()
    private var selectedDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "tab_progress".localized
        view.backgroundColor = UIColor.systemBackground
        setupLayout()
        configure()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLanguageChange), name: .languageDidChange, object: nil)
    }

    private func setupLayout() {
        streakView.update(streakCount: viewModel.streakCount)

        totalMinutesLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        programsCompletedLabel.font = UIFont.preferredFont(forTextStyle: .headline)

        calendarView.locale = Locale.current
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)

        noteTextView.font = UIFont.preferredFont(forTextStyle: .body)
        noteTextView.layer.cornerRadius = 12
        noteTextView.layer.borderColor = UIColor.systemGray4.cgColor
        noteTextView.layer.borderWidth = 1

        saveButton.setTitle("save".localized, for: .normal)
        saveButton.backgroundColor = UIColor.systemBrown
        saveButton.tintColor = UIColor.white
        saveButton.layer.cornerRadius = 18
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

        let statsStack = UIStackView(arrangedSubviews: [totalMinutesLabel, programsCompletedLabel])
        statsStack.axis = .horizontal
        statsStack.spacing = 24
        statsStack.distribution = .fillEqually

        noteLabel.text = "how_did_you_feel".localized
        noteLabel.font = UIFont.preferredFont(forTextStyle: .headline)

        view.addSubview(streakView)
        view.addSubview(statsStack)
        view.addSubview(calendarView)
        view.addSubview(noteLabel)
        view.addSubview(noteTextView)
        view.addSubview(saveButton)

        streakView.translatesAutoresizingMaskIntoConstraints = false
        statsStack.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            streakView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            streakView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            streakView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            statsStack.topAnchor.constraint(equalTo: streakView.bottomAnchor, constant: 20),
            statsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            statsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            calendarView.topAnchor.constraint(equalTo: statsStack.bottomAnchor, constant: 20),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendarView.heightAnchor.constraint(equalToConstant: 300),

            noteLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 16),
            noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            noteTextView.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 8),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            noteTextView.heightAnchor.constraint(equalToConstant: 120),

            saveButton.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 12),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func configure() {
        totalMinutesLabel.text = "\("total_minutes".localized): \(viewModel.totalMinutes)"
        programsCompletedLabel.text = "\("programs_completed".localized): \(viewModel.programsCompleted)"
        noteLabel.text = "how_did_you_feel".localized
        selectDate(Date())
    }

    @objc private func handleLanguageChange() {
        title = "tab_progress".localized
        saveButton.setTitle("save".localized, for: .normal)
        configure()
    }

    private func selectDate(_ date: Date) {
        selectedDate = date
        let isToday = Calendar.current.isDateInToday(date)
        noteTextView.text = viewModel.noteText(for: date)
        noteTextView.isEditable = isToday
        noteTextView.textColor = isToday ? UIColor.label : UIColor.secondaryLabel
        saveButton.isEnabled = isToday
        saveButton.alpha = isToday ? 1.0 : 0.5
    }

    @objc private func saveTapped() {
        viewModel.save(noteText: noteTextView.text ?? "", for: selectedDate)
    }
}

extension ProgressViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        selectDate(date)
    }
}
