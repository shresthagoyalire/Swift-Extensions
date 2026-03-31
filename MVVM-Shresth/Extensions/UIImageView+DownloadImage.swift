//
//  UIImageView+DownloadImage.swift


/*https://github.com/Alamofire/AlamofireImage*/

import UIKit
import Kingfisher // or AlamofireImage

/// A extension of UIImage for Download and resize image.
extension UIImageView {

    /**
     A method to download image.
     
     - parameter imageURL: A URL string for Image.
     - parameter placeholderImage: A UIImage for placeholder.
     */
    func downloadImage(imageURL: String?, placeholderImage: UIImage? = nil, contentMode: UIView.ContentMode = .scaleAspectFit) {
        let appendBaseUrl = !(imageURL?.contains("http") ?? false)
        if appendBaseUrl, let imageurl = imageURL, imageurl != "", let url = URL(string: API.baseURL + imageurl) {
            debugPrint("image url is:->", url)
            self.setImageAfterDownload(url: url, placeholderImage: placeholderImage, contentMode: contentMode)
        } else if !appendBaseUrl, let imageurl = imageURL, imageurl != "", let url = URL(string: imageurl) {
            self.setImageAfterDownload(url: url, placeholderImage: placeholderImage, contentMode: contentMode)
            debugPrint("image url is:->", url)
        } else {
            self.image = placeholderImage
        }
    }

    // Private function to call download and set image
    private func setImageAfterDownload(url: URL, placeholderImage: UIImage? = nil, contentMode: UIView.ContentMode) {
        debugPrint("image url is:->", url)
        self.af.setImage(withURL: url, placeholderImage: placeholderImage, completion: { (imageResult) in
            switch imageResult.result {
            case .success(let img):
                // self.image = img.resizeImageWith(newSize: self.frame.size)
                self.image = img
                self.contentMode = contentMode
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
    }

    /// Rotate Image View
    /// - Parameter angle: Degree
    func rotateImage(angle: CGFloat?) {
        UIView.animate(withDuration: 0.35, animations: { [weak self] in
            self?.transform = (angle != nil) ? CGAffineTransform(rotationAngle: angle!) : CGAffineTransform.identity
        })
    }

}
extension UIImage {
    /**
     A method to resize image.
     - parameter newSize: A new value of CGSize .
     - returns: A resized UIImage.
     */

    func resizeImageWith(newSize: CGSize) -> UIImage {

        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height

        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
