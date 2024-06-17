import Combine

enum RoundEvent {
    case done
}

enum RoundAction {
    case round(Int)
    case flip
    case lose
    case random
}

final class RoundStore: Store<RoundEvent, RoundAction> {
    let useCase: RoundUseCaseProtocol
    init(useCase: RoundUseCaseProtocol) {
        self.useCase = useCase
    }
    
    override func handleActions(action: RoundAction) {
        switch action {
        case .round(let hand):
            statefulCall {
                try await self.round(hand)
            }
        case .lose:
            statefulCall {
                try await self.lose()
            }
        case .flip:
            statefulCall {
                try await self.flip()
            }
        case .random:
            statefulCall {
                try await self.random()
            }
        }
    }
    
    private func flip() async throws {
        try await useCase.flip()
    }
    private func round(_ hand: Int) async throws {
        try await useCase.round(hand)
        sendEvent(.done)
    }
    
    private func lose() async throws {
        try await useCase.lose()
        sendEvent(.done)
    }
    
    private func random() async throws {
        try await useCase.round()
        sendEvent(.done)
    }
}
