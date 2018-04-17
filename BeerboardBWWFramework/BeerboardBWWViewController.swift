//
//  BeerboardBWWViewController.swift
//  BeerboardBWWFramework
//
//  Created by Srinivasulu Budharapu on 10/04/18.
//  Copyright © 2018 Srinivasulu Budharapu. All rights reserved.
//

import UIKit

public class BeerboardBWWViewController: UIViewController {

    @IBOutlet weak var viewRedeemBtn: UIButton!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        viewRedeemBtn.layer.cornerRadius = 8.0
        // Do any additional setup after loading the view.
    }

    @IBAction func viewRedeemBtnAction(_ sender: Any) {
        
        performSegue(withIdentifier: "welcomeVCSegue", sender: self)
    }

}
