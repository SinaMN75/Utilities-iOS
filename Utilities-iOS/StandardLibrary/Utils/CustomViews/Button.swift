//  Created by SinaMN75 on 2/17/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit

@IBDesignable
class ButtonRoundedSolid : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 20 { didSet { update() } }
    @IBInspectable var textColor: UIColor = UC_WHITE { didSet { update() } }
    @IBInspectable var backgroundcolor: UIColor = UC_PRIMARY { didSet { update() } }
    @IBInspectable var borderwidth: CGFloat = 1 { didSet { update() } }
    @IBInspectable var bordercolor: UIColor = UC_PRIMARY { didSet { update() } }
    
    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() {
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(textColor, for: .normal)
        self.layer.backgroundColor = backgroundcolor.cgColor
        self.layer.borderWidth = borderwidth
        self.layer.borderColor = bordercolor.cgColor
    }
}

@IBDesignable
class ButtonText : UIButton {
    
    @IBInspectable var textColor: UIColor = UC_WHITE { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() {
        self.setTitleColor(textColor, for: .normal)
        
        let yourAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),
                                                             .foregroundColor: UIColor.blue,
                                                             .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "", attributes: yourAttributes)
        self.setAttributedTitle(attributeString, for: .normal)
    }
}

