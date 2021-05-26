import UIKit

final class FavoriteButton: UIButton {
    
    
    //MARK: - Properties -
    
    var didTapButtonBlock: (() -> ())?

    private let selectedImage = UIImage(systemName: "star.fill")
    private let unSelectedImage = UIImage(systemName: "star")
    
    
    //MARK: - Init -
    
    init(isSelected: Bool = true, frame: CGRect) {
        super.init(frame: frame)
        self.isSelected = Bool.random()
        sizeToFit()
        setAction()
        
        self.setBackgroundImage(selectedImage, for: .selected)
        self.setBackgroundImage(unSelectedImage?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
    
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Methods -
    
    
    private func setAction() {
        
        self.addAction(UIAction(handler: { [weak self] _ in
            
            guard let self = self else { return }
            
            if self.isSelected {
                
                self.isSelected = false

            } else {
                
                self.isSelected = true
            }
            
            self.didTapButtonBlock?()
            
        }), for: .touchUpInside)
    }
}
