import Combine

enum RoundEvent {
    case done(Recent)
}

enum RoundAction {
    case round(Int)
    case reset
    case restart
    case lose
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
        case .reset:
            statefulCall {
                try await self.reset()
            }
        case .restart:
            statefulCall {
                try await self.restart()
            }
        case .lose:
            statefulCall {
                try await self.lose()
            }
        }
    }
    
    private func round(_ hand: Int) async throws {
        let recent = try await useCase.round(hand)
        sendEvent(.done(recent))
    }
    
    private func reset() async throws {
        try await useCase.reset()
    }
    
    private func restart() async throws {
        try await useCase.restart()
    }
    
    private func lose() async throws {
        let recent = try await useCase.lose()
        sendEvent(.done(recent))
    }
}
