//
//  Alertable.swift
//  htchhkr-development
//
//  Created by mitsuyoshi matsuo on 2019/03/29.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func showAlert(_ msg: String) {
        let alertController = UIAlertController(title: "Error:", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
