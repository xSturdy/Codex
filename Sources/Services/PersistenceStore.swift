import Foundation

final class PersistenceStore {
    static let shared = PersistenceStore()

    private let defaults = UserDefaults.standard

    private init() {}

    func saveCodable<T: Codable>(_ value: T, forKey key: String) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let data = try? encoder.encode(value) {
            defaults.set(data, forKey: key)
        }
    }

    func loadCodable<T: Codable>(_ type: T.Type, forKey key: String, defaultValue: T) -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let data = defaults.data(forKey: key), let value = try? decoder.decode(type, from: data) else {
            return defaultValue
        }
        return value
    }

    func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
