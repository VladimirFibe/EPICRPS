import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

final class FirebaseClient {
    static let shared = FirebaseClient()
    var recentListener: ListenerRegistration?
    var person: Person?
    var friend: Person? 
    var recent = Recent()
    private init() {}
}
// MARK: - Auth
extension FirebaseClient {
    func createUser() async throws {
        if Auth.auth().currentUser == nil {
            let authResult = try await Auth.auth().signInAnonymously()
            person = try await createPerson(with: authResult.user.uid)
        } else {
            try await fetchPerson()
        }
//        if let uid = person?.id {
//            if uid == "hnxweZx9k9PwRtVQubku8Fwton02" {
//                friend = try await fetchPerson(with: "GnZToxxrwAgzhUjqd9txhdmZDF33")
//            } else {
//                friend = try await fetchPerson(with: "hnxweZx9k9PwRtVQubku8Fwton02")
//            }
//        }
    }
}
// MARK: - Person
extension FirebaseClient {
    func createPerson(with uid: String) async throws -> Person {
        let person = Person(id: uid, name: uid)
        try Firestore.firestore().collection("persons").document(uid).setData(from: person)
        return person
    }

    func fetchPerson() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let querySnapshot = try await Firestore.firestore().collection("persons").document(uid).getDocument()
        if let result = try? querySnapshot.data(as: Person.self) {
            person = result
        }
    }
    
    func fetchPerson(with uid: String) async throws -> Person? {
        let querySnapshot = try await Firestore.firestore().collection("persons").document(uid).getDocument()
        return try querySnapshot.data(as: Person.self)
    }
    
    func fetchPersons() async throws -> [Person] {
        guard let id = Auth.auth().currentUser?.uid else { return [] }
        let query = try await Firestore.firestore().collection("persons")
            .whereField("id", isNotEqualTo: id)
            .limit(to: 50).getDocuments()
        return query.documents.compactMap { try? $0.data(as: Person.self)}
    }
    
    func updateAvatar(_ url: String) throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        person?.avatar = url
        try Firestore.firestore().collection("persons")
            .document(uid)
            .setData(from: person)
    }

    func updateUsername(_ name: String) throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        person?.name = name
        try Firestore.firestore().collection("persons")
            .document(uid)
            .setData(from: person)
    }
    
    func updatePerson(_ person: Person) {
        try? Firestore.firestore().collection("persons")
            .document(person.id)
            .setData(from: person)
    }

    func uploadImage(_ image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.6),
                let uid = Auth.auth().currentUser?.uid
        else { return nil }
        let path = "/profile/\(uid).jpg"
        let ref = Storage.storage().reference(withPath: path)
        let _ = try await ref.putDataAsync(imageData)
        let url = try await ref.downloadURL()
        return url.absoluteString
    }
}
// MARK: - Recent
extension FirebaseClient {
    func createRecent(with current: Person, and player: Person) async throws -> Recent {
        if let recent = try await fetchRecent(with: player.id) {
            return recent
        } else {
            let recent = Recent(
                id: player.id, 
                name: player.name,
                avatar: player.avatar,
                male: player.male,
                currentId: current.id,
                currentName: current.name,
                currentAvatar: current.avatar,
                currentMale: current.male
            )
            saveRecent(recent)
            return recent
        }
    }
    
    func fetchRecent(with friendId: String) async throws -> Recent? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil  }
        let querySnapshot = try await Firestore.firestore().collection("messages")
            .document(uid)
            .collection("recents")
            .document(friendId)
            .getDocument()
        return try? querySnapshot.data(as: Recent.self)
    }
    
    func updateRecent(_ recent: Recent) async throws -> Recent? {
        let querySnapshot = try await Firestore.firestore().collection("messages")
            .document(recent.currentId)
            .collection("recents")
            .document(recent.id)
            .getDocument()
        return try? querySnapshot.data(as: Recent.self)
    }
    
    func saveRecent(_ recent: Recent) {
        try? Firestore.firestore().collection("messages")
            .document(recent.currentId)
            .collection("recents")
            .document(recent.id)
            .setData(from: recent)
        
        try? Firestore.firestore().collection("messages")
            .document(recent.id)
            .collection("recents")
            .document(recent.currentId)
            .setData(from: Recent.create(from: recent))
    }
    
    func saveRecent(hand: Int) {
        Firestore.firestore().collection("messages")
            .document(recent.currentId)
            .collection("recents")
            .document(recent.id)
            .updateData(["currentHand": hand])
        
        Firestore.firestore().collection("messages")
            .document(recent.id)
            .collection("recents")
            .document(recent.currentId)
            .updateData(["hand": hand])
    }
    
    func createRecentObserver(completion: @escaping (Recent) -> Void) {
        recentListener = Firestore.firestore().collection("messages")
            .document(recent.currentId)
            .collection("recents")
            .document(recent.id)
            .addSnapshotListener { snapshot, _ in
                if let snapshot,
                    let result = try? snapshot.data(as: Recent.self) {
                    self.recent = result
                    completion(result)
                }
            }
    }
    
    func downloadRecentChatsFromFireStore(completion: @escaping ([Recent]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("messages")
            .document(uid)
            .collection("recents")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }
                let recents = documents.compactMap {  try? $0.data(as: Recent.self)}
                completion(recents)
            }
    }
}
