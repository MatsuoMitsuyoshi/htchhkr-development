//
//  CircleView.swift
//  htchhkr-development
//
//  Created by mitsuyoshi matsuo on 2019/03/21.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
    }


}
