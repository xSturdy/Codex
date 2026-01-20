import Foundation

final class BadgeStore {
    static let shared = BadgeStore()

    private let key = "badges"

    private init() {}

    var badges: [Badge] {
        get { PersistenceStore.shared.loadCodable([Badge].self, forKey: key, defaultValue: []) }
        set { PersistenceStore.shared.saveCodable(newValue, forKey: key) }
    }

    func addBadge(for program: Program) {
        guard !badges.contains(where: { $0.title == program.name }) else { return }
        let badge = Badge(id: UUID(), title: program.name, imageName: "badge_placeholder")
        badges.append(badge)
    }
}
