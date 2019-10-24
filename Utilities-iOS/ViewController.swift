//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import IQKeyboardManagerSwift

class ViewController: UIViewController,
    UISearchResultsUpdating,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: TextFieldTransparent!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        setupInputAccesoryButton(textField: textField, action: #selector(hello))
        
        
        setupSearchBar()
        
        getImage()
    }
    
    @objc func keyboard() {}
    @objc func hello() { view.endEditing(true) }
    
    @IBAction func clicked(_ sender: Any) {  performSegue(withIdentifier: "segueID", sender: self) }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as?  SecondViewController {
            vc.name = "helllllooooooo"
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
    func updateSearchResults(for searchController: UISearchController) {}
}
