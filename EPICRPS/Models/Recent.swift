//
//  Recent.swift
//  EPICRPS
//
//  Created by WWDC on 14.06.2024.
//

import Foundation

struct Recent: Codable, Hashable {
    var id = "1"
    var name = "Player 1"
    var avatar = ""
    var male = false
    var hand: Int? = nil
    var currentId = "2"
    var currentName = "Player 2"
    var currentAvatar = ""
    var currentMale = true
    var currentHand: Int? = nil
    var text = "Ваш ход"
    var date = Date()
    var completed = false
    var playerCount = 0
    var currentCount = 0
    var round = 0
    
    static func create(from recent: Recent) -> Recent {
        var result = Recent()
        result.id = recent.currentId
        result.name = recent.currentName
        result.avatar = recent.currentAvatar
        result.male = recent.currentMale
        result.hand = recent.currentHand
        result.currentId = recent.id
        result.currentName = recent.name
        result.currentAvatar = recent.avatar
        result.currentMale = recent.male
        result.currentHand = recent.hand
        result.date = recent.date
        result.completed = recent.completed
        result.playerCount = recent.currentCount
        result.currentCount = recent.playerCount
        result.round = recent.round
        switch recent.text {
        case "Выиграл": result.text = "Проиграл"
        case "Проиграл": result.text = "Выиграл"
        case "Ждем": result.text = "Ваш ход"
        default: result.text = recent.text
        }
        return result
    }
    
    mutating func restart() {
        playerCount = 0
        currentCount = 0
        round = 0
        reset()
    }
    private mutating func win() {
        text = "Выиграл"
        currentCount += 1
    }
    
    public mutating func lose() {
        text = "Проиграл"
        playerCount += 1
    }
    
    private mutating func draw() {
        text = "Ничья"
    }
    
    public mutating func playRound() {
        text = "Ждем"
        guard let player = hand, let current = currentHand else { return }
        playRound(player: player, current: current)
    }
    
    public mutating func playRound(player: Int, current: Int) {
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
        completed = true
        round += 1
    }
    
    var playerImage: String {
        if let value = hand, currentHand != nil {
            switch value {
            case 0: return "femaleRock"
            case 1: return "femalePaper"
            default: return "femaleScissors"
            }
        } else {
            return "femaleHand"
        }
    }
    
    var currentImage: String {
        if let value = currentHand {
            switch value {
            case 0: return "maleRock"
            case 1: return "malePaper"
            default: return "maleScissors"
            }
        } else {
            return "maleHand"
        }
    }
    
    mutating func reset() {
        hand = nil
        currentHand = nil
        completed = false
        text = "Ваш ход"
    }
}
