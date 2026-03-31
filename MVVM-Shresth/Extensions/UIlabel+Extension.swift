//
//  UIlavel_Extension.swift


import Foundation
extension UILabel {
    func underlineLebel(text: String, secondText: String, textColor: UIColor = #colorLiteral(red: 1, green: 0.4059335887, blue: 0, alpha: 1), underlineColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), isUnderline: Bool = false ) {
        let mainString = text
        let stringToColor = secondText
        let range = (mainString as NSString).range(of: stringToColor)
        let attribute = NSMutableAttributedString.init(string: mainString)
        if isUnderline {
            attribute.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            attribute.addAttribute(.underlineColor, value: underlineColor, range: range)
        } else {
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
        }
        self.attributedText = attribute
    }
}
