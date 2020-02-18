//  Created by SinaMN75 on 2/17/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit

@IBDesignable
class ButtonRoundedSolid : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 20 { didSet { update() } }
    @IBInspectable var textColor: UIColor = UIColor.init(hex: COLOR_WHITE) { didSet { update() } }
    @IBInspectable var backgrounndColor: UIColor = UIColor.init(hex: COLOR_PRIMARY) { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() {
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = textColor
        self.layer.backgroundColor = backgroundColor?.cgColor
        self.frame = CGRect(x: 0, y: 0, width: 150, height: 70)
    }
}
