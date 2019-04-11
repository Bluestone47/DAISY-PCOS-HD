//
//  PartAViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class PartAViewController: UIViewController {
    
    
    @IBOutlet weak var type1Button: UIButton!
    @IBOutlet weak var type2Button: UIButton!
    @IBOutlet weak var type3Button: UIButton!
    
    lazy var hairButtons : [UIButton] = [type1Button, type2Button, type3Button]
    
    //    let type1Image = UIImage(named: "Type1") as UIImage?
    //    let type1CheckedImage = UIImage(named: "Type1 - Checked") as UIImage?
    //    let type2Image = UIImage(named: "Type2") as UIImage?
    //    let type2CheckedImage = UIImage(named: "Type2 - Checked") as UIImage?
    //    let type3Image = UIImage(named: "Type3") as UIImage?
    //    let type3CheckedImage = UIImage(named: "Type3 - Checked") as UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadHairButtons()
        
    }
    
    func loadHairButtons(){
        
        for button in hairButtons {
            button.setImage(UIImage(named: "Type\(button.tag)") as UIImage?, for: .normal)
            button.addTarget(self, action: #selector(self.changeImageButton(_:)), for:.touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    @objc func changeImageButton(_ sender: UIButton) {
        
        for button in hairButtons {
            if button.tag == sender.tag {
                button.isSelected = true
                button.setImage(UIImage(named: "Type\(button.tag) - Checked") as UIImage?, for: .normal)
            }
            else if button.tag != sender.tag {
                button.isSelected = false
                button.setImage(UIImage(named: "Type\(button.tag)") as UIImage?, for: .normal)
            }
        }
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToPartB", sender: self)
    }
    
}
