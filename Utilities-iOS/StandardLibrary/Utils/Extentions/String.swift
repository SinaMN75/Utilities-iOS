//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

extension String {
    
    // MARK: Replace the first string with the second one.
    func replace(from target: String, to withString: String) -> String { return self.replacingOccurrences(of: target, with: withString) }
    
    //MARK: Gets length of the Trimmed the String.
    func trimmedLength() -> Int { return self.trimmingCharacters(in: .whitespacesAndNewlines).count }
    
    //MARK: Trims the String.
    func trim() -> String { return self.trimmingCharacters(in: .whitespacesAndNewlines) }
    
    func timeAgoFromNow() -> String {
        if self != "" {
            var targetDateString: String = self
            if targetDateString.count == 10 { targetDateString += " 00:00:00" }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyy-MM-dd HH:mm:ss"
            let dateComponentsFormatter = DateComponentsFormatter()
            dateComponentsFormatter.unitsStyle = .short
            dateComponentsFormatter.allowedUnits = [.year,.month,.day,.hour]
            dateComponentsFormatter.calendar?.locale = Locale(identifier: "fa")
            let interval = Date().timeIntervalSince(formatter.date(from: targetDateString)!)
            return dateComponentsFormatter.string(from: interval)!.components(separatedBy: "،")[0] + " پیش "
        }
        return ""
    }
    
    func shortPrice() -> String{
        var mainPrice = self
        var floatPrice = ""
        var suffix = ""
        switch self.count{
        case 0...3:
            floatPrice = "0"
        case 4...6:
            suffix = "هزار تومان"
            floatPrice = mainPrice[mainPrice.count - 3]
            mainPrice = String(mainPrice[..<mainPrice.index(mainPrice.endIndex, offsetBy: -3)])
        case 7...9:
            suffix = "میلیون تومان"
            floatPrice = mainPrice[mainPrice.count - 6]
            mainPrice = String(mainPrice[..<mainPrice.index(mainPrice.endIndex, offsetBy: -6)])
        case 10...12:
            suffix = "میلیارد تومان"
            floatPrice = mainPrice[mainPrice.count - 9]
            mainPrice = String(mainPrice[..<mainPrice.index(mainPrice.endIndex, offsetBy: -9)])
        default:
            break
        }
        if floatPrice == "0" { return mainPrice + " " + suffix }
        return mainPrice + "/" + floatPrice + " " + suffix
    }
    
    func persianNumberToEnglish() -> String{
        var string = self
        let formatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "fa") as Locale
        for i in 0..<10 {
            let num : NSNumber = i as NSNumber
            string = string.replacingOccurrences(of: formatter.string(from: num)!, with: "\(num)")
        }
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale
        for i in 0..<10 {
            let num: NSNumber = i as NSNumber
            string = string.replacingOccurrences(of: formatter.string(from: num)! , with: "\(num)")
        }
        return string
    }
    
    var currency: String {
        let stringWithoutSymbol = self.replacingOccurrences(of: "", with: "")
        let stringWithoutComma = stringWithoutSymbol.replacingOccurrences(of: ",", with: "")
        let styler = NumberFormatter()
        styler.minimumFractionDigits = 0
        styler.maximumFractionDigits = 0
        styler.currencySymbol = ""
        styler.numberStyle = .currency
        if let result = NumberFormatter().number(from: stringWithoutComma) { return styler.string(from: result)! }
        return self
    }
    
    func toURL() -> URL { return URL.init(string: self)! }
    
    subscript (i: Int) -> Character { return self[index(startIndex, offsetBy: i)] }
    
    subscript (i: Int) -> String { return String(self[i] as Character) }
}

extension UITextField {
    
    // MARK: - Returns trimmed string from UITextField.
    func trimmedString() -> String { return self.text?.trim() ?? "" }
    
    // MARK: - Validates the text inside of the UITextField with it's length.
    func validateInputByLength(length: Int) -> Bool {
        if self.text?.trimmedLength() ?? 0 < length { return false }
        else { return true }
    }
}
