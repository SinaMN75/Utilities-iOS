//  Created by SinaMN75 on 10/25/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

// MARK: - Alert

func alert(_ vc: UIViewController,
               title: String,
               message: String,
               buttonTitle: String,
               handler: ((UIAlertAction) -> Void)? = nil) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: handler))
    vc.present(alert, animated: true, completion: nil)
}

func alertYesNo(vc: UIViewController,
                    title: String,
                    message: String,
                    YesTitle: String,
                    YesHandler: ((UIAlertAction) -> Void)? = nil,
                    NoTitle: String,
                    NoHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                    cancelTitle: String,
                    cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    if YesHandler != nil{
        alert.addAction(UIAlertAction(title:YesTitle,
                                      style: UIAlertAction.Style.default,
                                      handler: YesHandler))
    }
    if NoHandler != nil{
        alert.addAction(UIAlertAction(title: NoTitle,
                                      style: UIAlertAction.Style.default,
                                      handler: NoHandler))
    }
    if cancelHandler != nil{
        alert.addAction(UIAlertAction(title: cancelTitle,
                                      style: UIAlertAction.Style.cancel,
                                      handler: cancelHandler))
    }
    vc.present(alert, animated: true, completion: nil)
}
