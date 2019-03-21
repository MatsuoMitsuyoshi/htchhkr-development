//
//  HomeVC.swift
//  htchhkr-development
//
//  Created by mitsuyoshi matsuo on 2019/03/20.
//  Copyright © 2019 mitsuyoshi matsuo. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    
    var delegate: CenterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animaiteButton(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }
    
}

