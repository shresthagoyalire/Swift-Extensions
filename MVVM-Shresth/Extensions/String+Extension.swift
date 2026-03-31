//
//  String+Triming.swift


import UIKit

private let badChars = CharacterSet.alphanumerics.inverted

/// A extension of String class with multiiple enhance methods.
extension String {

    /**
     A method to get storyboard identifier of class
     
     - parameter  aClass: A object of any class
     - returns: Return the storyboard identifier of class
     */
    public static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }

    /**
     A method for get string width
     
     - parameter font: The font of string.
     - returns: Retrun the widht of string in CGSize.
     
     */
    func getStringWidth(font: UIFont) -> CGSize {
        return (self as NSString ).size(withAttributes: [NSAttributedString.Key.font: font])
    }

    /// String Height
    /// - Parameters:
    ///   - width: Width
    ///   - font: Font
    func getStringHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    /**
     A method for trim white space and New line in string
     */
    func trimWhiteSpaceAndNewLine() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /**
     Encode  strings in UTF-8 format
     */
    func encode() -> String {
        let variable = self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        return variable
    }

    /**
     Decode strings in UTF-8 format
     
     - parameter str: A string which will to decoded
     */
    func decode(_ str: String) -> String? {
        let val = str.replacingOccurrences(of: "+", with: "%20")
        let decodedString = val.removingPercentEncoding!
        return decodedString
    }

    func appendInURL() -> String {
        if self.hasPrefix("/") {
            return String(self.dropFirst())
        } else {
            return self
        }
    }

    func lineSpaced(_ spacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedString
    }
    func fetchSubstring(breakTill: Character) -> String {
        let index = self.firstIndex(of: breakTill) ?? self.endIndex
        let beginning = self[..<index]
        return String(beginning)
    }

    func convertToDate(dateFormateType: String? = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormateType
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = formatter.date(from: self)
        return localDate
    }

    var htmlToAttributedString: NSAttributedString? {
        do {
            guard let data = data(using: .utf8) else { return nil }
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue]
            // Create NSMutableAttributedString and Fetch the range of whole string...
            let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            let range = NSRange(location: 0, length: attributedString?.length ?? 0)
            // Set the Font size and remove the underline from the string...
            attributedString?.addAttributes([NSAttributedString.Key.font: FontUtility.bookFontWithSize(size: 16.0)], range: range)
            // attributedString?.addAttribute(NSAttributedString.Key.underlineStyle, value: 0, range: range)
            // attributedString?.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], range: range)

            return attributedString

            //            let modifiedFont = String(format: "<span style=\"font-family: \(FontUtility.boldFontWithSize(size: 40.0)); font-size: \(40.0)\">%@</span>", self)
            //            return try NSAttributedString(
            //                data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            //                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            //                documentAttributes: nil)
            //           guard let data = data(using: .utf8) else { return nil }
            //            return try NSAttributedString(data: data, options:
            //                                            [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return nil
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    var uppercasingFirst: String {
        return prefix(1).uppercased() + dropFirst()
    }

    var lowercasingFirst: String {
        return prefix(1).lowercased() + dropFirst()
    }

    var camelized: String {
        guard !isEmpty else {
            return ""
        }

        let parts = self.components(separatedBy: badChars)

        let first = String(describing: parts.first!).lowercasingFirst
        let rest = parts.dropFirst().map({String($0).uppercasingFirst})

        return ([first] + rest).joined(separator: "")
    }
}

extension NSAttributedString {
    var htmlToAttributedDoubleParsing: NSAttributedString? {
        do {
            let htmlData = try self.data(from: .init(location: 0, length: self.length),
                                                   documentAttributes: [.documentType: NSAttributedString.DocumentType.html])
            let htmlString = String(data: htmlData, encoding: .utf8) ?? ""
            print(htmlString)
            if let attributedString = try? NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                return attributedString
            }
        } catch {
            print(error)
            return nil
        }
        return nil
    }
}
