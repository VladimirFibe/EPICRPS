//
//  RoundService.swift
//  EPICRPS
//
//  Created by WWDC on 14.06.2024.
//

import Foundation

protocol RoundServiceProtocol {
    func round(_ hand: Int) async throws -> Recent
    func reset() async throws
    func restart() async throws
}

final class RoundService: RoundServiceProtocol {
    var recent: Recent
    
    init(recent: Recent) {
        self.recent = recent
    }
    
    func round(_ hand: Int) async throws -> Recent {
        recent.currentHand = hand
        let random = Int.random(in: 0..<3)
        recent.hand = random
        recent.playRound(player: random, current: hand)
        return recent
    }
    
    func reset() async throws {
        recent.reset()
    }
    
    func restart() async throws {
        recent.restart()
    }
}
