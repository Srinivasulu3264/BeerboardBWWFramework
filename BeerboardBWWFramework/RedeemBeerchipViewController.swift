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

    
    @IBOutlet weak var receiptIDTxtfield: UITextField!
    @IBOutlet weak var redeemBeerchipVCLocationIndicatorBtn: UIButton!
    
    var redeemBeerchipVCDelegate : redeemBeerchipVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

          redeemBeerchipVCLocationIndicatorBtn.layer.cornerRadius = 8.0
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        receiptIDTxtfield.delegate = self
        
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
            userdefaultsLocation = "MANHATTAN, NY"
        }
        
        redeemBeerchipVCLocationIndicatorBtn.setTitle(userdefaultsLocation, for: .normal)
        
    }
    
    @IBAction func redeemBeerchipVCLocationIndicationBtnAction(_ sender: Any) {
        
        redeemBeerchipVCDelegate?.displayLocationTable()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
