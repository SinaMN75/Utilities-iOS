//  Created by SinaMN75 on 11/15/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

extension UILabel {
    fileprivate func setupLabelWhite(size: CGFloat) {
        font = UIFont.boldSystemFont(ofSize: size)
        textColor = UIColor.white
        textAlignment = .right
    }
    
    fileprivate func setupLabelBlack(size: CGFloat) {
        font = UIFont.boldSystemFont(ofSize: size)
        textColor = UIColor.black
        textAlignment = .right
    }
}

@IBDesignable
class Label30Black : UILabel {
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 30) }
}

@IBDesignable
class Label30White : UILabel {
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelWhite(size: 30) }
}

@IBDesignable
class Label20Black : UILabel {
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 20) }
}

@IBDesignable
class Label20White : UILabel {
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelWhite(size: 20) }
}

@IBDesignable
class Label15Black : UILabel {
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 15) }
}

@IBDesignable
class Label15White : UILabel {
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelWhite(size: 15) }
}

@IBDesignable
class Label10Black : UILabel {
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 10) }
}

@IBDesignable
class Label9White : UILabel {
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelWhite(size: 10) }
}

@IBDesignable
class LabelRoundedBackground : UILabel {
    
    @IBInspectable var cornerRadius: CGFloat = 10 { didSet { update() } }
    @IBInspectable var textcolor: UIColor = UIColor.init(hex: COLOR_WHITE) { didSet { update() } }
    @IBInspectable var backgroundcolor: UIColor = UIColor.init(hex: COLOR_PRIMARY) { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() {
        textColor = textcolor
        layer.cornerRadius = cornerRadius
        backgroundColor = backgroundcolor
        clipsToBounds = true
    }
}

