import UIKit

protocol FavoriteViewControllerDelegate: class {
    
    func viewController(_ favoriteViewController: FavoriteViewController, didSelect article: Article)
}

class FavoriteViewController: UIViewController {

    var coordinator: AppCoordinator?
    var delegate: FavoriteViewControllerDelegate?
    private let databaseManager: DatabaseManageable
    private var articles = [Article]()
        
      
    private lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.frame = view.frame
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: "news_cell_id")
        table.rowHeight = 100
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        return table
    }()
    
    
    
    //MARK: - Init -
    
    init(databaseManager: DatabaseManageable) {
        
        self.databaseManager = databaseManager
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadFavoriteArticles()
    }
    
    
    //MARK: - Methods -
    
    
    private func downloadFavoriteArticles() {
        
        databaseManager.fetchObjects(Article.self) { objects in
            
            guard let favoriteArticles = objects as? [Article] else { return }
            self.articles = favoriteArticles
           
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}




extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "news_cell_id") as? NewsTableViewCell
        cell?.titleLabel.text = articles[indexPath.row].title
        cell?.summaryArticleLabel.text = articles[indexPath.row].summary
        
        if let data = articles[indexPath.row].imageData {
            
            cell?.imageView?.image = UIImage(data: data)
        }
        
        return cell ?? UITableViewCell()
    }
}



extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        coordinator?.showDetails()
        let lastViewController = coordinator?.navigationController?.viewControllers.last
        let detailViewController = lastViewController as? FavoriteViewControllerDelegate
        delegate = detailViewController
        delegate?.viewController(self, didSelect: articles[indexPath.row])
    }
}
