//
//  ViewController.swift
//  Utilities-iOS
//
//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var text = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    
        alertLocation { l in
            print(l.coordinate.latitude)
            print(l.coordinate.longitude)
        }
    }
    


}

