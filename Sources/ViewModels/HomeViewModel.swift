import Foundation

final class HomeViewModel {
    private let programCatalog = ProgramCatalog.shared
    private let streakService = StreakService.shared
    private let completionStore = CompletionStore.shared

    var streakCount: Int {
        streakService.state.count
    }

    var todayProgram: Program? {
        DailySelectionService.shared.routineProgram(from: programCatalog.programs)
    }

    var tip: DailyTip {
        DailySelectionService.shared.tipForToday()
    }

    func isProgramCompletedToday(_ program: Program) -> Bool {
        completionStore.completedProgramIDs(on: Date()).contains(program.id)
    }
}
