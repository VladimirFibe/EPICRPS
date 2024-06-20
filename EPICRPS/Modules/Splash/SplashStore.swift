import Combine

enum SplashEvent {
    case done([Recent])
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
        let _ = try await useCase.login()
        downloadRecents()
    }
    
    private func downloadRecents() {
        useCase.downloadRecentChats { recents in
            self.sendEvent(.done(recents))
        }
    }
}


