import Foundation

protocol ResultsServiceProtocol {
    func getPersons() async throws -> [Person]
}

extension LocalService: ResultsServiceProtocol {
    func getPersons() async throws -> [Person] {
        persons
    }
}
