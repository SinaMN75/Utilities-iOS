//  Created by SinaMN75 on 10/23/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

@IBDesignable
class ViewGradient: UIView {
    
    @IBInspectable var startColor: UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor: UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double = 0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation: Double = 0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode: Bool = false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode: Bool = false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    
    func updateLocations() { gradientLayer.locations = [(startLocation / 10) as NSNumber, (endLocation / 10) as NSNumber] }
    func updateColors() { gradientLayer.colors = [startColor.cgColor, endColor.cgColor] }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

@IBDesignable
class ViewBorderRounded : UIView {
    
    @IBInspectable var corner: CGFloat = 10 { didSet { update() } }
    @IBInspectable var backGroundColor: UIColor = .white { didSet { update() } }
    @IBInspectable var borderColor: UIColor = UIColor.init(hex: "000000") { didSet { update() } }
    @IBInspectable var borderWidth: CGFloat = 1 { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() {
        setupCardView(corner: corner, withShadow: false)
        backgroundColor = backGroundColor
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}

@IBDesignable
class ViewCard : UIView {
    override func prepareForInterfaceBuilder() { setup() }
    override func awakeFromNib() { setup() }
    private func setup() { setupCardView() }
}

@IBDesignable
class ViewCardBorder : UIView {
    
    @IBInspectable var corner: CGFloat = 10 { didSet { update() } }
    @IBInspectable var borderColor: UIColor = UIColor.init(hex: "000000") { didSet { update() } }

    override func prepareForInterfaceBuilder() { update() }
    override func awakeFromNib() { update() }
    private func update() {
        setupCardView(corner: corner, withShadow: false)
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 1
    }
}
