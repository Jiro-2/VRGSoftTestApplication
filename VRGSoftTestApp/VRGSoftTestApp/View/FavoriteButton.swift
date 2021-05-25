import UIKit

final class FavoriteButton: UIButton {
    
    
    //MARK: - Properties -
    
    var didTapButtonBlock: (() -> ())?
    var isFavorite: Bool
    
    
    //MARK: - Init -
    
    init(isFavorite: Bool = false, frame: CGRect) {
        self.isFavorite = isFavorite
        super.init(frame: frame)
        sizeToFit()
        setAction()
        setImage()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Methods -
    
    
    private func setAction() {
        
        self.addAction(UIAction(handler: { _ in
                        
            if self.isFavorite {
                
                self.isFavorite = false
                
            } else {
                
                self.isFavorite = true
            }
            
            self.setImage()
            self.didTapButtonBlock?()
            
        }), for: .touchUpInside)
    }
    
    
    
    private func setImage() {
        
        if isFavorite {
            
            setImage(UIImage(systemName: "star.fill"), for: .normal)
            tintColor = .blue
        
        } else {
            
            setImage(UIImage(systemName: "star"), for: .normal)
            tintColor = .gray
        }
    }
}
