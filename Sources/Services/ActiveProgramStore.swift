import Foundation

final class ActiveProgramStore {
    static let shared = ActiveProgramStore()

    private let key = "activePrograms"

    private init() {}

    var activePrograms: [ActiveProgram] {
        get { PersistenceStore.shared.loadCodable([ActiveProgram].self, forKey: key, defaultValue: []) }
        set { PersistenceStore.shared.saveCodable(newValue, forKey: key) }
    }

    func activateProgram(_ programID: UUID, planDays: Int = 5) {
        guard !activePrograms.contains(where: { $0.programID == programID }) else { return }
        let active = ActiveProgram(programID: programID, planDays: planDays, currentDay: 0, isCompleted: false)
        activePrograms.append(active)
    }

    func advanceProgram(_ programID: UUID) -> Bool {
        var programs = activePrograms
        guard let index = programs.firstIndex(where: { $0.programID == programID }) else { return false }
        var current = programs[index]
        guard !current.isCompleted else { return false }
        current.currentDay += 1
        if current.currentDay >= current.planDays {
            current.isCompleted = true
            programs.remove(at: index)
            activePrograms = programs
            return true
        }
        programs[index] = current
        activePrograms = programs
        return false
    }
}
