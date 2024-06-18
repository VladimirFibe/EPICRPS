import Foundation

protocol SplashUseCaseProtocol {
    func login() async throws -> Person?
}

final class SplashUseCase: SplashUseCaseProtocol {
    private let service: SplashServiceProtocol
    init(service: SplashServiceProtocol) {
        self.service = service
    }
    
    func login() async throws -> Person? {
        try await service.login()
    }
}
