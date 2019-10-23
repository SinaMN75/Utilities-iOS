//  Created by SinaMN75 on 10/23/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

@IBDesignable
class TextFieldTransparent: UITextField {
    
    private func initial() {
        backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0.2545751284)
        layer.cornerRadius = 10.0
        
        let place = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: UIColor.white])
        
        attributedPlaceholder = place
        textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initial()
    }
    
    override func prepareForInterfaceBuilder() {
        initial()
    }
}
