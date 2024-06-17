import Foundation

enum PersonsEvent {
    case done([Person])
}

enum PersonsAction {
    case fetch
    case createRecent(Person, Person)
}

final class PersonStrore: Store<PersonsEvent, PersonsAction> {
    private let useCase = FirebaseClient.shared

    override func handleActions(action: PersonsAction) {
        switch action {
        case .fetch:
            statefulCall { [weak self] in
                try await self?.fetchPersons()
            }
        case .createRecent(let person, let player):
            statefulCall { [weak self] in
                try await self?.createRecent(with: person, and: player)
            }
        }
    }

    private func fetchPersons() async throws {
        let persons = try await useCase.fetchPersons()
        sendEvent(.done(persons))
    }
    
    private func createRecent(with person: Person, and player: Person) async throws {
        FirebaseClient.shared.recent = try await FirebaseClient.shared.createRecent(with: person, and: player)
    }
}
