import Foundation

final class LocalService {
    static let shared = LocalService()
    private init() {}
    public var persons: [Person] = [
        .init(name: "Tony Newman"),
        .init(name: "Herman Welch"),
        .init(name: "Dollie Mann"),
        .init(name: "Ian Burton"),
        .init(name: "Roixie Hansen"),
        .init(name: "Steven Vaughn"),
        .init(name: "Harriett Single"),
        .init(name: "Henry Padilla")
    ]
    
    private enum Keys: String {
        case currentPerson
    }
    
    public var currentPerson: Person {
        get {
            if let data = UserDefaults.standard.data(forKey: Keys.currentPerson.rawValue),
               let person = try? JSONDecoder().decode(Person.self, from: data) {
                return person
            } else {
                return Person(name: "Player 1")
            }
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(data, forKey: Keys.currentPerson.rawValue)
        }
    }
}
