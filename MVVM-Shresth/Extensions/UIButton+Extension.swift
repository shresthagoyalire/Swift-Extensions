//
//  UIButton+Extension.swift


import Foundation

extension UIButton {
    func underline(font: UIFont = FontUtility.bookFontWithSize(size: 17.0)) {
        guard let text = self.titleLabel?.text, let color = self.titleColor(for: .normal) else { return }
     /*   let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
       */
        let attrs = [
        NSAttributedString.Key.underlineColor: color,
        NSAttributedString.Key.foregroundColor: color,
        NSAttributedString.Key.font: font,
        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key: Any]
        let attributedString = NSMutableAttributedString(string: "")
        let buttonTitleStr = NSMutableAttributedString(string: text, attributes: attrs)
        attributedString.append(buttonTitleStr)
        self.setAttributedTitle(attributedString, for: .normal)
    }

    func getSelectedCellOnClick(collView: UICollectionView) -> (cell: UICollectionViewCell?, indexPath: IndexPath?) {
        let buttonPosition: CGPoint = self.convert(CGPoint.zero, to: collView)
        guard let indexPath = collView.indexPathForItem(at: buttonPosition) else {return (UICollectionViewCell(), nil)}
        guard let type = collView.cellForItem(at: indexPath) else {return (UICollectionViewCell(), nil)}
        return (type, indexPath)
    }

    func getSelectedTblCellOnClick(tblView: UITableView) -> (cell: UITableViewCell?, indexPath: IndexPath?) {
        let buttonPosition: CGPoint = self.convert(CGPoint.zero, to: tblView)
        guard let indexPath = tblView.indexPathForRow(at: buttonPosition) else {return (UITableViewCell(), nil)}
        guard let type = tblView.cellForRow(at: indexPath) else {return (UITableViewCell(), nil)}
        return (type, indexPath)
    }
}
