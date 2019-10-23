//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: TextFieldTransparent!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupInputAccesoryButton(textField: textField, action: #selector(hello))
        
        
        
        
    }
    
    
    @objc func hello() {
        print("hello")
        view.endEditing(true)
    }
    
    @IBAction func clicked(_ sender: Any) {
        performSegue(withIdentifier: "segueID", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as?  SecondViewController {
            vc.name = "helllllooooooo"
        }
    }
}
