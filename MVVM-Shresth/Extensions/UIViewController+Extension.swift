//
//  UIViewController+Extension.swift


import Foundation
extension UIViewController {
    /**
     A method for push navigation.
     
     - parameter viewController: A object of any class.
     - parameter storyBoard: A object of Storyboard.
     */
    func pushTo(_ viewController: AnyClass, storyBoard: UIStoryboard) {
        let viewCont = storyBoard.instantiateViewController(withIdentifier: String.className(viewController))
        self.navigationController?.pushViewController(viewCont, animated: true)
    }

    func presentTo(_ viewController: Any, storyBoard: UIStoryboard) {
        if let type = viewController as? AnyClass {
            let viewCont = storyBoard.instantiateViewController(withIdentifier: String.className(type))
            SystemConstant.appDelegate.window?.topMostController()?.present(viewCont, animated: true, completion: nil)
        } else if let identifier = viewController as? String {
            let rootController = storyBoard.instantiateViewController(withIdentifier: identifier)
            rootController.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(rootController, animated: true, completion: nil)
        }
    }
    func isAlreadyinStack(viewController: UIViewController.Type) -> (status: Bool, controller: UIViewController?) {
        if let controllers = self.navigationController?.viewControllers {
            for controller in controllers {
                if controller.isKind(of: viewController) {
                    debugPrint("It is in stack")
                    return (true, controller)
                    // Your Process
                }
            }
            return (false, nil)
        }
        return (false, nil)
    }

    func presentWithNewNavigation(rootController: UIViewController) {
        let nav1 = UINavigationController(rootViewController: rootController)
        nav1.modalPresentationStyle = .fullScreen
        UIApplication.topViewController()?.present(nav1, animated: true, completion: nil)
    }

    func setDatePickerViewOn(_ sender: UITextField, datePicker: UIDatePicker, actionDone: Selector, actionCancel: Selector, handleDatePicker: Selector) {
        datePicker.calendar = .init(identifier: .gregorian)
        datePicker.datePickerMode = .date
        sender.inputView = datePicker
        sender.inputAccessoryView = Aarong.createToolBar(target: self, done: actionDone, cancel: actionCancel)
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -16, to: Date())
        datePicker.addTarget(self, action: handleDatePicker, for: .valueChanged)
    }
    // MARK: - Create Gender Selection PickerVIew..
    func createPickerView(picker: UIPickerView, txtFld: UITextField, actionDone: Selector, actionCancel: Selector ) {
        txtFld.inputView = picker
        txtFld.inputAccessoryView = Aarong.createToolBar(target: self, done: actionDone, cancel: actionCancel)
    }
}
