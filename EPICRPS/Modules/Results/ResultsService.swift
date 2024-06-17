import Foundation

protocol ResultsServiceProtocol {
    func getPersons() async throws -> [Person]
}

//extension LocalService: ResultsServiceProtocol {
//    func getPersons() async throws -> [Person] {
//        persons
//    }
//}

extension FirebaseClient: ResultsServiceProtocol {
    func getPersons() async throws -> [Person] {
        try await fetchPersons()
    }
}
