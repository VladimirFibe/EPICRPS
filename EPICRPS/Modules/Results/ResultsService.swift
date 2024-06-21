import Foundation

protocol ResultsServiceProtocol {
    func getPersons() async throws -> [Person]
}

extension FirebaseClient: ResultsServiceProtocol {
    func getPersons() async throws -> [Person] {
        try await fetchPersons()
    }
}
