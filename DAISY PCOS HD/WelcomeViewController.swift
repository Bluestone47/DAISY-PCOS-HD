//
//  WelcomeViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Calming-Blurred-Background")!)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Calming-Blurred-Background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
        print("\(GetIPAddress.getIPAddress())")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
