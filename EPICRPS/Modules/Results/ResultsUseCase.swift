import Foundation

protocol ResultsUseCaseProtocol {
    func getPersons() async throws -> [Person]
}
final class ResultsUseCase: ResultsUseCaseProtocol {
    private let service: ResultsServiceProtocol
    init(service: ResultsServiceProtocol) {
        self.service = service
    }
    
    func getPersons() async throws -> [Person] {
        try await service.getPersons()
    }
}
