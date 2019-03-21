//
//  UIViewExt.swift
//  htchhkr-development
//
//  Created by mitsuyoshi matsuo on 2019/03/22.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
}
