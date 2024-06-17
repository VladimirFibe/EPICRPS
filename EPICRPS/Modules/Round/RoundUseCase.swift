import Foundation

protocol RoundUseCaseProtocol {
    func round(_ hand: Int) async throws
    func lose() async throws
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
}
