//
//  UIView+Extension.swift


import UIKit

extension UIView {
    func addshadow(top: Bool,
                   left: Bool,
                   bottom: Bool,
                   right: Bool,
                   shadowRadius: CGFloat = 2.0) {

        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1.0

        let path = UIBezierPath()
        var xValue: CGFloat = 0
        var yValue: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height

        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if !top {
            yValue+=(shadowRadius+1)
        }
        if !bottom {
            viewHeight-=(shadowRadius+1)
        }
        if !left {
            xValue+=(shadowRadius+1)
        }
        if !right {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: xValue, y: yValue))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: xValue, y: viewHeight))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: yValue))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
    }

    func setShadowWith(color: UIColor = UIColor.black, shadowOpacity: Float = 0.2, radius: Float = 1.0, shadowOffSet: CGSize = CGSize(width: 0, height: 1)) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffSet
        self.layer.shadowRadius = CGFloat(radius)
    }

    func setBorderColorAndCornerWith(radius: CGFloat? = 0.0, color: UIColor? = .clear, width: CGFloat? = 0.0) {
        self.layer.borderColor = color!.cgColor
        self.layer.borderWidth = width!
        self.layer.cornerRadius = radius!
    }

    func roundCornersWith(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func showNoDataAvailable(noDataText: String, noDataTextColor: UIColor) -> UIView {

        let noDataAvailableView = UIView()
        noDataAvailableView.frame = self.frame
        noDataAvailableView.backgroundColor = .clear

        let lbl = UILabel(frame: CGRect(x: CGFloat(10), y: CGFloat(self.frame.size.height/2 - 40), width: CGFloat(noDataAvailableView.frame.size.width - 20), height: CGFloat(80)))
        lbl.textColor = noDataTextColor
        lbl.numberOfLines = 3
        lbl.text = noDataText
        lbl.textAlignment = .center
        lbl.font = FontUtility.lightFontWithSize(size: 18)

        noDataAvailableView.addSubview(lbl)

        return noDataAvailableView
    }
    func createRoundView() {
        DispatchQueue.main.async {
            self.layer.cornerRadius = (self.layer.frame.size.height) / 2.0
            self.layer.masksToBounds = true
        }
    }
    func addBounceAnimation() {
        self.alpha = 0
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 1.0
        })
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [0.01, 1.1, 1.0]
        bounceAnimation.keyTimes = [0.0, 0.5, 1.0]
        bounceAnimation.duration = 0.4
        self.layer.add(bounceAnimation, forKey: "bounce")
    }

    func removeSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }

    func addSubViewWithConstraints(subview: UIView) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        self.bringSubviewToFront(subview)
    }
}

@IBDesignable extension UIView {

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue / MainScreen.scale
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
    }
}
