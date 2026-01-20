import UIKit

final class ProfileViewModel {
    private let badgeStore = BadgeStore.shared
    private let completionStore = CompletionStore.shared

    var badges: [Badge] {
        badgeStore.badges
    }

    var totalMinutes: Int {
        completionStore.totalMinutes()
    }

    var programsCompleted: Int {
        completionStore.totalProgramsCompleted()
    }

    var streakCount: Int {
        StreakService.shared.state.count
    }

    func profileImage() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: "profileImage"), let image = UIImage(data: data) else {
            return UIImage(named: AssetAndLinks.profilePlaceholderImage)
        }
        return image
    }

    func saveProfileImage(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.9) {
            UserDefaults.standard.set(data, forKey: "profileImage")
        }
    }
}
