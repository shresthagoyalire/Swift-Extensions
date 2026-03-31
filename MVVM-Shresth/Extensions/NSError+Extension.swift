//
//  NSError+Extension.swift

import UIKit

extension NSError {

    /**
     A method to generate NSError.
     
     - parameter message: A string of error message ("Something went wrong" is default).
     - parameter code: A HTTPs status code ("0" is default).
     - parameter errInfo: Contain error infomation in key pair format(An empty Dict).
     - returns: Resturn a NSError Object.
     */
    func generateError(message: String = AlertMessages.Error.somethingWrong, statusCode: Int = 0, errorInfo: [String: Any]? = [:]) -> NSError {

        let error = NSError.init(domain: message, code: statusCode, userInfo: errorInfo)
        return error
    }

    /// This method return errorCode in string
    func getErrorCode() -> String {
      if let firstObject = (self.userInfo["fieldErrors"] as? [[AnyHashable: AnyObject]])?.first, let firstMessage = firstObject["error_code"] as? String {
        return firstMessage
      } else if let message = self.userInfo["error_code"] as? String {
        return message
      } else {
        return (self.localizedDescription)
      }
    }
}
