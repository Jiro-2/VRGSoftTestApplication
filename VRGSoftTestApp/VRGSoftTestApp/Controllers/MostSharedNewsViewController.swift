import UIKit


protocol MostSharedViewControllerDelegate: class {
    
    func viewController(_ viewController: MostSharedNewsViewController, didSelect article: Article)
}


final class MostSharedNewsViewController: UIViewController {
    
    //MARK: - Properties -
    
    var coordinator: AppCoordinator?
    var delegate: MostSharedViewControllerDelegate?
    private let networkManager: NetworkManagerProtocol
    private var sharedArticles = [Article]()
    
    
    //MARK: - subview
    
    private lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: "news_cell_id")
        table.rowHeight = 100
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        return table
    }()
    
    
    //MARK: - Init -
    
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
        tabBarItem.image = UIImage(systemName: "hand.thumbsup.fill")
        tabBarItem.title = "Most Shared"
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getNews(in: .shared, over: .month) { response in
            
            guard let articles = response?.results else { return }
            self.sharedArticles = articles
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
        
        view.backgroundColor = .yellow
        setupLayout()
    }
    
    
    //MARK: - Methods -
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


//MARK: - Extension -


extension MostSharedNewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sharedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "news_cell_id") as? NewsTableViewCell
        
        let imageURL = sharedArticles[indexPath.row].media.first?.metadata.first?.url
        cell?.imageView?.setImage(withURL: imageURL)
        
        cell?.titleLabel.text = sharedArticles[indexPath.row].title
        cell?.summaryArticleLabel.text = sharedArticles[indexPath.row].abstract
        
        return cell ?? UITableViewCell()
    }
}



extension MostSharedNewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        coordinator?.showDetails()
        let lastViewController = coordinator?.navigationController?.viewControllers.last
        let detailViewController = lastViewController as? MostSharedViewControllerDelegate
        delegate = detailViewController
        delegate?.viewController(self, didSelect: sharedArticles[indexPath.row])
    }
}
