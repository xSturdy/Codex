import Foundation

final class StreakService {
    static let shared = StreakService()

    private let key = "streakState"

    private init() {}

    var state: StreakState {
        get { PersistenceStore.shared.loadCodable(StreakState.self, forKey: key, defaultValue: StreakState(count: 0, lastCompletionDate: nil, lastStreakIncrementDate: nil)) }
        set { PersistenceStore.shared.saveCodable(newValue, forKey: key) }
    }

    func refreshForAppLaunch(date: Date = Date()) {
        var currentState = state
        guard let lastCompletion = currentState.lastCompletionDate else { return }
        let calendar = Calendar.current
        let lastDay = calendar.startOfDay(for: lastCompletion)
        let today = calendar.startOfDay(for: date)
        let diff = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
        if diff > 1 {
            currentState.count = 0
            currentState.lastStreakIncrementDate = nil
            state = currentState
        }
    }

    func recordCompletion(date: Date = Date()) {
        var currentState = state
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: date)

        if let lastCompletion = currentState.lastCompletionDate {
            let lastDay = calendar.startOfDay(for: lastCompletion)
            let diff = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
            if diff > 1 {
                currentState.count = 0
                currentState.lastStreakIncrementDate = nil
            }
        }

        let alreadyIncrementedToday: Bool
        if let lastIncrement = currentState.lastStreakIncrementDate {
            alreadyIncrementedToday = calendar.isDate(lastIncrement, inSameDayAs: today)
        } else {
            alreadyIncrementedToday = false
        }

        if !alreadyIncrementedToday {
            currentState.count += 1
            currentState.lastStreakIncrementDate = today
        }

        currentState.lastCompletionDate = today
        state = currentState
    }
}
