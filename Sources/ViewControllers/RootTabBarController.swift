import UIKit

final class RootTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLanguageChange), name: .languageDidChange, object: nil)
    }

    @objc private func handleLanguageChange() {
        configureTabs()
    }

    private func configureTabs() {
        let home = UINavigationController(rootViewController: HomeViewController())
        let programs = UINavigationController(rootViewController: ProgramsViewController())
        let progress = UINavigationController(rootViewController: ProgressViewController())
        let profile = UINavigationController(rootViewController: ProfileViewController())

        home.tabBarItem = UITabBarItem(title: "tab_home".localized, image: UIImage(systemName: "house"), tag: 0)
        programs.tabBarItem = UITabBarItem(title: "tab_programs".localized, image: UIImage(systemName: "play.rectangle"), tag: 1)
        progress.tabBarItem = UITabBarItem(title: "tab_progress".localized, image: UIImage(systemName: "chart.bar"), tag: 2)
        profile.tabBarItem = UITabBarItem(title: "tab_profile".localized, image: UIImage(systemName: "person"), tag: 3)

        tabBar.tintColor = UIColor.black
        viewControllers = [home, programs, progress, profile]
    }
}
