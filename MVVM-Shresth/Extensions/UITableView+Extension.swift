//
//  UITableView+Extension.swift


import Foundation

// MARK: - Protocol Generic Type

protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension ReusableCell {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

// protocol NibReusableCell: ReusableCell {
//    static var nib: UINib? { get }
// }
// extension NibReusableCell {
//    static var nib: UINib? {
//        return UINib(nibName: String(describing: self), bundle: nil)
//    }
// }

// MARK: - Table View Generic Type

extension UITableViewCell: ReusableCell {}
extension UITableViewHeaderFooterView: ReusableCell {}

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            debugPrint(T.reuseIdentifier)
            fatalError("Unable to Dequeue Reusable Table View Cell ")
        }
        return cell
    }

    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T
    }

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = Colors.Text.Grey
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = FontUtility.demiFontWithSize(size: 17)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }

    func updateTableView(withAnimation: Bool) {
        if withAnimation {
            self.beginUpdates()
            self.endUpdates()
        } else {
            UIView.performWithoutAnimation { [weak self] in
                self?.beginUpdates()
                self?.endUpdates()
            }
        }
    }
}

// MARK: - Collection View Generic Type
extension UICollectionViewCell: ReusableCell {}

extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }

    func registerReusableSupplementaryView<T: ReusableCell>(elementKind: String, _: T.Type) {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(elementKind: String, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
}
