import Foundation

enum Difficulty: String, Codable, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

enum Region: String, Codable, CaseIterable {
    case forehead = "Forehead"
    case jaw = "Jaw"
    case eyes = "Eyes"
    case neck = "Neck"
    case chinJowls = "Chin/Jowls"
    case underChin = "Under-chin"
}

struct Segment: Codable, Hashable {
    let id: UUID
    let title: String
    let durationMinutes: Int
    let videoURL: String
}

struct Program: Codable, Hashable {
    let id: UUID
    let name: String
    let durationMinutes: Int
    let difficulty: Difficulty
    let regions: [Region]
    let imageName: String
    let videoURL: String
    let segments: [Segment]
}

struct ActiveProgram: Codable, Hashable {
    let programID: UUID
    let planDays: Int
    var currentDay: Int
    var isCompleted: Bool
}

struct Completion: Codable, Hashable {
    let programID: UUID
    let date: Date
    let minutes: Int
}

struct StreakState: Codable, Hashable {
    var count: Int
    var lastCompletionDate: Date?
    var lastStreakIncrementDate: Date?
}

struct DailyTip: Codable, Hashable {
    let id: UUID
    let text: String
}

struct Note: Codable, Hashable {
    let date: Date
    var text: String
}

struct Badge: Codable, Hashable {
    let id: UUID
    let title: String
    let imageName: String
}
