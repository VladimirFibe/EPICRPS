import Foundation

final class LocalService {
    static let shared = LocalService()
    private init() {}
    public var currentPerson = Person(name: "Player 1")
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
}
