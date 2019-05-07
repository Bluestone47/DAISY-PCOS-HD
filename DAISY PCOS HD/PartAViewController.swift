//
//  PartAViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var hairYesButton: DLRadioButton!
    @IBOutlet weak var hairNoButton: DLRadioButton!
    @IBOutlet weak var hairOptionView: UIView!
    @IBOutlet weak var hairAge: UITextField!
    @IBOutlet weak var hairTypeView: UIView!
    @IBOutlet weak var type1Button: UIButton!
    @IBOutlet weak var type2Button: UIButton!
    @IBOutlet weak var type3Button: UIButton!
    
    let defaults = UserDefaults.standard
    
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
        
    }
    
    func loadLabels() {
        
        centerIDLabel.text = "Welcome Patient \(UserInfoObject.shared().userInfo.patientID)"
        ethnicLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        bodyHairLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
    }
    
    @IBAction func hairYesPressed(_ sender: Any) {
        hairNoButton.isSelected = false
        hairOptionView.isHidden = false
    }
    
    @IBAction func hairNoPressed(_ sender: Any) {
        hairYesButton.isSelected = false
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
        if hairYesButton.isSelected == false && hairNoButton.isSelected == false {
            return false
        }
        
        // Get hair answer
        if hairYesButton.isSelected == true {
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
        
//        if gatherAnswers() == true {
//            print(QuizResult.shared().result["part_a"]!)
            self.defaults.set(QuizResult.shared().result, forKey: UserInfoObject.shared().userInfo.patientID)
            performSegue(withIdentifier: "goToPartB", sender: self)
//        }
//        else {
//            showAlert(title: "Incomplete", message: "Please complete all questions before proceed.")
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
