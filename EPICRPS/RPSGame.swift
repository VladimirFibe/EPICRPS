//
//  RPSGame.swift
//  EPICRPS
//
//  Created by WWDC on 13.06.2024.
//

import Foundation

struct RPSGame {
    var current: Int?
    var player: Int?
    var round = 1
    var rounds: [Round] = []
    var result = ""
    
    public mutating func setCurrent(_ value: Int) {
        current = value
        player = Int.random(in: 0..<3)
        playRound()
    }
    
    public mutating func setPlayer(_ value: Int) {
        player = value
        playRound()
    }
    
    private mutating func win() {
        result = "Выиграл"
    }
    
    private mutating func lose() {
        result = "Проиграл"
    }
    
    private mutating func draw() {
        result = "Ничья"
    }
    
    public mutating func playRound() {
        guard let player, let current else { return }
        rounds.append(Round(current: current, player: player))
        if current == player { draw()
        } else if current == 2 {
            if player == 1 { win()
            } else { lose() }
        } else if current == 1 {
            if player == 0 { win()
            } else { lose() }
        } else {
            if player == 2 {  win()
            } else {  lose()  }
        }
        round += 1
    }
}

struct Round {
    let current: Int
    let player: Int
}
