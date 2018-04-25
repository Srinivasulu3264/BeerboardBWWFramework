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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cashoutBtn: UIButton!
    
    @IBOutlet weak var receiptIDTxtfield: UITextField!
    @IBOutlet weak var redeemBeerchipVCLocationIndicatorBtn: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var alphaView: UIView!
    
    @IBOutlet weak var redeemVClocationsTable: UITableView!
    
    @IBOutlet weak var locationTableContainerView: UIView!
    
    var isCashoutVCAdding = false
    var isCashoutVCRemoving = false
    
    var activeField:UIControl = UIControl()
    var cashOutVC = CashOutViewController()
    var usedefaults = UserDefaults.standard
    
    var locationArr = [String]()
    
    
    var redeemBeerchipVCDelegate : redeemBeerchipVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        redeemBeerchipVCLocationIndicatorBtn.layer.cornerRadius = 8.0
        
        redeemVClocationsTable.delegate = self
        redeemVClocationsTable.dataSource = self
        
        locationArr = ["Cahokia","Canton","Camillus","Columbus","Dalton","Douglas","East Hartford","East Haven","Enfield","Fairfield","Farmington","Greenwich","Groton"]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        receiptIDTxtfield.delegate = self
        
        let beerboardBWWStoryboard = UIStoryboard(name: "BeerboardBWWFrameworkStoryboard", bundle: Bundle(for: CashOutViewController.self))
        cashOutVC =  beerboardBWWStoryboard.instantiateViewController(withIdentifier: "CashOutViewController") as! CashOutViewController
        
        alphaView.isHidden = true
        locationTableContainerView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector:#selector(RedeemBeerchipViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(RedeemBeerchipViewController.KeyboaredWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWasShown(_ aNotification: Notification){
        print("keypadShow");
        let info = aNotification.userInfo! as NSDictionary;
        let kbSize = (info.object(forKey: UIKeyboardFrameBeginUserInfoKey)! as AnyObject).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)as UIEdgeInsets;
        self.scrollView.contentInset = contentInsets;
        var aRect = self.view.frame as CGRect;
        aRect.size.height -= kbSize.height;
        if !aRect.contains(activeField.frame.origin){
            self.scrollView.scrollRectToVisible(activeField.frame, animated: true);
        }
        
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= kbSize.height-200
            print(self.view.frame.origin.y)
        }
    }
    
    @objc func KeyboaredWillHide(){
        print("keypadHidden");
        let contentInsets = UIEdgeInsets.zero;
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 64
        }
    }
    
    
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var userdefaultsLocation = UserDefaults.standard.string(forKey: "location")
        
        if userdefaultsLocation == nil {
            userdefaultsLocation = "CAMILLUS"
        }
        redeemBeerchipVCLocationIndicatorBtn.setTitle(userdefaultsLocation, for: .normal)
    }
    
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        receiptIDTxtfield.resignFirstResponder()
        return false
    }

    @IBAction func redeemBeerchipVCLocationIndicationBtnAction(_ sender: Any) {
        
        redeemBeerchipVCDelegate?.displayLocationTable()
        
        alphaView.isHidden = false
        locationTableContainerView.isHidden = false
    }
    
   
    @IBAction func cashoutBtnAction(_ sender: Any) {
        
        if cashoutBtn.currentTitle == "REDEEM"
        {
            isCashoutVCRemoving = true
            cashoutVCAddingAndRemoving()
            cashoutBtn.setImage(nil, for: .normal)
            cashoutBtn.setTitle("CASH OUT", for: .normal)
            self.title = "REDEEM A BEERCHIP"
        }
        else{
            cashoutBtn.setTitle("REDEEM", for: .normal)
            guard let imageObj  = UIImage(named:"view-redeem-icon.png") else{ return  }
            cashoutBtn.setImage( imageObj  , for: .normal)
            isCashoutVCAdding = true
            cashoutVCAddingAndRemoving()
            self.title = "CASH OUT"
        }
}
    
    func cashoutVCAddingAndRemoving()  {
        if isCashoutVCAdding {
            self.addChildViewController(cashOutVC)
            cashOutVC.view.frame = CGRect(x: 0, y: 160, width:  UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height-160))
           contentView.addSubview(cashOutVC.view)
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
}


extension RedeemBeerchipViewController:UITableViewDelegate,UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return locationArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if indexPath.row == 0 {
                let   cell  = tableView.dequeueReusableCell(withIdentifier: "locationTitle") as! RedeemLocationTitleTableViewCell
                cell.redeemlocationTitleLabel.text = "LOCATIONS"
  
                return cell
            }
            else{
                
                let   cell  = tableView.dequeueReusableCell(withIdentifier: "locationName") as! RedeemLocationTableViewCell
                cell.redeemLocationName.text = locationArr[indexPath.row-1]
                let backgroundView = UIView()
                backgroundView.backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
                cell.selectedBackgroundView = backgroundView
                return cell
            }
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
             let locationName = locationArr[indexPath.row-1]
            redeemBeerchipVCLocationIndicatorBtn.setTitle(locationName, for: .normal)
            alphaView.isHidden = true
            locationTableContainerView.isHidden = true            
            usedefaults.set(locationName, forKey: "location")
   }
    
}
