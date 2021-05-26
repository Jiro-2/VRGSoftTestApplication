import UIKit

final class DetailViewController: UIViewController {

    
    private var articleURL: String?
    
    
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
    
    
    
    private lazy var openSafariButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "safari"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Open in Safari", for: .normal)
        view.addSubview(button)
        button.addAction(UIAction(handler: { _ in
            
            if let str = self.articleURL, let url = URL(string: str) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    
    
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
   
    
    //MARK: - Methods -
    
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
            
            openSafariButton.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            openSafariButton.trailingAnchor.constraint(equalTo: summaryLabel.trailingAnchor)
        ])
    }
}



//MARK: - Extensions -


extension DetailViewController: MostSharedViewControllerDelegate {
    
    func viewController(_ viewController: MostSharedNewsViewController, didSelect article: Article) {
        
            let imageURL = article.media.first?.metadata.last?.url
            imageView.setImage(withURL: imageURL)
            titleLabel.text = article.title
            summaryLabel.text = article.abstract
            authorLabel.text = article.author
            articleURL = article.url
    }
}



extension DetailViewController: MostEmailedViewControllerDelegate {
    
    func viewController(_ mostEmailedViewController: MostEmailedViewController, didSelect article: Article) {
        
            let imageURL = article.media.first?.metadata.last?.url
            imageView.setImage(withURL: imageURL)
            titleLabel.text = article.title
            summaryLabel.text = article.abstract
            authorLabel.text = article.author
            articleURL = article.url
    }
}



extension DetailViewController: MostViewedViewControllerDelegate {
    
    func viewController(_ mostViewedViewController: MostViewedViewController, didSelect article: Article) {
    
        let imageURL = article.media.first?.metadata.last?.url
        imageView.setImage(withURL: imageURL)
        titleLabel.text = article.title
        summaryLabel.text = article.abstract
        authorLabel.text = article.author
        articleURL = article.url
    }
}
