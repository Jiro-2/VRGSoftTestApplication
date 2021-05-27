import UIKit

final class FavoriteButton: UIButton {
    
    
    var didTapBlock: (() -> ())?
    
    private let selectImage = UIImage(systemName: "square.and.arrow.down.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    private let unSelectImage = UIImage(systemName: "multiply.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    
    
    //MARK: -Init -
    
    init(isSelected: Bool = false, frame: CGRect) {
        super.init(frame: frame)
        self.isSelected = isSelected
        setupStyle()
        setupAction()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods -
    
    private func setupStyle() {
        
        
        setTitleColor(.white, for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        layer.cornerRadius = 10.0
        
        if isSelected {

            setTitle("Remove From Favorites", for: .normal)
            backgroundColor = .systemRed
            setImage(selectImage, for: .normal)

        } else {

            setTitle("Add To Favorites", for: .normal)
            setImage(unSelectImage, for: .selected)
            self.backgroundColor = .systemBlue
        }
    }
    
    
    
    private func setupAction() {
        
        addAction(UIAction(handler: { _ in
        
                self.didTapBlock?()
        }), for: .touchUpInside)
    }
}

