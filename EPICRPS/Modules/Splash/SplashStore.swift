import Combine

enum SplashEvent {
    case done(Person?)
}

enum SplashAction {
    case login
    case start(Person, Person)
}

final class SplashStore: Store<SplashEvent, SplashAction> {
    let useCase: SplashUseCaseProtocol
    init(useCase: SplashUseCaseProtocol) {
        self.useCase = useCase
    }
    
    override func handleActions(action: SplashAction) {
        switch action {
        case .login:
            statefulCall {
                try await self.login()
            }
        case .start(let current, let player):
            statefulCall {
                try await self.start(with: current, and: player)
            }
        }
    }
    
    private func login() async throws {
        let person = try await useCase.login()
        sendEvent(.done(person))
    }
    
    private func start(with current: Person, and player: Person) async throws {
        try await useCase.start(with: current, and: player)
    }
}


