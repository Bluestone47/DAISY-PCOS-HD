//
//  LogInViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.text = nil
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - Finish Login
    /***************************************************************/
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        
        // if the input is valid, start login
        if validateInput() == true {
            // Login to acquire user info
            UserLogin.login(email: emailTextField.text!, password: passwordTextField.text!)

            // Wait 0.5 second for the communication to finish
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if UserInfoObject.auth == true {
                    self.performSegue(withIdentifier: "goToPartA", sender: self)
                }
                else {

                }
            }
        }
    }
    
    // Check if the email and password are valid
    func validateInput() -> Bool {
        
        if emailTextField.text == nil || emailTextField.text == "Email" {
            errorLabel.text = "Please input email"
            return false
        }
        else if isValidEmail(testStr: emailTextField.text!) == false {
            errorLabel.text = "Invalid email address"
            return false
        }
        else if passwordTextField.text == nil || passwordTextField.text == "Password" {
            errorLabel.text = "Please input password"
            return false
        }
        
        return true
        
    }


}
