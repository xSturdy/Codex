import Foundation

final class CompletionStore {
    static let shared = CompletionStore()

    private let key = "completions"

    private init() {}

    var completions: [Completion] {
        get { PersistenceStore.shared.loadCodable([Completion].self, forKey: key, defaultValue: []) }
        set { PersistenceStore.shared.saveCodable(newValue, forKey: key) }
    }

    func addCompletion(_ completion: Completion) {
        var current = completions
        current.append(completion)
        completions = current
    }

    func totalMinutes() -> Int {
        completions.reduce(0) { $0 + $1.minutes }
    }

    func totalProgramsCompleted() -> Int {
        completions.count
    }

    func completedProgramIDs(on date: Date) -> Set<UUID> {
        let calendar = Calendar.current
        let day = calendar.startOfDay(for: date)
        return Set(completions.filter { calendar.isDate($0.date, inSameDayAs: day) }.map { $0.programID })
    }
}
