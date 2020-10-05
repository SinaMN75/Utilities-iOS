//  Created by SinaMN75 on 10/23/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

@available(iOS 13.0, *)
let keyWindow = UIApplication.shared.connectedScenes
    .filter({$0.activationState == .foregroundActive})
    .map({$0 as? UIWindowScene})
    .compactMap({$0})
    .first?.windows
    .filter({$0.isKeyWindow}).first

extension UIView {
    
    func animate(x: Double, y: Double, width: Double, height: Double, duration: Double, completion:@escaping  () -> Void) {
        UIView.animate(withDuration: duration, animations: { self.frame = CGRect(x: x, y: y, width: width, height: height) }) { finished in completion() }
    }
    
    func animate(alpha: Double, duration: Double, completion:@escaping  () -> Void) {
        UIView.animate(withDuration: duration, animations: { self.alpha = CGFloat(alpha) }) { finished in completion() }
    }
    
    func roundCorners(_ corners: CACornerMask,
                      radius: CGFloat,
                      borderColor: UIColor = .white,
                      borderWidth: CGFloat = 0) {
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
    }
    
    func setupCardView(corner: CGFloat = 20, shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0), shadowOpacity: Float = 0.7) {
        layer.cornerRadius = corner
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = 12.0
        layer.shadowOpacity = shadowOpacity
    }
    
    func invisible() { self.isHidden = true }
    
    func visible() { self.isHidden = false }
}

func imageButton(image: String, action: Selector) -> UIButton {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: image)?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.sizeToFit()
    button.addTarget(topVC(), action: action, for: .touchUpInside)
    return button
}

func imageView(image: String, withShadow: Bool = false) -> UIImageView {
    let imageView = UIImageView(image: UIImage(named: image))
    imageView.sizeToFit()
    if withShadow { imageView.setupCardView() }
    return imageView
}

func label(text: String, textColor: UIColor = .black) -> UILabel {
    let label = UILabel()
    label.sizeToFit()
    label.text = text
    label.textColor = textColor
    return label
}

