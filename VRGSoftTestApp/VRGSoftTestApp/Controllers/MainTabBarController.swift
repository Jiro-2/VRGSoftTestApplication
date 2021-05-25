import UIKit

final class MainTabBarController: UITabBarController {

   
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
    }
}
