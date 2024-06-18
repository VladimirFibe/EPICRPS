import Foundation

protocol SplashServiceProtocol {
    func login() async throws -> Person?
}

extension FirebaseClient: SplashServiceProtocol {}
