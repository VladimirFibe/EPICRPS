import Foundation

struct Person: Identifiable, Hashable, Codable, Comparable {
    var id = UUID().uuidString
    var name: String
    var avatar = "firstPlayer"
    var male = true
    var win = 0
    var lose = 0
    var round = 0
    var bot = true
    var status = Status()
    
    var winLabel: String { String(win)}
    var loseLabel: String { String(lose)}
    var percent: Double { 100.0 * (Double(win) / Double(max(1, round))) }
    var percentString: String { String(format: "%.0f", percent) + "%" }
    var score: String { (500 * win).formatted() }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.percent < rhs.percent
    }
}

extension Person {
    struct Status: Codable, Hashable {
        var index = 0
        var statuses = ["Available", "Busy"]
        var text: String {
            index < statuses.count ? statuses[index] : "No status"
        }
    }
}
