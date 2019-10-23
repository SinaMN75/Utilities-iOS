//  Created by SinaMN75 on 9/27/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import Foundation

extension Int {
    
    func asSecond() -> String {
        let time = String(format: "%02d", Int(self % 60))
        return time
    }
    
    func asMinute() -> String {
        let time = String(format: "%02d", Int(self / 60))
        return time
    }
}
