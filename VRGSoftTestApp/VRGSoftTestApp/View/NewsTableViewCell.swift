import UIKit

final class NewsTableViewCell: UITableViewCell {

    //MARK: - Properties -
    
    var favoriteButtonBlock: (() -> ())?
    var favoriteButton = FavoriteButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    
    //MARK: - Init -

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryView = favoriteButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
