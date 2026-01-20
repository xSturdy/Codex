import Foundation

final class NoteStore {
    static let shared = NoteStore()

    private let key = "dailyNotes"

    private init() {}

    var notes: [Note] {
        get { PersistenceStore.shared.loadCodable([Note].self, forKey: key, defaultValue: []) }
        set { PersistenceStore.shared.saveCodable(newValue, forKey: key) }
    }

    func note(for date: Date) -> Note? {
        let calendar = Calendar.current
        let day = calendar.startOfDay(for: date)
        return notes.first { calendar.isDate($0.date, inSameDayAs: day) }
    }

    func save(noteText: String, for date: Date) {
        let calendar = Calendar.current
        let day = calendar.startOfDay(for: date)
        var currentNotes = notes
        if let index = currentNotes.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: day) }) {
            currentNotes[index].text = noteText
        } else {
            currentNotes.append(Note(date: day, text: noteText))
        }
        notes = currentNotes
    }
}
