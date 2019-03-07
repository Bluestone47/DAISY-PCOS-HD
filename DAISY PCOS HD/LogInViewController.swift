//
//  LogInViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logInPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToQuiz", sender: self)
        
    }
    
    
}
