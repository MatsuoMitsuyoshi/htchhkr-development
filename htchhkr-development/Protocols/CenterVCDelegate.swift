//
//  CenterVCDelegate.swift
//  htchhkr-development
//
//  Created by mitsuyoshi matsuo on 2019/03/21.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
