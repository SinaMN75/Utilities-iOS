//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import CoreMotion

class ViewController: UIViewController, UISearchResultsUpdating, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pedometer = CMPedometer()
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: TextFieldTransparent!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputAccesoryButton(textField: textField, action: #selector(hello))
        setupSearchBar()
        getImage()
        
        
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { data, e in
                if let data = data {
                    print(data)
                }
            }
        } else {
            print("Step counter is not available")
        }
    }
    
    @objc func keyboard() {}
    @objc func hello() { view.endEditing(true) }
    @IBAction func clicked(_ sender: Any) {  performSegue(withIdentifier: "segueID", sender: self) }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
    func updateSearchResults(for searchController: UISearchController) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as?  SecondViewController { vc.name = "helllllooooooo" }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { imageView.image = image }
        dismiss(animated: true, completion: nil)
    }
}
