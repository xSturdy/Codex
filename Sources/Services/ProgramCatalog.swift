import Foundation

final class ProgramCatalog {
    static let shared = ProgramCatalog()

    let programs: [Program]

    private init() {
        programs = [
            Program(
                id: UUID(),
                name: "Morning Face Yoga",
                durationMinutes: 10,
                difficulty: .easy,
                regions: [.forehead, .jaw, .eyes],
                imageName: AssetAndLinks.morningProgramImage,
                videoURL: AssetAndLinks.morningProgramVideoURL,
                segments: [
                    Segment(id: UUID(), title: "Forehead Release", durationMinutes: 1, videoURL: AssetAndLinks.foreheadSegmentVideoURL),
                    Segment(id: UUID(), title: "Jaw Softener", durationMinutes: 2, videoURL: AssetAndLinks.jawSegmentVideoURL),
                    Segment(id: UUID(), title: "Bright Eyes", durationMinutes: 2, videoURL: AssetAndLinks.eyesSegmentVideoURL)
                ]
            ),
            Program(
                id: UUID(),
                name: "Before Bed Face Yoga",
                durationMinutes: 12,
                difficulty: .easy,
                regions: [.neck, .jaw, .chinJowls],
                imageName: AssetAndLinks.beforeBedProgramImage,
                videoURL: AssetAndLinks.beforeBedProgramVideoURL,
                segments: [
                    Segment(id: UUID(), title: "Neck Ease", durationMinutes: 2, videoURL: AssetAndLinks.neckSegmentVideoURL),
                    Segment(id: UUID(), title: "Jaw Release", durationMinutes: 2, videoURL: AssetAndLinks.jawSegmentVideoURL),
                    Segment(id: UUID(), title: "Chin Lift", durationMinutes: 2, videoURL: AssetAndLinks.chinSegmentVideoURL)
                ]
            ),
            Program(
                id: UUID(),
                name: "Relaxing Yoga",
                durationMinutes: 15,
                difficulty: .medium,
                regions: [.forehead, .eyes, .neck],
                imageName: AssetAndLinks.relaxingProgramImage,
                videoURL: AssetAndLinks.relaxingProgramVideoURL,
                segments: [
                    Segment(id: UUID(), title: "Forehead Melt", durationMinutes: 2, videoURL: AssetAndLinks.foreheadSegmentVideoURL),
                    Segment(id: UUID(), title: "Eye Refresh", durationMinutes: 2, videoURL: AssetAndLinks.eyesSegmentVideoURL),
                    Segment(id: UUID(), title: "Neck Flow", durationMinutes: 3, videoURL: AssetAndLinks.neckSegmentVideoURL)
                ]
            ),
            Program(
                id: UUID(),
                name: "Daily 5-Min Yoga",
                durationMinutes: 5,
                difficulty: .easy,
                regions: [.jaw, .chinJowls],
                imageName: AssetAndLinks.dailyFiveProgramImage,
                videoURL: AssetAndLinks.dailyFiveProgramVideoURL,
                segments: [
                    Segment(id: UUID(), title: "Jaw Boost", durationMinutes: 1, videoURL: AssetAndLinks.jawSegmentVideoURL),
                    Segment(id: UUID(), title: "Chin Sculpt", durationMinutes: 1, videoURL: AssetAndLinks.chinSegmentVideoURL)
                ]
            ),
            Program(
                id: UUID(),
                name: "Fast Detox",
                durationMinutes: 8,
                difficulty: .hard,
                regions: [.underChin, .neck, .jaw],
                imageName: AssetAndLinks.fastDetoxProgramImage,
                videoURL: AssetAndLinks.fastDetoxProgramVideoURL,
                segments: [
                    Segment(id: UUID(), title: "Under-chin Drain", durationMinutes: 2, videoURL: AssetAndLinks.chinSegmentVideoURL),
                    Segment(id: UUID(), title: "Neck Flush", durationMinutes: 2, videoURL: AssetAndLinks.neckSegmentVideoURL)
                ]
            )
        ]
    }
}
