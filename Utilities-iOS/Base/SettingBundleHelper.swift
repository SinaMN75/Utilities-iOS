//  Created by SinaMN75 on 2/15/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import Foundation
import UIKit

class SettingBundleHelper {
    
    enum UserDefaultKeys: String {
        case SERVER = "server_url"
    }
    
    class func serverUrl() {
        if UserDefaults.standard.bool(forKey: UserDefaultKeys.SERVER.rawValue) {
            print(UserDefaultKeys.SERVER.rawValue)
            UserDefaults.standard.set(false, forKey: UserDefaultKeys.SERVER.rawValue)
        }
    }
}
