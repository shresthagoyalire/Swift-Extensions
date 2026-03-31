//
//  UIView+Loading.swift


import Foundation
import MBProgressHUD
//
//
// A UIView extension for hide and show MBProgessHud Loader.
extension UIView {

    /**
     A method to show MBProgessHud loader on view.
     */
    func showLoading() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = AlertMessages.Title.loading
    }

    /**
     A method to hide MBProgessHud loader on view.
     */
    func hideLoading() {
        MBProgressHUD.hide(for: self, animated: true)
    }

    /**
     A method to show MBProgessHud loader from window.
     */
    func showLoadingOnWindow() {
        let hud = MBProgressHUD.showAdded(to: SystemConstant.appDelegate.window!, animated: true)
        hud.label.text = AlertMessages.Title.loading
    }

    /**
     A method to hide MBProgessHud loader from window.
     */
    func hideLoadingFromWindow() {
        MBProgressHUD.hide(for: SystemConstant.appDelegate.window!, animated: true)
    }
}
