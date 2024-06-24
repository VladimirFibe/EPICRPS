import Foundation

protocol SplashUseCaseProtocol {
    func login() async throws -> Person?
    func downloadRecentChats(completion: @escaping ([Recent]) -> Void)
}

final class SplashUseCase: SplashUseCaseProtocol {
    func downloadRecentChats(completion: @escaping ([Recent]) -> Void) {
        try? service.updateActivity()
        service.downloadRecentChats(completion: completion)
    }
    
    private let service: SplashServiceProtocol
    init(service: SplashServiceProtocol) {
        self.service = service
    }
    
    func login() async throws -> Person? {
        try await service.login()
    }
}
