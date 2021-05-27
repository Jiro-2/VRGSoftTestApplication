import UIKit

final class DetailViewController: UIViewController {
    
    private var articleURL: String?
    private var article: ArticleResponse?
    private let databaseManager: DatabaseManageable
    
    
    //MARK: - Subviews -
    
    
    private lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
    }()
    
    
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.numberOfLines = 0
        view.addSubview(label)
        return label
    }()
    
    
    private lazy var summaryLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 0
        view.addSubview(label)
        return label
    }()
    
    
    private lazy var authorLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        view.addSubview(label)
        return label
    }()

    
    private var favoriteButton: FavoriteButton?
    
    private lazy var openSafariButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "safari")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Open in Safari", for: .normal)
        button.layer.cornerRadius = 10.0
        view.addSubview(button)
        button.addAction(UIAction(handler: { _ in
            
            if let str = self.articleURL, let url = URL(string: str) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    
        
    
    
    //MARK: - Init -
    
    
    init(databaseManager: DatabaseManageable) {
        self.databaseManager = databaseManager
        super.init(nibName: nil, bundle: nil)
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
        
        setupFavoriteButton()
        setupLayout()
    }
    
    
    
    //MARK: - Methods -
    
    private func setupFavoriteButton() {
        
        guard let id = article?.id else { return }
        
        let button = FavoriteButton(isSelected: databaseManager.checkAvailabilityObjectInDB(ByID: id), frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.didTapBlock = {
            
            if let id = self.article?.id {
                
                let isFavoriteArticle = self.databaseManager.checkAvailabilityObjectInDB(ByID: id)
                
                if isFavoriteArticle {
                    
                    self.removeFromFavoritesArticle()
                  //  button.isSelected = true
                    button.backgroundColor = .systemRed
                    self.navigationController?.popViewController(animated: true)
                }
                
                
                if !isFavoriteArticle {
                    
                    self.addToFavoriteArticle()
                   // button.isSelected = false
                    button.backgroundColor = .systemBlue
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        self.favoriteButton = button
        
    }
    
    
    private func removeFromFavoritesArticle() {
        
        if let article = self.article {
            
            databaseManager.deleteObject(ByID: article.id)
        }
    }
    
    
    
    private func addToFavoriteArticle() {
        
        let imageData = self.imageView.image?.jpegData(compressionQuality: 0.9)
        
        if let article = self.article {
            
            self.databaseManager.saveObject(withProperties: ["id" : article.id,
                                                             "title" : article.title,
                                                             "summary" : article.abstract,
                                                             "url" : article.url,
                                                             "author" : article.author,
                                                             "imageData": imageData])
            
        }
    }
    
    
    
    
    
    
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 293),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            summaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            summaryLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            authorLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: summaryLabel.trailingAnchor),
            authorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            favoriteButton!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15.0),
            favoriteButton!.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            favoriteButton!.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            openSafariButton.bottomAnchor.constraint(equalTo: favoriteButton!.topAnchor, constant: -10),
            openSafariButton.widthAnchor.constraint(equalTo: favoriteButton!.widthAnchor),
            openSafariButton.heightAnchor.constraint(equalTo: favoriteButton!.heightAnchor),
            openSafariButton.centerXAnchor.constraint(equalTo: favoriteButton!.centerXAnchor)
        ])
    }
}



//MARK: - Extensions -


extension DetailViewController: MostSharedViewControllerDelegate {
    
    func viewController(_ viewController: MostSharedNewsViewController, didSelect article: ArticleResponse) {
        
        let imageURL = article.media.first?.metadata.last?.url
        imageView.setImage(withURL: imageURL)
        titleLabel.text = article.title
        summaryLabel.text = article.abstract
        authorLabel.text = article.author
        articleURL = article.url
        self.article = article
    }
}



extension DetailViewController: MostEmailedViewControllerDelegate {
    
    func viewController(_ mostEmailedViewController: MostEmailedViewController, didSelect article: ArticleResponse) {
        
        let imageURL = article.media.first?.metadata.last?.url
        imageView.setImage(withURL: imageURL)
        titleLabel.text = article.title
        summaryLabel.text = article.abstract
        authorLabel.text = article.author
        articleURL = article.url
        self.article = article
    }
}



extension DetailViewController: MostViewedViewControllerDelegate {
    
    func viewController(_ mostViewedViewController: MostViewedViewController, didSelect article: ArticleResponse) {
        
        let imageURL = article.media.first?.metadata.last?.url
        imageView.setImage(withURL: imageURL)
        titleLabel.text = article.title
        summaryLabel.text = article.abstract
        authorLabel.text = article.author
        articleURL = article.url
        self.article = article
    }
}


extension DetailViewController: FavoriteViewControllerDelegate {
    
    func viewController(_ favoriteViewController: FavoriteViewController, didSelect article: Article) {
        
        imageView.image = UIImage(data: article.imageData!)
        titleLabel.text = article.title
        summaryLabel.text = article.summary
        authorLabel.text = article.author
        articleURL = article.url
        
        
        if let title = article.title,
           let summary = article.summary,
           let url = article.url,
           let auth = article.author {
            
            self.article = ArticleResponse(id: Int(article.id),
                                           title: title,
                                           abstract: summary,
                                           url: url,
                                           author: auth,
                                           media: [])
            
        }
    }
}
