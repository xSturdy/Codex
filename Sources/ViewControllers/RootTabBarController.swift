import UIKit

final class RootTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        tabBar.backgroundColor = DesignSystem.cardColor
        tabBar.unselectedItemTintColor = DesignSystem.secondaryText
        NotificationCenter.default.addObserver(self, selector: #selector(handleLanguageChange), name: .languageDidChange, object: nil)
    }

    @objc private func handleLanguageChange() {
        configureTabs()
    }

    private func configureTabs() {
        guard let viewControllers = viewControllers, viewControllers.count >= 4 else { return }
        viewControllers[0].tabBarItem = UITabBarItem(title: "tab_home".localized, image: UIImage(named: AssetAndLinks.tabHomeIcon), tag: 0)
        viewControllers[1].tabBarItem = UITabBarItem(title: "tab_programs".localized, image: UIImage(named: AssetAndLinks.tabProgramsIcon), tag: 1)
        viewControllers[2].tabBarItem = UITabBarItem(title: "tab_progress".localized, image: UIImage(named: AssetAndLinks.tabProgressIcon), tag: 2)
        viewControllers[3].tabBarItem = UITabBarItem(title: "tab_profile".localized, image: UIImage(named: AssetAndLinks.tabProfileIcon), tag: 3)
        tabBar.tintColor = DesignSystem.accentColor
    }
}
