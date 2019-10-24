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
    
    // MARK: - implements a search bar in the navigation bar.
    /**
     Must implement UISearchResultsUpdating in the used ViewController.
     */
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
    
    //MARK: - Can get image from camera.
    /**
     Must hold Privacy - Camera Usage Description in the info.plist file and camera selected in the Hardened Runtime.
     Also must implement UIImagePickerControllerDelegate and UINavigationControllerDelegate in used ViewController.
     
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { }
     dismiss(animated: true, completion: nil)
     }
     */
    func captureImage() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        }
    }
    
    //MARK: - Can get image from photo library.
    /**
     Must hold Privacy - Photo Library Usage Description in the info.plist file.
     Also must implement UIImagePickerControllerDelegate and UINavigationControllerDelegate in used ViewController.
     
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { }
     dismiss(animated: true, completion: nil)
     }
     */
    func getImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            
        }
    }
}
