import Foundation

protocol SplashServiceProtocol {
    func login() async throws -> Person?
    func downloadRecentChats(completion: @escaping ([Recent]) -> Void)
    func updateActivity() throws
}

extension FirebaseClient: SplashServiceProtocol {}
