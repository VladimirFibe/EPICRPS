import Foundation

import Combine

enum ResultsEvent {
    case done([Person])
}

enum ResultsAction {
    case get
}

final class ResultsStore: Store<ResultsEvent, ResultsAction> {
    let useCase: ResultsUseCaseProtocol
    init(useCase: ResultsUseCaseProtocol) {
        self.useCase = useCase
    }
    
    override func handleActions(action: ResultsAction) {
        switch action {
        case .get:
            statefulCall {
                try await self.get()
            }
        }
    }
    
    private func get() async throws {
        let persons = try await useCase.getPersons()
        sendEvent(.done(Array(persons.sorted(by: { $1 < $0}).prefix(10))))
    }
}
