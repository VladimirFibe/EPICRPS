import UIKit

enum EditProfileEvent {
    case done
}

enum EditProfileAction {
    case updateUsername(String)
    case uploadImage(UIImage)
    case updateAvatarLink(String)
    case updateBot
    case updateSex
    case fetch
}

final class EditProfileStore: Store<EditProfileEvent, EditProfileAction> {
    private let useCase = FirebaseClient.shared

    override func handleActions(action: EditProfileAction) {
        switch action {
        case .updateUsername(let username):
            statefulCall { [weak self] in
                try self?.updateUsername(username)
            }
        case .uploadImage(let image):
            statefulCall { [weak self] in
                try await self?.uploadImage(image)
            }
        case .updateAvatarLink(let link):
            statefulCall { [weak self] in
                try self?.updateAvatarLink(link)
            }
        case .fetch:
            statefulCall { [weak self] in
                try await self?.fetchPerson()
            }
        case .updateBot:
            statefulCall { [weak self] in
                try self?.updateBot()
            }
        case .updateSex:
            statefulCall { [weak self] in
                try self?.updateSex()
            }
        }
    }
    
    private func updateBot() throws {
        try useCase.updateBot()
        sendEvent(.done)
    }
    
    private func updateSex() throws {
        try useCase.updateSex()
        sendEvent(.done)
    }

    private func updateAvatarLink(_ link: String) throws {
        try useCase.updateAvatar(link)
    }

    private func updateUsername(_ username: String) throws {
        try useCase.updateUsername(username)
    }

    private func uploadImage(_ image: UIImage) async throws {
        if let url = try await useCase.uploadImage(image) {
            try useCase.updateAvatar(url)
        }
    }

    private func fetchPerson() async throws {
        try await useCase.fetchPerson()
        sendEvent(.done)
    }
}
