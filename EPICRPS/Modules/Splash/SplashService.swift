import Foundation

protocol SplashServiceProtocol {
    func login() async throws -> Person?
}

extension FirebaseClient: SplashServiceProtocol {
    func login() async throws -> Person? {
        try await createUser()
        return person
    }
}
