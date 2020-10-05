//  Created by SinaMN75 on 10/25/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

// MARK: - Alert

func alert(title: String = "", message: String = "", buttonTitle: String = "باشه", handler: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: handler))
    topVC().present(alert, animated: true, completion: nil)
}

func alertTextField(title: String = "", message: String = "", placeHolder: String = "", text: String = "", action: @escaping (String) -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addTextField { (textField) in
        textField.placeholder = placeHolder
        textField.text = text
    }
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
        let textField = alert?.textFields![0]
        action(textField?.text ?? "")
    }))
    
    topVC().present(alert, animated: true, completion: nil)
}

func alertYesNo(title: String = "",
                message: String = "",
                yesTitle: String? = nil,
                yesHandler: ((UIAlertAction) -> Void)? = nil,
                noTitle: String? = nil,
                noHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                cancelTitle: String? = nil,
                cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    if yesHandler != nil { alert.addAction(UIAlertAction(title: yesTitle, style: UIAlertAction.Style.default, handler: yesHandler)) }
    
    if noHandler != nil { alert.addAction(UIAlertAction(title: noTitle, style: UIAlertAction.Style.default, handler: noHandler)) }
    
    if cancelHandler != nil { alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: cancelHandler)) }
    
    topVC().present(alert, animated: true, completion: nil)
}
