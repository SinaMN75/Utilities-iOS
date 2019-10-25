//  Created by SinaMN75 on 10/25/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import Foundation
import CoreMotion

// MARK: - Check if device supports step counting sensor.
func isStepCountingAvailable() -> Bool {
    if CMPedometer.isStepCountingAvailable() { return true } else { return false }
}
