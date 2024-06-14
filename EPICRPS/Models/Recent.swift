//
//  Recent.swift
//  EPICRPS
//
//  Created by WWDC on 14.06.2024.
//

import Foundation

struct Recent: Codable, Hashable {
    var id: String
    var name: String
    var avatar = ""
    var male = false
    var hand: Int? = nil
    var currentId: String
    var currentName: String
    var currentAvatar = ""
    var currentMale = true
    var currentHand: Int? = nil
    var text = "Ваш ход"
    var date = Date()
    var completed = true
    var playerCount = 0
    var currentCount = 0
    var round = 1
    
    mutating func restart() {
        playerCount = 0
        currentCount = 0
        text = "Ваш ход"
    }
    private mutating func win() {
        text = "Выиграл"
        currentCount += 1
    }
    
    private mutating func lose() {
        text = "Проиграл"
        playerCount += 1
    }
    
    private mutating func draw() {
        text = "Ничья"
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
        text = "Ваш ход"
    }
}
