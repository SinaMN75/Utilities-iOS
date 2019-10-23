//  Created by SinaMN75 on 10/23/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

class FrontViewController: UIViewController {
    
    @IBOutlet weak var buttonMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonMenu.addTarget(self.revealViewController(),
                             action: #selector(SWRevealViewController.revealToggle(_:)),
                             for: .touchUpInside)
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
                
    }
}
