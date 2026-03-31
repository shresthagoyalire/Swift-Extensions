//
//  UITextField+Validations.swift


import UIKit

/// A extension of String class for perform validation of UITextfield text.
extension String {

    /**
     A method to check String is Empty or not.
     
     - returns: Return Bool status of empty check.
     */
    func isEmpty() -> Bool {
        let performedString: NSString = (self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) as NSString
        return performedString.length == 0 ? true : false
    }

    /**
     A method for Email validation.
     
     - returns: Return Bool status of valid email.
     */
    func isValidEmail() -> Bool {
        let emailRegex: NSString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }

    func isValidText() -> Bool {
        let textRegex: NSString = "^[a-zA-Z0-9_ ]*$"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", textRegex)
        return emailTest.evaluate(with: self)
    }
    // Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count)) != nil
        } catch {
            return false
        }
    }
    // Check Datatype
    func checkEmailOrPhone() -> DataType {
        if Int(self) != nil {
            return DataType.number
        } else if isValidEmail() {
            return DataType.email
        } else {
            return DataType.other
        }
    }
    /**
     A method for contact number validation.
     
     - returns: Return Bool status of valid contact number.
     //     */
    //    func isValidContactNo() -> Bool {
    //        let contactRegex: NSString = "^[0-9]{8,15}$"
    //        let contactTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", contactRegex)
    //        return contactTest.evaluate(with: self)
    //    }

    /**
     A method for password validation
     
     - returns: Return Bool status of valid password.
     */
    func isValidPassword() -> Bool {
        // Minimum 8 characters in length with atleast one uppercase one lowercase and one digit// (?=.*?[A-Z])(?=.*?[a-z])
        //        let contactRegex: NSString = "^(?=.*[0-9])(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$"
        let contactRegex: NSString = "^.{6,14}$" // Accept any character with 6,14 length
        let contactTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", contactRegex)
        return (contactTest.evaluate(with: self))
    }

    func isValidPhoneNo() -> Bool {
        if self.count < 6 || self.count > 15 {
            return false
        }
        return true
    }

    func isHtml() -> Bool {
        if self.isEmpty {
                return false
            }
        return (self.range(of: "<(\"[^\"]*\"|'[^']*'|[^'\">])*>", options: .regularExpression) != nil)
//        let validateTest = NSPredicate(format: "SELF MATCHES %@", "<[a-z][\\s\\S]*>")
//        return validateTest.evaluate(with: self)
    }
}
