//
//  LeftSidePanelVC.swift
//  htchhkr-development
//
//  Created by mitsuyoshi matsuo on 2019/03/21.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit

class LeftSidePanelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUpLoginBtnWasPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        present(loginVC!, animated: true, completion: nil)
    }
    
}
