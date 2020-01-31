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
        UIView.animate(withDuration: duration, animations: { self.alpha = CGFloat(alpha) }) { finished in completion() }
    }
    
    func setupCardView(corner: CGFloat = 20, withShadow: Bool = true) {
        layer.cornerRadius = corner
        if withShadow {
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            layer.shadowRadius = 12.0
            layer.shadowOpacity = 0.7
        }
    }
}

func makeImageButton(vc: UIViewController, image: String, action: Selector) -> UIButton{
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: image)?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.sizeToFit()
    button.addTarget(vc, action: action, for: .touchUpInside)
    return button
}
