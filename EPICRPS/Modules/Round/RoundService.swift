import Foundation

protocol RoundServiceProtocol {
    func round(_ hand: Int) async throws
    func lose() async throws
}

extension FirebaseClient: RoundServiceProtocol {
    func round(_ hand: Int) async throws {
        if let updatedRecent = try await updateRecent(recent) {
            recent = updatedRecent
        }
        guard recent.currentHand == nil else { return }
        recent.currentHand = hand
        recent.playRound()
        saveRecent(recent)
        if recent.completed {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                var newRecent = self.recent
                if newRecent.currentCount == 3 || newRecent.playerCount == 3 {
                    guard var person = self.person, var friend = self.friend else { return }
                    person.lose += newRecent.playerCount
                    person.win += newRecent.currentCount
                    person.round += newRecent.round
                    friend.lose += newRecent.currentCount
                    friend.win += newRecent.playerCount
                    friend.round = newRecent.round
                    newRecent.restart()
                } else {
                    newRecent.reset()
                }
                self.saveRecent(newRecent)
            }
        }
    }
    
    func reset() async throws {
        recent.reset()
        saveRecent(recent)
    }
    
    func restart() async throws {
        recent.restart()
        saveRecent(recent)
    }
    
    func lose() async throws {
        recent.lose()
        saveRecent(recent)
    }
}

