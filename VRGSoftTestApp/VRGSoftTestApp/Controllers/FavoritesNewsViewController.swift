import UIKit

class FavoritesNewsViewController: UIViewController {

    
    //MARK: - Init -
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}
