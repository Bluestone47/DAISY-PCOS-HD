//
//  DesignableView.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 11/4/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
