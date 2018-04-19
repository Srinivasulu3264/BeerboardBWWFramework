//
//  RedeemBeerchipViewController.swift
//  BeerboardBeerchipFramework
//
//  Created by Vmoksha on 26/02/18.
//  Copyright © 2018 Vmoksha. All rights reserved.
//

import UIKit


protocol redeemBeerchipVCProtocol {
    
    func displayLocationTable()
}


class RedeemBeerchipViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var cashoutBtn: UIButton!
    
    @IBOutlet weak var receiptIDTxtfield: UITextField!
    @IBOutlet weak var redeemBeerchipVCLocationIndicatorBtn: UIButton!
    
    var isCashoutVCAdding = false
    var isCashoutVCRemoving = false
    
    var isRedeemBeerchipVCAdding = false
    var isRedeemBeerchipVCRemoving = false
    
    var cashOutVC = UIViewController()
    var redeemBeerchipVC = RedeemBeerchipViewController()
    
    var redeemBeerchipVCDelegate : redeemBeerchipVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

          redeemBeerchipVCLocationIndicatorBtn.layer.cornerRadius = 8.0
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        receiptIDTxtfield.delegate = self
        
          let beerboardBWWStoryboard = UIStoryboard(name: "BeerboardBWWFrameworkStoryboard", bundle: Bundle(for: BeerboardBWWViewController.self))
        cashOutVC =  beerboardBWWStoryboard.instantiateViewController(withIdentifier: "CashOutViewController") as! CashOutViewController
        
        redeemBeerchipVC =  beerboardBWWStoryboard.instantiateViewController(withIdentifier: "RedeemBeerchipViewController") as! RedeemBeerchipViewController
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        receiptIDTxtfield.resignFirstResponder()
        return false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var userdefaultsLocation = UserDefaults.standard.string(forKey: "location")
        
        if userdefaultsLocation == nil {
            userdefaultsLocation = "CAMILLUS"
        }
      
        redeemBeerchipVCLocationIndicatorBtn.setTitle(userdefaultsLocation, for: .normal)
        
    }
    
    @IBAction func redeemBeerchipVCLocationIndicationBtnAction(_ sender: Any) {
        
        redeemBeerchipVCDelegate?.displayLocationTable()
        
    }
    
   
    @IBAction func cashoutBtnAction(_ sender: Any) {
        
        if cashoutBtn.currentTitle == "REDEEM"
        {
            isRedeemBeerchipVCAdding = true
            redeemBeerchipVCAddingAndRemoving()
            
            isCashoutVCRemoving = true
            cashoutVCAddingAndRemoving()
            
            cashoutBtn.setImage(nil, for: .normal)
            cashoutBtn.setTitle("CASH OUT", for: .normal)
          
        }
        else{
            
            cashoutBtn.setTitle("REDEEM", for: .normal)
            guard let imageObj  = UIImage(named:"view-redeem-icon.png") else{ return  }
            cashoutBtn.setImage( imageObj  , for: .normal)
            
            isRedeemBeerchipVCRemoving = true
            redeemBeerchipVCAddingAndRemoving()
            
            isCashoutVCAdding = true
            cashoutVCAddingAndRemoving()
        }
}
    
    
    func cashoutVCAddingAndRemoving()  {
        
        if isCashoutVCAdding {
            self.addChildViewController(cashOutVC)
            cashOutVC.view.frame = CGRect(x: 0, y: 160, width:  UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height-160))
            self.view.addSubview(cashOutVC.view)
            cashOutVC.didMove(toParentViewController: self)
            isCashoutVCAdding = false
        }
        if isCashoutVCRemoving{
            cashOutVC.willMove(toParentViewController: nil)
            cashOutVC.view.removeFromSuperview()
            cashOutVC.removeFromParentViewController()
            isCashoutVCRemoving = false
        }
    }
    
    
    func redeemBeerchipVCAddingAndRemoving()  {
        
        if isRedeemBeerchipVCAdding {
            self.addChildViewController(redeemBeerchipVC)
            redeemBeerchipVC.view.frame = CGRect(x: 0, y: 160, width: UIScreen.main.bounds.width, height:  (UIScreen.main.bounds.height-160))
            self.view.addSubview(redeemBeerchipVC.view)
            redeemBeerchipVC.didMove(toParentViewController: self)
            isRedeemBeerchipVCAdding = false
        }
        if isRedeemBeerchipVCRemoving{
            redeemBeerchipVC.willMove(toParentViewController: nil)
            redeemBeerchipVC.view.removeFromSuperview()
            redeemBeerchipVC.removeFromParentViewController()
            isRedeemBeerchipVCRemoving = false
        }
    }
}
