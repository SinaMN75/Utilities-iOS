//  Created by SinaMN75 on 11/15/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

extension UILabel {
    fileprivate func setupLabelWhite(size: CGFloat, textColor: UIColor) {
        font = UIFont.boldSystemFont(ofSize: size)
        self.textColor = textColor
    }
    
    fileprivate func setupLabelBlack(size: CGFloat, textColor: UIColor) {
        font = UIFont.boldSystemFont(ofSize: size)
        self.textColor = textColor
    }
    
    func addBadge() {
        let size: CGSize = "".size(withAttributes: [.font: UIFont.systemFont(ofSize: 20)])
        let point = CGPoint(x: size.width - 10, y: 0)

        let circle = CAShapeLayer()
        let path = UIBezierPath(arcCenter: CGPoint(x: point.x, y: 10), radius: 5, startAngle: 0, endAngle: .pi*2, clockwise: true)
        circle.path = path.cgPath
        circle.fillColor = UIColor.red.cgColor
        self.layer.addSublayer(circle)
    }
}

@IBDesignable
class Label30Black : UILabel {
    @IBInspectable var textcolor: UIColor = UC_TEXT { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 30, textColor: textcolor) }
}

@IBDesignable
class Label30White : UILabel {
    @IBInspectable var textcolor: UIColor = UC_WHITE { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 30, textColor: textcolor) }
}

@IBDesignable
class Label20Black : UILabel {
    @IBInspectable var textcolor: UIColor = UC_TEXT { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 20, textColor: textcolor) }
}

@IBDesignable
class Label20White : UILabel {
    @IBInspectable var textcolor: UIColor = UC_WHITE { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 20, textColor: textcolor) }
}

@IBDesignable
class Label15Black : UILabel {
    @IBInspectable var textcolor: UIColor = UC_TEXT { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 15, textColor: textcolor) }
}

@IBDesignable
class Label15White : UILabel {
    @IBInspectable var textcolor: UIColor = UC_WHITE { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 15, textColor: textcolor) }
}

@IBDesignable
class Label10Black : UILabel {
    @IBInspectable var textcolor: UIColor = UC_TEXT { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 10, textColor: textcolor) }
}

@IBDesignable
class Label10White : UILabel {
    @IBInspectable var textcolor: UIColor = UC_WHITE { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() { setupLabelBlack(size: 10, textColor: textcolor) }
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

