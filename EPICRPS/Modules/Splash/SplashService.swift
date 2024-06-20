import Foundation

protocol SplashServiceProtocol {
    func login() async throws -> Person?
    func downloadRecentChats(completion: @escaping ([Recent]) -> Void)
}

extension FirebaseClient: SplashServiceProtocol {}
