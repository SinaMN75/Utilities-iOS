//  Created by SinaMN75 on 8/10/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import CoreLocation

func alertNormal(title: String = "Title", message: String = "Message", buttonTitle: String = "OK", action: @escaping () -> Void?) {
    let alert = UIAlertController(style: .alert, title: title, message: message)
    alert.addAction(title: buttonTitle, color: .blue, style: .default) { a in action() }

    alert.show(animated: true, vibrate: false)
}

func alertTextField(title: String = "", textColor: UIColor = .black, buttonText: String = "", placeHolder: String = "", action: @escaping (String) -> Void) {
    let alert = UIAlertController(style: .alert, title: title)
    let config: TextField.Config = { textField in
        textField.becomeFirstResponder()
        textField.textColor = textColor
        textField.placeholder = placeHolder
        textField.leftViewPadding = 12
        textField.borderWidth = 1
        textField.cornerRadius = 8
        textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
        textField.backgroundColor = nil
        textField.keyboardAppearance = .default
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.action { textField in
            action(textField.trimmedString())
        }
    }
    alert.addOneTextField(configuration: config)
    alert.addAction(title: buttonText, style: .default)
    alert.show()
}

func alertPicker(title: String = "Title", message: String = "", buttonText: String = "Ok", list: [String], action: @escaping (Int, String) -> Void) {
    let alert = UIAlertController(style: .actionSheet, title: title, message: message)
    let pickerViewValues: [[String]] = [list.map { String($0).description }]
    let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: list.firstIndex(of: "") ?? 0)
    alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1) {
                action(index.row, values[0][index.row])
            }
        }
    }
    alert.addAction(title: buttonText, style: .default)
    alert.show()
}

func alertCountry(buttonTitle: String = "OK", localeInfo: @escaping (LocaleInfo) -> Void) {
    let alert = UIAlertController(style: .actionSheet, message: "Select Country")
    alert.addLocalePicker(type: .country) { info in localeInfo(info!) }
    alert.addAction(title: buttonTitle, style: .cancel)
    alert.show()
}

func alertCountryPhone(buttonTitle: String = "OK", localeInfo: @escaping (LocaleInfo) -> Void) {
    let alert = UIAlertController(style: .actionSheet, title: "Phone Codes")
    alert.addLocalePicker(type: .phoneCode) { info in localeInfo(info!) }
    alert.addAction(title: buttonTitle, style: .cancel)
    alert.show()
}

func alertCountryCurrency(buttonTitle: String = "OK", localeInfo: @escaping (LocaleInfo) -> Void) {
    let alert = UIAlertController(style: .actionSheet, title: "Phone Codes")
    alert.addLocalePicker(type: .currency) { info in localeInfo(info!) }
    alert.addAction(title: buttonTitle, style: .cancel)
    alert.show()
}

func alertImagePicker(buttonTitle: String = "OK", addButtonTitle: String = "Add", uiImage: @escaping (UIImage) -> Void) {
    let alert = UIAlertController(style: .actionSheet)
    alert.addPhotoLibraryPicker( flow: .vertical, addButtonTitle: addButtonTitle, paging: true, selection: .single(action: { image in
        uiImage(image!.toUIImage())
    }))
    alert.addAction(title: buttonTitle, style: .cancel)
    alert.show()
}

func alertColor(color: UIColor = .red, action: @escaping (UIColor) -> Void) {
    let alert = UIAlertController(style: .actionSheet)
    alert.addColorPicker(color: color) { color in action(color) }
    alert.addAction(title: "Done", style: .cancel)
    alert.show()
}

func alertText(buttonText: String = "OK",text: [AttributedTextBlock] ) {
    let alert = UIAlertController(style: .actionSheet)
    alert.addTextViewer(text: .attributedText(text))
    alert.addAction(title: buttonText, style: .cancel)
    alert.show()
}
private let text: [AttributedTextBlock] = [
    .header1("U.S. Returns & Refunds Policy."),
    .header2("Standard Return Policy."),
    .normal("There are a few important things to keep in mind when returning a product you purchased online from Apple:"),
    .list("You have 14 calendar days to return an item from the date you received it.")]


func alertLocation(buttonText: String = "OK", loc: @escaping (Location) -> Void) {
    let alert = UIAlertController(style: .actionSheet)
    alert.addLocationPicker { location in loc(location!) }
    alert.addAction(title: buttonText, style: .cancel)
    alert.show()
}

func alertContact(buttonText: String = "OK", con: @escaping (Contact) -> Void) {
    let alert = UIAlertController(style: .actionSheet)
    alert.addContactsPicker { contact in  con(contact!)}
    alert.addAction(title: buttonText, style: .cancel)
    alert.show()
}
