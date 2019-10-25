//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

extension String {
    
    // MARK: Replace the first string with the second one.
    func replace(from target: String, to withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
    
    //MARK: Gets length of the Trimmed the String.
    func trimmedLength() -> Int {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count
    }
    
    //MARK: Trims the String.
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func timeAgoFromNow() -> String {
        if self != "" {
            var targetDateString: String = self
            if targetDateString.count == 10 {
                targetDateString += " 00:00:00"
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyy-MM-dd HH:mm:ss"
            
            let targetDate = formatter.date(from: targetDateString)!
            let dateNow = Date()
            
            let dateComponentsFormatter = DateComponentsFormatter()
            dateComponentsFormatter.unitsStyle = .short
            dateComponentsFormatter.allowedUnits = [.year,.month,.day,.hour]
            dateComponentsFormatter.calendar?.locale = Locale(identifier: "fa")
            
            let interval = dateNow.timeIntervalSince(targetDate)
            return dateComponentsFormatter.string(from: interval)!.components(separatedBy: "،")[0] + " پیش "
            
        }
        return ""
    }
    
    func asMoney() -> String {
        var mainPrice = self
        var floatPrice = ""
        var suffix = ""
        switch self.count{
        case 0...3:
            floatPrice = "0"
        case 4...6:
            suffix = "هزار"
            floatPrice = mainPrice[mainPrice.count - 3]
            let endIndex = mainPrice.index(mainPrice.endIndex, offsetBy: -3)
            mainPrice = mainPrice.substring(to: endIndex)
        case 7...9:
            suffix = "میلیون"
            floatPrice = mainPrice[mainPrice.count - 6]
            let endIndex = mainPrice.index(mainPrice.endIndex, offsetBy: -6)
            mainPrice = mainPrice.substring(to: endIndex)
        case 10...12:
            suffix = "میلیارد"
            floatPrice = mainPrice[mainPrice.count - 9]
            let endIndex = mainPrice.index(mainPrice.endIndex, offsetBy: -9)
            mainPrice = mainPrice.substring(to: endIndex)
        default:
            break
        }
        if floatPrice == "0" { return mainPrice + " " + suffix }
        return mainPrice + "/" + floatPrice + " " + suffix
    }
    
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
