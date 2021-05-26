import UIKit
import SDWebImage

extension UIImageView {
    
    func setImage(withURL string: String?) {
        
        let placeholderImage = UIImage(systemName: "photo.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        if let str = string {
            
            let url = URL(string: str)
            self.sd_setImage(with: url,
                                   placeholderImage: placeholderImage,
                                   options: .continueInBackground,
                                   context: nil)
        } else {
            
            self.image = placeholderImage
        }
    }
}
