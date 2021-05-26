import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    
    //MARK: - Subviews -
    
    var favoriteButton = FavoriteButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    
    lazy var titleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    
    lazy var summaryArticleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    
    //MARK: - Init -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryView = favoriteButton
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods -
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            
            summaryArticleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            summaryArticleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            summaryArticleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            summaryArticleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0)
        ])
    }
}
