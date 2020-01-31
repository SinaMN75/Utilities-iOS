//  Created by SinaMN75 on 9/27/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import Foundation

extension Int {
    
    func asSecond() -> String { return String(format: "%02d", Int(self % 60)) }
    
    func asMinute() -> String { return String(format: "%02d", Int(self / 60)) }
}
