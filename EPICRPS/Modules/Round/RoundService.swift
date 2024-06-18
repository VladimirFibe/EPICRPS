import Foundation

protocol RoundServiceProtocol {
    func round(_ hand: Int) async throws
    func lose() async throws
    func flip() async throws -> Recent?
    func round() async throws
}

extension FirebaseClient: RoundServiceProtocol {
    func flip() async throws -> Recent? {
        var result: Recent? = nil
        if recent.currentCount == 3 || recent.playerCount == 3 {
            result = recent
            person = try await fetchPerson(with: recent.currentId)
            friend = try await fetchPerson(with: recent.id)
            guard var person = self.person, var friend = self.friend else { return nil }
            person.lose += recent.playerCount
            person.win += recent.currentCount
            person.round += recent.round
            updatePerson(person)
            friend.lose += recent.currentCount
            friend.win += recent.playerCount
            friend.round += recent.round
            updatePerson(friend)
            recent.restart()
        } else {
            recent.reset()
        }
        self.saveRecent(recent)
        return result
    }
    
    func round() async throws {
        if let updatedRecent = try await updateRecent(recent) {
            recent.hand = updatedRecent.hand
        }
        guard recent.hand == 0, recent.currentHand != 0 else { return }
        recent.hand = Int.random(in: 1...3)
        recent.playRound()
        saveRecent(recent)
    }
    
    func round(_ hand: Int) async throws {
        if let updatedRecent = try await updateRecent(recent) {
            recent = updatedRecent
        }
        guard recent.currentHand == 0 else { return }
        recent.currentHand = hand
        recent.playRound()
        saveRecent(recent)
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

