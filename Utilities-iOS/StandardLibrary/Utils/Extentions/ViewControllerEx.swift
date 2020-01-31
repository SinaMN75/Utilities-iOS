//  Created by SinaMN75 on 10/23/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit

extension UIViewController {
    
    // MARK: - Adds a button on top of the keyboard for a certain UITextField.
    /**
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
    
    //MARK: - image from camera.
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
    
    //MARK: - image from photo library.
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
    
    // MARK: - NAVIGATION CONTROLLER
    
    func transparentNavigationBar(withShadow: Bool) {
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if !withShadow { navigationController?.navigationBar.shadowImage = UIImage() }
    }
    
    func navigationBarImageTitle(image: String) {
        let image = UIImageView(image: UIImage(named: image))
        image.sizeToFit()
        navigationItem.titleView = image
    }
    
    func navigationBarTextTitle(title: String) {
        let label = UILabel()
        label.text = title
        label.sizeToFit()
        navigationItem.titleView = label
    }
    
    func backBarButton(title: String) { navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil) }
    
    func backBarButtonIndicator(image: String, withText: Bool = false) {
        navigationController?.navigationBar.backIndicatorImage = makeImage(image)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = makeImage(image)
        if !withText { backBarButton(title: "") }
    }
    
    func leftBarButtonItem(image: String, action: Selector) {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: image)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: action, for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func rightBarButtonItem(image: String, action: Selector) {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: image)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: action, for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func rightBarButtonItems(image1: String, image2: String, action1: Selector, action2: Selector) {
        let button1 = self.makeImageButton(image: image1, action: action1)
        let button2 = self.makeImageButton(image: image1, action: action2)
        button1.addTarget(self, action: action1, for: .touchUpInside)
        button2.addTarget(self, action: action2, for: .touchUpInside)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button1), UIBarButtonItem(customView: button2)]
    }
    
    func leftBarButtonItems(image1: String, image2: String, action1: Selector, action2: Selector) {
        let button1 = self.makeImageButton(image: image1, action: action1)
        let button2 = self.makeImageButton(image: image1, action: action2)
        button1.addTarget(self, action: action1, for: .touchUpInside)
        button2.addTarget(self, action: action2, for: .touchUpInside)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: button1), UIBarButtonItem(customView: button2)]
    }

    func createVC(storyBoard:String,viewControllerID:String) -> UIViewController {
        return UIStoryboard(name: storyBoard, bundle: nil).instantiateViewController(withIdentifier: viewControllerID)
    }

    func presentVC(storyboard: String, viewControllerId: String) {
        self.present(createVC(storyBoard: storyboard, viewControllerID: viewControllerId), animated: true, completion: nil)
    }
    
    func dismiss(animated: Bool = true) { self.dismiss(animated: animated, completion: nil) }
    
    func makeImageButton(image: String, action: Selector) -> UIButton{
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: image)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

func topVC() -> UIViewController {
    if var topController:UIViewController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    return UIViewController()
}
