import UIKit

final class MainTabBarController: UITabBarController {
    
    let networkManager: NetworkManagerProtocol
    
    
    //MARK: - Init -
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getNews(in: .viewed, over: .month) { data in
            
         //   print(data)
            
        }
    }
}
