import UIKit

protocol ScreenFactoryProtocol {
    
    func makeMostEmailedViewController() -> UIViewController
    func makeMostViewedViewController() -> UIViewController
    func makeMostSharedViewController() -> UIViewController
    func makeDetailViewController() -> UIViewController
    func makeMainTabBarController() -> UIViewController
    func makeFavoriteViewController() -> UIViewController
}



final class ScreenFactory: ScreenFactoryProtocol {
    
    var coordinator: AppCoordinator?
    let networkManager = NetworkManager()
    let databaseManager = NewsDBManager()
    
    
    func makeDetailViewController() -> UIViewController {
        DetailViewController(databaseManager: databaseManager)
    }
    
    
    func makeMostEmailedViewController() -> UIViewController {
        
        let vc = MostEmailedViewController(networkManager: networkManager)
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeMostViewedViewController() -> UIViewController {
        
        let vc = MostViewedViewController(networkManager: networkManager,
                                          databaseManager: databaseManager)
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeMostSharedViewController() -> UIViewController {
        
        let vc = MostSharedNewsViewController(networkManager: networkManager)
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeFavoriteViewController() -> UIViewController {
        
        let vc = FavoriteViewController(databaseManager: databaseManager)
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeMainTabBarController() -> UIViewController {
                
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [makeMostViewedViewController(),
                                            makeMostSharedViewController(),
                                            makeMostEmailedViewController(),
                                            makeFavoriteViewController()]
        return tabBarController
    }
}
