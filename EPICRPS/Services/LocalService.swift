import Foundation

final class LocalService {
    static let shared = LocalService()
    private init() {}
    var totalTime = 30
    
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
    
    var getTotalTime: Int {
        totalTime
    }
    public lazy var recent = Recent(id: friendPerson.id, name: friendPerson.name, currentId: currentPerson.id, currentName: currentPerson.name)
    private enum Keys: String {
        case currentPerson
        case friendPerson
    }
    
    public var friendPerson: Person {
        get {
            if let data = UserDefaults.standard.data(forKey: Keys.friendPerson.rawValue),
               let person = try? JSONDecoder().decode(Person.self, from: data) {
                return person
            } else {
                return Person(name: "Player 2")
            }
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(data, forKey: Keys.friendPerson.rawValue)
        }
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
