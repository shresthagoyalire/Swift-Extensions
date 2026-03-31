//
//  UIAlertController+Extension.swift


import UIKit

/// A extension of UIAlertController for show Success/error/Information Alerts.
extension UIAlertController {

    /**
     A method of Success Alert.
     - parameter message: A string of success message.
     */
    func successAlertWith(message: String) {
        present(alertTitle: AlertMessages.Title.success, alertMessage: message)
    }

    /**
     A method of Error Alert.
     - parameter message: A string of error message.
     */
    func errorAlertWith(message: String) {
        present(alertTitle: AlertMessages.Title.error, alertMessage: message, buttonStyle: .destructive)
    }

    /**
     A method of Information Alert.
     
     - parameter message: A string of information message.
     */
    func informationAlertWith(message: String) {
        present(alertTitle: AlertMessages.Title.alert, alertMessage: message, buttonStyle: .destructive)
    }

    /**
     A private method for creation of UIAlertContoller and alert's Action.
     
     - parameter alertTitle: A string of UIalertController's Title.
     - parameter alertMessage: A string of Success/error/Information message.
     - parameter buttonStyle: A parameter for UIAlertAction's style.
     */
    private func present(alertTitle: String, alertMessage: String, buttonStyle: UIAlertAction.Style = .default) {
        let alert = UIAlertController.init(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: AlertMessages.Title.okay, style: buttonStyle, handler: nil))
        SystemConstant.appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
