import Combine

enum SplashEvent {
    case done(Person?)
}

enum SplashAction {
    case login
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
        }
    }
    
    private func login() async throws {
        let person = try await useCase.login()
        sendEvent(.done(person))
    }
}


