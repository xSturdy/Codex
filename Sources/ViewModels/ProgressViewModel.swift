import Foundation

final class ProgressViewModel {
    private let streakService = StreakService.shared
    private let completionStore = CompletionStore.shared
    private let noteStore = NoteStore.shared

    var streakCount: Int {
        streakService.state.count
    }

    var totalMinutes: Int {
        completionStore.totalMinutes()
    }

    var programsCompleted: Int {
        completionStore.totalProgramsCompleted()
    }

    func noteText(for date: Date) -> String {
        noteStore.note(for: date)?.text ?? ""
    }

    func save(noteText: String, for date: Date) {
        noteStore.save(noteText: noteText, for: date)
    }
}
