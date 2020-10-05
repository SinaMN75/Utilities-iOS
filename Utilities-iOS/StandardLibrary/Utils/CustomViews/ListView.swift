//  Created by SinaMN75 on 8/13/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit

@IBDesignable
class TableView : UITableView {
    
    @IBInspectable var backgrounndColor: UIColor = UIColor.init(hex: COLOR_PRIMARY) { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() {
        separatorInset = .zero
        allowsSelection = false
    }
}

