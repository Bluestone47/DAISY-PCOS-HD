//
//  PartAViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class PartAViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToPartB", sender: self)
    }
    

}
