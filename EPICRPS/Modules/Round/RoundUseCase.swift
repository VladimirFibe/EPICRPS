import Foundation

protocol RoundUseCaseProtocol {
    func round(_ hand: Int) async throws -> Recent
    func reset() async throws
    func restart() async throws
    func lose() async throws -> Recent
}

final class RoundUseCase: RoundUseCaseProtocol {
    private let service: RoundServiceProtocol
    
    init(service: RoundServiceProtocol) {
        self.service = service
    }
    
    func round(_ hand: Int) async throws -> Recent {
        try await service.round(hand)
    }
    
    func reset() async throws {
        try await service.reset()
    }
    
    func restart() async throws {
        try await service.restart()
    }
    
    func lose() async throws -> Recent {
        try await service.lose()
    }
}
