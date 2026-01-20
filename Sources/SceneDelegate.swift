import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        ThemeService.shared.applyTheme(to: window)
        StreakService.shared.refreshForAppLaunch()
        window.rootViewController = RootTabBarController()
        window.makeKeyAndVisible()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        StreakService.shared.refreshForAppLaunch()
    }
}
