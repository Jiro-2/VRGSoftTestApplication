import UIKit

protocol Coordinator: class {
    
    var navigationController: UINavigationController? { get }
    func start()
}


final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    private let screenFactory: ScreenFactoryProtocol
    
    init(screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
    }
    
    
    func start() {
        
        self.navigationController = UINavigationController(rootViewController: screenFactory.makeMainTabBarController())
    }
    
    
    func showDetails() {
        
        let vc = screenFactory.makeDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
