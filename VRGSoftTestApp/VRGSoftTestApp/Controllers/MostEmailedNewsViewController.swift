import UIKit

final class MostEmailedNewsViewController: UIViewController {
    
    var coordinator: AppCoordinator?
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
        tabBarItem.tag = 2
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
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
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


extension MostEmailedNewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emailedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        NewsTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let newsCell = cell as? NewsTableViewCell else { return }
        newsCell.titleLabel.text = emailedArticles[indexPath.row].title
        newsCell.summaryArticleLabel.text = emailedArticles[indexPath.row].abstract
    }
}


extension MostEmailedNewsViewController: UITableViewDelegate {}
