//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

extension String {
    
    // MARK: Replace the first string with the second one.
    func replace(_ target: String, _ withString: String) -> String {
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
    

    
}

extension UITextField {
    
    func trimmedString() -> String {
        return self.text?.trim() ?? ""
    }
    
    func validateInputByLength(length: Int) -> Bool {
        if self.text?.trimmedLength() ?? 0 < length {
            return false
        } else {
            return true
        }
    }
}
