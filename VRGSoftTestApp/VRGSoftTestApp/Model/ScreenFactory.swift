import UIKit

protocol ScreenFactoryProtocol {
    
    func makeMostEmailedViewController() -> UIViewController
    func makeMostViewedViewController() -> UIViewController
    func makeMostSharedViewController() -> UIViewController
    func makeDetailViewController() -> UIViewController
    func makeMainTabBarController() -> UIViewController
    func makeFavoritesNewsViewController() -> UIViewController
}



final class ScreenFactory: ScreenFactoryProtocol {
    
    var coordinator: AppCoordinator?
    let networkManager = NetworkManager()
    
    
    func makeDetailViewController() -> UIViewController {
        DetailViewController()
    }
    
    
    func makeMostEmailedViewController() -> UIViewController {
        
        let vc = MostEmailedNewsViewController(networkManager: networkManager)
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeMostViewedViewController() -> UIViewController {
        
        let vc = MostViewedNewsViewController(networkManager: networkManager)
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeMostSharedViewController() -> UIViewController {
        
        let vc = MostSharedNewsViewController(networkManager: networkManager)
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeFavoritesNewsViewController() -> UIViewController {
        FavoritesNewsViewController()
    }
    
    
    func makeMainTabBarController() -> UIViewController {
        
        let networkManager = NetworkManager()
        
        let tabBarController = MainTabBarController(networkManager: networkManager)
        tabBarController.viewControllers = [makeMostViewedViewController(),
                                            makeMostSharedViewController(),
                                            makeMostEmailedViewController(),
                                            makeFavoritesNewsViewController()]
        return tabBarController
    }
}
