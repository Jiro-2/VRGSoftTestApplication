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
    
    func makeDetailViewController() -> UIViewController {
        DetailViewController()
    }
    
    
    func makeMostEmailedViewController() -> UIViewController {
        
        let vc = MostEmailedNewsViewController()
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeMostViewedViewController() -> UIViewController {
        
        let vc = MostViewedNewsViewController()
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeMostSharedViewController() -> UIViewController {
        
        let vc = MostSharedNewsViewController()
        vc.coordinator = coordinator
        return vc
    }
    
    
    func makeFavoritesNewsViewController() -> UIViewController {
        FavoritesNewsViewController()
    }
    
    
    func makeMainTabBarController() -> UIViewController {
        
        let tabBarController = MainTabBarController()
        tabBarController.viewControllers = [makeMostViewedViewController(),
                                            makeMostSharedViewController(),
                                            makeMostEmailedViewController(),
                                            makeFavoritesNewsViewController()]
        return tabBarController
    }
}
