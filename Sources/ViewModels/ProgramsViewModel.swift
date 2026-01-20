import Foundation

final class ProgramsViewModel {
    private let catalog = ProgramCatalog.shared
    private let activeStore = ActiveProgramStore.shared

    var programs: [Program] {
        catalog.programs
    }

    var activePrograms: [ActiveProgram] {
        activeStore.activePrograms
    }

    func activateProgram(_ program: Program, planDays: Int = 5) {
        activeStore.activateProgram(program.id, planDays: planDays)
    }

    func filteredPrograms(for region: Region?) -> [Program] {
        guard let region = region else { return programs }
        return programs.filter { $0.regions.contains(region) }
    }
}
