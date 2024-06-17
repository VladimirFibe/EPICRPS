import Foundation

protocol SplashServiceProtocol {
    func login() async throws -> Person?
    func start(with current: Person, and player: Person) async throws
}

extension FirebaseClient: SplashServiceProtocol {
    func login() async throws -> Person? {
        try await createUser()
        return person
    }
    
    func start(with current: Person, and player: Person) async throws {
        self.recent = try await createRecent(with: current, and: player)
    }
}
