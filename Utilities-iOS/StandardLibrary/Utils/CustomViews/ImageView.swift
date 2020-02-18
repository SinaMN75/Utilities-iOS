//  Created by SinaMN75 on 2/17/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit

@IBDesignable
class ImageViewCircle : UIImageView {
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() {
        layer.cornerRadius = frame.width
        clipsToBounds = true
        layer.masksToBounds = true
    }
}
