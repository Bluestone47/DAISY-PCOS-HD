//
//  RegisterViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

// Tap the view to dismiss keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// Define a UIDatePicker with a done button
extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        // toolBar.tintColor = UIColor.black
        toolBar.tintColor = UIColor(red: 76/255, green: 100/255, blue: 217/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
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
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var centerPicker: UIPickerView!
    

    let centerArray = [
        "GBBI - Birmingham (Queen Elizabeth Hospital, Birmingham Women’s Hospital)",
        "GBCO - Coventry (University Hospital Coventry & Warwickshire)",
        "GBCA - Cardiff (University Hospital of Wales)",
        "GBLE - Leeds (Seacroft Hospital)",
        "GBLO1 - Barts Health London (Barts Hospital, Whipps Cross Hospital, Newham Hospital)",
        "GBLO2 - Imperial College London NHS Trust (St. Mary’s Hospital, London)"
    ]
    var datePickerView  : UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 834, height: 240))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        centerTextField.delegate = self
        // birthdayTextField.delegate = self
        
        centerPicker.delegate = self
        // centerPicker.dataSource = self

        // prepare centerPicker
        centerPicker.isHidden = true;
        
        // prepare birthdayPicker
        // Tool bar with done button
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.dismissPicker))
        birthdayTextField.inputAccessoryView = toolBar
        birthdayTextField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        birthdayTextField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        
        // input with datePicker
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        datePickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        inputView.addSubview(datePickerView)
        
        birthdayTextField.inputView = inputView
        birthdayTextField.autocorrectionType = .no
        
        datePickerView.addTarget(self, action: #selector(self.handleDatePicker(_:)), for: UIControl.Event.valueChanged)
        
    }
    
    //MARK: - Setup birthdayPicker
    /***************************************************************/
    
    @objc func dismissPicker() {
        
        handleDatePicker(datePickerView)
        view.endEditing(true)
        
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        birthdayTextField.text = dateFormatter.string(from: sender.date)
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
        dismissKeyboard()
        centerPicker.isHidden = false
        return false
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - Finish Register
    /***************************************************************/
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        // Getting value from input
        let info: [String: String] = [
            "email": emailTextField.text!,
            "password": passwordTextField.text!,
            "center_id": centerTextField.text!,
            "dob": birthdayTextField.text!
        ]
        
//        if isValidEmail(testStr: emailTextField.text!) == false {
//            errorLabel.text = "Email"
//        }
//        else {
//            // Login to acquire user info
//            print(info)
//            UserRegister.signup(registerInfo: info)
//            self.performSegue(withIdentifier: "goToPartA", sender: self)
//            // Wait 0.5 second for the communication to finish
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                if UserInfoObject.auth == true {
                    self.performSegue(withIdentifier: "goToPartA", sender: self)
//                }
//                else {
//                    // self.showAlert(title: "Error", message: "Email already exists.")
//                }
//            }
//        }
        
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
