import UIKit

final class ProgramsViewController: UIViewController {
    private let viewModel = ProgramsViewModel()
    private var selectedRegion: Region?

    private let filterCollectionView: UICollectionView
    private let activeCollectionView: UICollectionView
    private let tableView = UITableView()

    private let myProgramsLabel = UILabel()
    private let activeLabel = UILabel()
    private let dailyLabel = UILabel()

    private var filteredPrograms: [Program] = []

    private var filterOptions: [(title: String, region: Region?)] = []

    init() {
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .horizontal
        filterLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        filterLayout.minimumLineSpacing = 8
        filterLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)

        let activeLayout = UICollectionViewFlowLayout()
        activeLayout.scrollDirection = .horizontal
        activeLayout.itemSize = CGSize(width: 260, height: 150)
        activeLayout.minimumLineSpacing = 16
        activeLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        activeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: activeLayout)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "tab_programs".localized
        view.backgroundColor = DesignSystem.backgroundColor
        setupLayout()
        setupTableView()
        setupCollections()
        configureFilters()
        applyFilter()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLanguageChange), name: .languageDidChange, object: nil)
    }

    @objc private func handleLanguageChange() {
        title = "tab_programs".localized
        myProgramsLabel.text = "my_programs".localized
        activeLabel.text = "active_programs".localized
        dailyLabel.text = "daily_routine_programs".localized
        configureFilters()
        tableView.reloadData()
        filterCollectionView.reloadData()
    }

    private func configureFilters() {
        filterOptions = [
            ("filter_all".localized, nil),
            ("filter_forehead".localized, .forehead),
            ("filter_jaw".localized, .jaw),
            ("filter_eyes".localized, .eyes),
            ("filter_neck".localized, .neck),
            ("filter_chin".localized, .chinJowls),
            ("filter_under_chin".localized, .underChin)
        ]
    }

    private func setupLayout() {
        myProgramsLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        myProgramsLabel.textColor = DesignSystem.primaryText
        myProgramsLabel.text = "my_programs".localized

        activeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        activeLabel.textColor = DesignSystem.secondaryText
        activeLabel.text = "active_programs".localized

        dailyLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        dailyLabel.textColor = DesignSystem.secondaryText
        dailyLabel.text = "daily_routine_programs".localized

        filterCollectionView.backgroundColor = UIColor.clear
        activeCollectionView.backgroundColor = UIColor.clear
        activeCollectionView.showsHorizontalScrollIndicator = false

        view.addSubview(myProgramsLabel)
        view.addSubview(activeLabel)
        view.addSubview(activeCollectionView)
        view.addSubview(dailyLabel)
        view.addSubview(filterCollectionView)
        view.addSubview(tableView)

        myProgramsLabel.translatesAutoresizingMaskIntoConstraints = false
        activeLabel.translatesAutoresizingMaskIntoConstraints = false
        activeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dailyLabel.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            myProgramsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            myProgramsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            activeLabel.topAnchor.constraint(equalTo: myProgramsLabel.bottomAnchor, constant: 16),
            activeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            activeCollectionView.topAnchor.constraint(equalTo: activeLabel.bottomAnchor, constant: 12),
            activeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activeCollectionView.heightAnchor.constraint(equalToConstant: 170),

            dailyLabel.topAnchor.constraint(equalTo: activeCollectionView.bottomAnchor, constant: 16),
            dailyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            filterCollectionView.topAnchor.constraint(equalTo: dailyLabel.bottomAnchor, constant: 12),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 44),

            tableView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupCollections() {
        filterCollectionView.register(FilterChipCell.self, forCellWithReuseIdentifier: FilterChipCell.reuseIdentifier)
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self

        activeCollectionView.register(ActiveProgramCell.self, forCellWithReuseIdentifier: ActiveProgramCell.reuseIdentifier)
        activeCollectionView.dataSource = self
        activeCollectionView.delegate = self
    }

    private func setupTableView() {
        tableView.register(ProgramCell.self, forCellReuseIdentifier: ProgramCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
    }

    private func applyFilter() {
        filteredPrograms = viewModel.filteredPrograms(for: selectedRegion)
        tableView.reloadData()
        activeCollectionView.reloadData()
    }
}

extension ProgramsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView {
            return filterOptions.count
        }
        return viewModel.activePrograms.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterChipCell.reuseIdentifier, for: indexPath) as! FilterChipCell
            let option = filterOptions[indexPath.item]
            cell.configure(title: option.title)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActiveProgramCell.reuseIdentifier, for: indexPath) as! ActiveProgramCell
        let active = viewModel.activePrograms[indexPath.item]
        if let program = viewModel.programs.first(where: { $0.id == active.programID }) {
            cell.configure(program: program, active: active)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            HapticService.selection()
            selectedRegion = filterOptions[indexPath.item].region
            applyFilter()
        }
    }
}

extension ProgramsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPrograms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgramCell.reuseIdentifier, for: indexPath) as! ProgramCell
        cell.configure(program: filteredPrograms[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HapticService.impact()
        let program = filteredPrograms[indexPath.row]
        viewModel.activateProgram(program)
        let detail = ProgramDetailViewController(viewModel: ProgramDetailViewModel(program: program))
        navigationController?.pushViewController(detail, animated: true)
        activeCollectionView.reloadData()
    }
}
