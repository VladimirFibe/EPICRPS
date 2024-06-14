//
//  RoundStore.swift
//  EPICRPS
//
//  Created by WWDC on 14.06.2024.
//

import Combine

enum RoundEvent {
    case done(Recent)
}

enum RoundAction {
    case round(Int)
    case reset
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
        }
    }
    
    private func round(_ hand: Int) async throws {
        let recent = try await useCase.round(hand)
        sendEvent(.done(recent))
    }
    
    private func reset() async throws {
        try await useCase.reset()
    }
}
