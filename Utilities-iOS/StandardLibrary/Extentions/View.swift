//  Created by SinaMN75 on 10/23/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

extension UIView {
    
    // MARK: - Animate a View with it's position and size.
    func animate(x: Double, y: Double,
                 width: Double, height: Double,
                 duration: Double,
                 completion:@escaping  () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            self.frame = CGRect(x: x, y: y, width: width, height: height)
        }) { finished in completion() }
    }
    
    //MARK: - Animate a View with it's opacity.
    func animate(alpha: Double, duration: Double, completion:@escaping  () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = CGFloat(alpha)
        }) { finished in completion() }
    }
}
