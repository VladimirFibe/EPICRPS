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
    var date = Date()
    var completed = false
    var playerCount = 0
    var currentCount = 0
    var round = 0
    var status: Status = .wait
    
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
        result.date = Date()
        result.completed = recent.completed
        result.playerCount = recent.currentCount
        result.currentCount = recent.playerCount
        result.round = recent.round
        switch recent.status {
        case .win:
            result.status = .lose
        case .lose:
            result.status = .win
        default:
            result.status = recent.status
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
        status = .win
        currentCount += 1
    }
    
    public mutating func lose() {
        status = .lose
        playerCount += 1
    }
    
    private mutating func draw() {
        status = .draw
    }
    
    public mutating func playRound() {
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
        status = .wait
    }
    
    enum Status: Int, Codable {
        case wait
        case draw
        case win
        case lose
        
        var title: String {
            switch self {
            case .wait: return "FIGHT"
            case .draw: return "DRAW"
            case .win: return "WIN"
            case .lose: return "LOSE"
            }
        }
    }
}
