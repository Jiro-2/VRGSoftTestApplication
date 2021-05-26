import UIKit


protocol MostEmailedViewControllerDelegate: class {
    
    func viewController(_ mostEmailedViewController: MostEmailedViewController, didSelect article: Article)
}


final class MostEmailedViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    var delegate: MostEmailedViewControllerDelegate?
    private let networkManager: NetworkManagerProtocol
    private var emailedArticles = [Article]()
    
    //MARK: - Subview
    
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
        tabBarItem.image = UIImage(systemName: "envelope.fill")
        tabBarItem.title = "Most Emailed"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getNews(in: .emailed, over: .month) { response in
            
            guard let articles = response?.results else { return }
            self.emailedArticles = articles
            self.tableView.reloadData()
        }
        
        view.backgroundColor = .blue
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


extension MostEmailedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emailedArticles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "news_cell_id") as? NewsTableViewCell
        
        let imageURL = emailedArticles[indexPath.row].media.first?.metadata.first?.url
        cell?.imageView?.setImage(withURL: imageURL)
        
        cell?.titleLabel.text = emailedArticles[indexPath.row].title
        cell?.summaryArticleLabel.text = emailedArticles[indexPath.row].abstract
        
        return cell ?? UITableViewCell()
        
    }
}


extension MostEmailedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        coordinator?.showDetails()
        let lastViewController = coordinator?.navigationController?.viewControllers.last
        let detailViewController = lastViewController as? MostEmailedViewControllerDelegate
        delegate = detailViewController
        delegate?.viewController(self, didSelect: emailedArticles[indexPath.row])
    }
}
