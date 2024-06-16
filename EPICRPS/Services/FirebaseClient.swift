import FirebaseAuth
import FirebaseFirestore

final class FirebaseClient {
    static let shared = FirebaseClient()
    var person: Person? {
        didSet {
            if let person {
                recent.currentName = person.name
                recent.currentId = person.id
                recent.currentCount = 0
                recent.currentAvatar = person.avatar
            }
        }
    }
    var friend: Person? {
        didSet {
            if let friend {
                recent.name = friend.name
                recent.id = friend.id
                recent.playerCount = 0
                recent.avatar = friend.avatar
            }
        }
    }
    var recent = Recent()
    private init() {}
}
// MARK: - Auth
extension FirebaseClient {
    func createUser() async throws {
        if Auth.auth().currentUser == nil {
            let authResult = try await Auth.auth().signInAnonymously()
            try createPerson(with: authResult.user.uid)
        } else {
            try await fetchPerson()
        }
    }
}
// MARK: - Person
extension FirebaseClient {
    func createPerson(with uid: String) throws {
        person = Person(id: uid, name: uid)
        try Firestore.firestore().collection("persons").document(uid).setData(from: person)
    }

    func fetchPerson() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let querySnapshot = try await Firestore.firestore().collection("persons").document(uid).getDocument()
        if let result = try? querySnapshot.data(as: Person.self) {
            person = result
        }
    }
}
