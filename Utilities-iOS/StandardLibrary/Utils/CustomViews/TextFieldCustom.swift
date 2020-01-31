//  Created by SinaMN75 on 10/23/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

@IBDesignable
class TextFieldTransparent: UITextField {
    override func awakeFromNib() { setup() }
    override func prepareForInterfaceBuilder() { setup() }
    private func setup() {
        backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0.2545751284)
        layer.cornerRadius = 10.0
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: UIColor.white])
        textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

@IBDesignable
class TextFieldCard : UITextField {
    override func prepareForInterfaceBuilder() { setup() }
    override func awakeFromNib() { setup() }
    private func setup() { setupCardView() }
}
