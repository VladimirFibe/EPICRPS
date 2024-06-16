import Foundation

struct Person: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    var name: String
    var avatar = "firstPlayer"
    var male = true
    var win = 0
    var lose = 0
    var round = 1
    var winLabel: String { String(win)}
    var loseLabel: String { String(lose)}
}
