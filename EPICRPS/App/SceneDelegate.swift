import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: makeSplashController())
        window?.makeKeyAndVisible()
    }
    
    private func makeSplashController() -> UIViewController {
        let useCase = SplashUseCase(service: FirebaseClient.shared)
        let store = SplashStore(useCase: useCase)
        return SplashViewController(store: store)
    }
}

