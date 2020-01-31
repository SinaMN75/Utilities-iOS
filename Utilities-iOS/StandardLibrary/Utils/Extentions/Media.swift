//  Created by SinaMN75 on 9/27/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        if (self.rate != 0 && self.error == nil) { return true }
        else { return false }
    }
}
