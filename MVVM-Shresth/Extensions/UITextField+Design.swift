//
//  UITextField+Design.swift


import UIKit

extension UITextField {
    func addLeftView(imageIcon: UIImage!) {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.size.height))
        view.backgroundColor = UIColor.clear
        let height: CGFloat = 24.0
        let imageView = UIImageView(frame: CGRect(x: 0, y: (view.frame.size.height - height) / 2, width: view.frame.size.width - 5, height: height))
        imageView.image = imageIcon
        imageView.contentMode = .center
        view.addSubview(imageView)

        self.leftView = view
        self.leftViewMode = .always
    }

    func addRightView(viewController: AnyObject = BaseViewController.self, imageIcon: UIImage!, isButtonApply: Bool = false, tag: Int? = 0, action: Selector = #selector(defaultFunction)) {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.size.height))
        view.backgroundColor = UIColor.clear
        let height: CGFloat = 24.0
        let imageView = UIImageView(frame: CGRect(x: 0, y: (view.frame.size.height - height) / 2, width: view.frame.size.width, height: height))
        imageView.image = imageIcon
        imageView.contentMode = .center
        let button = UIButton(frame: CGRect(x: 0, y: (view.frame.size.height - height) / 2, width: view.frame.size.width, height: height))
        button.setImage(imageIcon, for: .normal)
        button.tag = tag ?? 0
        button.addTarget(viewController, action: action, for: .touchUpInside)
        isButtonApply ? view.addSubview(button) : view.addSubview(imageView)
        self.rightView = view
        self.rightViewMode = .always
    }
    @objc func defaultFunction() {}
    func addTextFieldColorTitle(color: UIColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), title: String) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        self.leftViewMode = .always
        self.leftView = paddingView
        self.attributedPlaceholder = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    func addLeftPadding(isShow: Bool) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: isShow ? 15 : 0, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
