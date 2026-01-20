import Foundation

final class ProgramDetailViewModel {
    let program: Program

    private let completionStore = CompletionStore.shared
    private let streakService = StreakService.shared
    private let activeStore = ActiveProgramStore.shared
    private let badgeStore = BadgeStore.shared

    init(program: Program) {
        self.program = program
    }

    func markCompletionIfNeeded() {
        let today = Date()
        let completedToday = completionStore.completedProgramIDs(on: today)
        completionStore.addCompletion(Completion(programID: program.id, date: today, minutes: program.durationMinutes))
        let completedProgram = activeStore.advanceProgram(program.id)
        if completedProgram {
            badgeStore.addBadge(for: program)
        }
        if !completedToday.contains(program.id) {
            streakService.recordCompletion(date: today)
        }
    }
}
