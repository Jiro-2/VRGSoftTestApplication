import UIKit
import SDWebImage

protocol MostViewedViewControllerDelegate: class {
    
    func viewController(_ mostViewedViewController: MostViewedViewController, didSelect article: Article)
}


final class MostViewedViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    var delegate: MostViewedViewControllerDelegate?
    private let networkManager: NetworkManagerProtocol
    private var viewedArticles = [Article]()
    
    
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
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getNews(in: .viewed, over: .month) { response in
            
            guard let articles = response?.results else { return }
            self.viewedArticles = articles
            self.tableView.reloadData()
        }
        
        view.backgroundColor = .green
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


extension MostViewedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "news_cell_id") as? NewsTableViewCell
        
        let imageURL = viewedArticles[indexPath.row].media.first?.metadata.first?.url
        cell?.imageView?.setImage(withURL: imageURL)
        
        cell?.titleLabel.text = viewedArticles[indexPath.row].title
        cell?.summaryArticleLabel.text = viewedArticles[indexPath.row].abstract
        
        return cell ?? UITableViewCell()
    }
}


extension MostViewedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        coordinator?.showDetails()
        let lastViewController = coordinator?.navigationController?.viewControllers.last
        let detailViewController = lastViewController as? MostViewedViewControllerDelegate
        delegate = detailViewController
        delegate?.viewController(self, didSelect: viewedArticles[indexPath.row])
    }
}
