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
    func lose() async throws -> Recent
}

extension LocalService: RoundServiceProtocol {
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
        var current = currentPerson
        current.win += recent.currentCount
        current.lose += recent.playerCount
        currentPerson = current
        var friend = friendPerson
        friend.win += recent.playerCount
        friend.lose += recent.currentCount
        friendPerson = friend
        recent.restart()
    }
    
    func lose() async throws -> Recent {
        recent.lose()
        return recent
    }
    
    
}
