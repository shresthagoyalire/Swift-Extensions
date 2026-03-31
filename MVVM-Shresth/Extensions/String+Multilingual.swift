//
//  String+Multilingual.swift

import Foundation

extension String {

    /**
     A method for the localized string
     - returns: Return the localized string.
     */
    func localized() -> String {
        if let lang = UserDefaults.standard.getlanguage() {
            let code = lang

            if let mainP = Bundle.main.path(forResource: code, ofType: "lproj"), let bundle = Bundle(path: mainP) {
                return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            }
        }
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

}
