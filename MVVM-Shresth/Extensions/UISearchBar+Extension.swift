//
//  UisearchBar+Extension.swift


import UIKit
import Foundation

extension UISearchBar {
    func customizedSearchBar(width: CGFloat) {
        self.setBackgroundImage(UIImage(), for: .any, barMetrics: UIBarMetrics.default)
        let subViews = self.subviews.flatMap { $0.subviews }
        let txtFld = (subViews.filter { $0 is UITextField }).first as? UITextField
        if txtFld == nil {
            self.setBackgroundImage(UIImage(), for: .any, barMetrics: UIBarMetrics.default)
            for subview in self.subviews {
                print("Subview: - \(subview)")
                for view in subview.subviews {
                    print(view)
                    for subV in view.subviews {
                        if let textField = subV as? UITextField {
                            let hgt: CGFloat = Device.isPad ? 40.0 : 25.0
                            self.setImage(UIImage(), for: .search, state: .normal)
                            self.placeholder = ScreenConstant.Search.search
                            textField.frame = CGRect(x: 0, y: 0, width: width, height: hgt)
                            textField.clipsToBounds = true
                            textField.backgroundColor = .white
                        }
                    }
                }
            }
        }
    }
    public var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            let subViews = subviews.flatMap { $0.subviews }
            guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
                return nil
            }
            textField.backgroundColor = .white
            return textField
        }
    }
    public var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap {$0 as? UIActivityIndicatorView }.first
    }

    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(style: .gray)
                    newActivityIndicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    newActivityIndicator.startAnimating()
                    newActivityIndicator.backgroundColor = UIColor.gray
                    textField?.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize.zero
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}
