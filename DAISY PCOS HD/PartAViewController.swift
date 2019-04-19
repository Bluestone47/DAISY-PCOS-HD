//
//  PartAViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class PartAViewController: UIViewController {
    
    
    @IBOutlet weak var centerIDLabel: UILabel!
    
    @IBOutlet weak var hairOptionView: UIView!
    
    @IBOutlet weak var hairYesButton: DLRadioButton!
    @IBOutlet weak var hairNoButton: DLRadioButton!
    
    @IBOutlet weak var hairTypeView: UIView!
    
    @IBOutlet weak var type1Button: UIButton!
    @IBOutlet weak var type2Button: UIButton!
    @IBOutlet weak var type3Button: UIButton!
    
    lazy var hairButtons : [UIButton] = [type1Button, type2Button, type3Button]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerIDLabel.text = "Welcome \(UserInfoObject.shared().userInfo.patientID)"
        
        hairOptionView.isHidden = true
        // hairTypeView.isHidden = true
        loadHairButtons()
        
    }
    
    @IBAction func hairYesPressed(_ sender: Any) {
        hairNoButton.isSelected = false
        hairOptionView.isHidden = false
        // hairTypeView.isHidden = false
    }
    
    @IBAction func hairNoPressed(_ sender: Any) {
        hairYesButton.isSelected = false
        hairOptionView.isHidden = true
        // hairTypeView.isHidden = true
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
                button.isSelected = true
                button.setBackgroundImage(UIImage(named: "Type\(button.tag) - Checked") as UIImage?, for: .normal)
            }
            else if button.tag != sender.tag {
                button.isSelected = false
                button.setBackgroundImage(UIImage(named: "Type\(button.tag)") as UIImage?, for: .normal)
            }
        }
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToPartB", sender: self)
    }
    
}
