//
//  RoundUseCase.swift
//  EPICRPS
//
//  Created by WWDC on 14.06.2024.
//

import Foundation

protocol RoundUseCaseProtocol {
    func round(_ hand: Int) async throws -> Recent
    func reset() async throws
}

final class RoundUseCase: RoundUseCaseProtocol {
    private let service: RoundServiceProtocol
    
    init(service: RoundServiceProtocol) {
        self.service = service
    }
    
    func round(_ hand: Int) async throws -> Recent {
        try await service.round(hand)
    }
    
    func reset() async throws {
        try await service.reset()
    }
}
