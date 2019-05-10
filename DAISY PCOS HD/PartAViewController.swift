//
//  PartAViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit
import DLRadioButton
import M13Checkbox

// Check if a string numbers
extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

class PartAViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var centerIDLabel: UILabel!
    
    @IBOutlet weak var ethnicLabel: UILabel!
    @IBOutlet weak var ethnicButton: DLRadioButton!
    
    @IBOutlet weak var bodyHairLabel: UILabel!
    @IBOutlet weak var hairYesButton: M13Checkbox!
    @IBOutlet weak var hairNoButton: M13Checkbox!
    @IBOutlet weak var hairOptionView: UIView!
    @IBOutlet weak var hairAge: UITextField!
    @IBOutlet weak var hairTypeView: UIView!
    @IBOutlet weak var type1Button: UIButton!
    @IBOutlet weak var type2Button: UIButton!
    @IBOutlet weak var type3Button: UIButton!
    
    let defaults = UserDefaults.standard
    let defaultsKey = "LastResult"
    var lastResult = [String : String]()
    
    // temp answers
    var temp = [String:String]()
    
    lazy var hairButtons : [UIButton] = [type1Button, type2Button, type3Button]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLabels()
        
        hairAge.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        hairAge.delegate = self
        
        hairOptionView.isHidden = true
        loadHairButtons()
        
        print("PartA")
        print(defaults.dictionary(forKey: defaultsKey) as Any)
        
        lastResult = defaults.dictionary(forKey: defaultsKey) as! [String : String]
        if lastResult["PatientID"] == UserInfoObject.shared().userInfo.patientID {
            print(lastResult)
            loadUserDefaults()
        }
        
    }
    
    // Load the data if user didn't finish last time
    func loadUserDefaults() {
        
        for button in ethnicButton.otherButtons {
            if button.titleLabel!.text == lastResult["ethnic"] {
                button.isSelected = true
            }
        }
        
        if lastResult["loss_hair"] == "Yes"{
            hairYesButton.setCheckState(M13Checkbox.CheckState.checked, animated: true)
            hairOptionView.isHidden = false
            hairAge.text = lastResult["start_age"]
            if lastResult["hair_type"] == "Type1" {
                type1Button.isSelected = true
                changeImageButton(type1Button)
            }
            else if lastResult["hair_type"] == "Type2" {
                type2Button.isSelected = true
                changeImageButton(type2Button)
            }
            else if lastResult["hair_type"] == "Type3" {
                type3Button.isSelected = true
                changeImageButton(type3Button)
            }
        }
        else if lastResult["loss_hair"] == "No"{
            hairNoButton.setCheckState(M13Checkbox.CheckState.checked, animated: true)
        }
        
        showAlert(title: "Unfinished Quiz", message: "You didn't finish this quiz last time, \nyour answers are restored.")
    }
    
    func loadLabels() {
        
        centerIDLabel.text = "Welcome Patient \(UserInfoObject.shared().userInfo.patientID)"
        ethnicLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        bodyHairLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
    }
    
    @IBAction func hairYesPressed(_ sender: Any) {
        hairNoButton.setCheckState(M13Checkbox.CheckState.unchecked, animated: true)
        // hairNoButton.toggleCheckState()
        hairOptionView.isHidden = false
    }
    
    @IBAction func hairNoPressed(_ sender: Any) {
        hairYesButton.setCheckState(M13Checkbox.CheckState.unchecked, animated: true)
        // hairYesButton.toggleCheckState()
        hairOptionView.isHidden = true
    }
    
    
    // set the max length for age textField as 2
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 2
    }
    
    func loadHairButtons(){
        
        for button in hairButtons {
            button.setImage(nil, for: .normal)
            button.setBackgroundImage(UIImage(named: "Type\(button.tag)") as UIImage?, for: .normal)
            button.addTarget(self, action: #selector(self.changeImageButton(_:)), for:.touchUpInside)
            // self.view.addSubview(button)
            hairTypeView.addSubview(button)
        }
    }
    
    @objc func changeImageButton(_ sender: UIButton) {
        
        for button in hairButtons {
            if button.tag == sender.tag {
                temp["hair_type"] = "Type\(button.tag)"
                button.isSelected = true
                button.setBackgroundImage(UIImage(named: "Type\(button.tag) - Checked") as UIImage?, for: .normal)
            }
            else if button.tag != sender.tag {
                button.isSelected = false
                button.setBackgroundImage(UIImage(named: "Type\(button.tag)") as UIImage?, for: .normal)
            }
        }
        
    }
    
    func gatherAnswers() -> Bool {
        
        // Get ethnic answer
        // print(print(String(format: "%@ is selected.\n", ethnicButton.selected()!.titleLabel!.text!)))
        temp["ethnic"] = ethnicButton.selected()?.titleLabel!.text
        
        // Check ethnic answer
        if temp["ethnic"] == nil {
            return false
        }
        // Check hair loss answer
        if hairYesButton.checkState == M13Checkbox.CheckState.unchecked && hairNoButton.checkState == M13Checkbox.CheckState.unchecked {
            return false
        }
        
        // Get hair answer
        if hairYesButton.checkState == M13Checkbox.CheckState.checked {
            temp["loss_hair"] = "Yes"
            temp["start_age"] = hairAge.text
            
            // Check hair loss age
            if temp["start_age"] == nil || temp["start_age"]?.isNumber == false || temp["hair_type"] == nil {
                return false
            }
        }
        else {
            temp["loss_hair"] = "No"
        }
        
        QuizResult.shared().result["part_a"] = temp
        
        return true
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        
        if gatherAnswers() == true {
//            print(QuizResult.shared().result["part_a"]!)
            var tempUserDefaults = QuizResult.shared().result["part_a"] as! [String: String]
            tempUserDefaults["PatientID"] = UserInfoObject.shared().userInfo.patientID
            
            self.defaults.set(tempUserDefaults, forKey: defaultsKey)
            print(defaults.dictionary(forKey: defaultsKey)!)
            performSegue(withIdentifier: "goToPartB", sender: self)
        }
        else {
            showAlert(title: "Incomplete", message: "Please complete all questions before proceed.")
        }
        
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
