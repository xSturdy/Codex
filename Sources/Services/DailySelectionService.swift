import Foundation

final class DailySelectionService {
    static let shared = DailySelectionService()

    private let tipKeys = ["tip_1", "tip_2", "tip_3", "tip_4", "tip_5"]

    private init() {}

    func routineProgram(from programs: [Program], date: Date = Date()) -> Program? {
        guard !programs.isEmpty else { return nil }
        let index = deterministicIndex(count: programs.count, date: date)
        return programs[index]
    }

    func tipForToday(date: Date = Date()) -> DailyTip {
        let index = deterministicIndex(count: tipKeys.count, date: date)
        return DailyTip(id: UUID(), text: tipKeys[index].localized)
    }

    private func deterministicIndex(count: Int, date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let seed = (components.year ?? 0) * 10000 + (components.month ?? 0) * 100 + (components.day ?? 0)
        let hash = abs(seed.hashValue)
        return hash % count
    }
}
