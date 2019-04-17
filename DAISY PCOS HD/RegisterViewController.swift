//
//  RegisterViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

// Define a UIDatePicker with a done button
extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var centerTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var centerPicker: UIPickerView!
    

    let centerArray = [
        "GBBI - Birmingham (Queen Elizabeth Hospital, Birmingham Women’s Hospital)",
        "GBCO - Coventry (University Hospital Coventry & Warwickshire)",
        "GBCA - Cardiff (University Hospital of Wales)",
        "GBLE - Leeds (Seacroft Hospital)",
        "GBLO1 - Barts Health London (Barts Hospital, Whipps Cross Hospital, Newham Hospital)",
        "GBLO2 - Imperial College London NHS Trust (St. Mary’s Hospital, London)"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerTextField.delegate = self
        // birthdayTextField.delegate = self
        
        centerPicker.delegate = self
        // centerPicker.dataSource = self

        // prepare centerPicker
        centerPicker.isHidden = true;
        
         // prepare birthdayPicker
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        
        birthdayTextField.inputAccessoryView = toolBar
        
    }
    
    //MARK: - Setup birthdayPicker
    /***************************************************************/
    
    @objc func dismissPicker() {
        
        view.endEditing(true)
        
    }
    
    //MARK: - Setup centerPicker
    /***************************************************************/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return centerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return centerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        centerTextField.text = String(centerArray[row].prefix(5)).trimmingCharacters(in: .whitespaces)
        centerPicker.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        centerPicker.isHidden = false
        return false
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToPartA", sender: self)
        
    }
    
    
    
}
