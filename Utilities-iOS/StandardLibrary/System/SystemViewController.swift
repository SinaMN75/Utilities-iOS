//  Created by SinaMN75 on 2/13/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import UIKit

class SystemViewController: UIViewController {

    @IBOutlet weak var sliderBrightness: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sliderBrightness(_ sender: UISlider) { UIScreen.main.brightness = CGFloat(sender.value) }
}
