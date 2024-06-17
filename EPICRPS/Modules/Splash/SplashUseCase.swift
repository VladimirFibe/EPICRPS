import Foundation

protocol SplashUseCaseProtocol {
    func login() async throws -> Person?
    func start(with current: Person, and player: Person) async throws
}

final class SplashUseCase: SplashUseCaseProtocol {
    private let service: SplashServiceProtocol
    init(service: SplashServiceProtocol) {
        self.service = service
    }
    
    func login() async throws -> Person? {
        try await service.login()
    }
    
    func start(with current: Person, and player: Person) async throws {
        try await service.start(with: current, and: player)
    }
}
