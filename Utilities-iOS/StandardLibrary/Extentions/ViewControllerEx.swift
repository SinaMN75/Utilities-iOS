//  Created by SinaMN75 on 10/23/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

extension UIViewController {
    
    /**
     This function will create a button and show it when user focused on the given TextField.
     need to call  [ view.endEditing(true) ] at the end of action selector to close the keyboard.
     */
    func setupInputAccesoryButton(textField: UITextField,
                                  title: String = "OK",
                                  backgroundColor: UIColor = .systemBlue,
                                  titleColor: UIColor = .white,
                                  action: Selector) {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        textField.inputAccessoryView = button
    }
}
