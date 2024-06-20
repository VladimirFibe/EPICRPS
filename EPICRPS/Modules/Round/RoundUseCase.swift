import Foundation

protocol RoundUseCaseProtocol {
    func round(_ hand: Int) async throws
    func lose() async throws
    func flip() async throws -> Recent?
    func round() async throws
}

final class RoundUseCase: RoundUseCaseProtocol {
    private let service: RoundServiceProtocol
    
    init(service: RoundServiceProtocol) {
        self.service = service
    }
    
    func round(_ hand: Int) async throws {
        try await service.round(hand)
    }
    
    func lose() async throws {
        try await service.lose()
    }
    
    func flip() async throws -> Recent? {
        try await service.flip()
    }
    
    func round() async throws {
        try await service.round()
    }
}
