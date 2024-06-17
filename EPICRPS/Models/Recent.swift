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
    var male = true
    var hand = 0
    var currentId = "2"
    var currentName = "Player 2"
    var currentAvatar = ""
    var currentMale = false
    var currentHand = 0
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
        guard hand != 0, currentHand != 0 else { return }
        if hand == currentHand { draw()
        } else if currentHand == 3 {
            if hand == 2 { win()
            } else { lose() }
        } else if currentHand == 2 {
            if hand == 1 { win()
            } else { lose() }
        } else {
            if hand == 3 {  win()
            } else {  lose()  }
        }
        completed = true
        round += 1
    }
    
    var upImage: String {
        currentHand == 0 
        ? "\(male ? "m" : "f")uhand0"
        : "\(male ? "m" : "f")uhand\(hand)"
    }
    
    var downImage: String {
        "\(currentMale ? "m" : "f")dhand\(currentHand)"
    }
    
    mutating func reset() {
        hand = 0
        currentHand = 0
        completed = false
        text = "Ваш ход"
    }
}
