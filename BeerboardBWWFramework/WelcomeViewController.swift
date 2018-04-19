//
//  WelcomeViewController.swift
//  BeerboardBWWFramework
//
//  Created by Srinivasulu Budharapu on 10/04/18.
//  Copyright © 2018 Srinivasulu Budharapu. All rights reserved.
//

import UIKit

public class WelcomeViewController: UIViewController {
    
       
    @IBOutlet weak var beerMenuTableView: UITableView!
    
    @IBOutlet weak var currentBalancedisplayLbl: UILabel!
    
    @IBOutlet weak var redeemBtn: UIButton!
    
    @IBOutlet weak var beerMenuSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var locationIndicatorBtn: UIButton!
    
    @IBOutlet weak var myBalanceDisplayLable: UILabel!
    
    @IBOutlet weak var cashOutBtn: UIButton!
    
    @IBOutlet weak var cashOutBtnView: UIView!

    @IBOutlet weak var locationTableView: UITableView!
    
    @IBOutlet weak var locationTableContainerView: UIView!
    
    @IBOutlet weak var alphaView: UIView!
    
    var titleArr = [String]()
    var subTitleArr = [String]()
    var abvValueArr = [String]()
    var locationArr = [String]()
    var locationAddreddArr = [String]()
    var beerMenuImagesArr = [String]()
    
    var beerchipTableVC = BeerChipTableViewController()
    var cashOutVC = UIViewController()
    var redeemBeerchipVC = RedeemBeerchipViewController()
  
    
    var isTableClicked = false
    
    var isBeerchipTableVCAdding = false
    var isBeerchipTableVCRemoving = false
    
    var isCashoutVCAdding = false
    var isCashoutVCRemoving = false
    
    var isRedeemBeerchipVCAdding = false
    var isRedeemBeerchipVCRemoving = false

    
    var isRedeemBeerchipLocation = false
    var usedefaults = UserDefaults.standard
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        beerMenuTableView.estimatedRowHeight = 100.0
        beerMenuTableView.rowHeight = UITableViewAutomaticDimension
        beerMenuTableView.tableFooterView = UIView()
        
        titleArr = ["AUGUST SHELL FORT ROAD HELLES " , "BLUE POINT TOASTED LAGER " ,"SAMUEL ADAMS BOSTON LAGAR"]
        subTitleArr = ["German Style Helles/August Schell brewing Company/New Utm,MN","Vienna Lager/Blue point Brewery/Patchogue,NY","Vienna Lager/Samuel Adams/Boston,MA"]
        beerMenuImagesArr = ["beer-logo-bud-light","beer-logo-bud-light-lime" ,"beer-logo-budweiser","beer-logo-bud-light"]
        abvValueArr = ["5.8%","6%","5%"]
        locationArr = ["Cahokia","Canton","Camillus","Columbus","Dalton","Douglas","East Hartford","East Haven","Enfield","Fairfield","Farmington","Greenwich","Groton"]
        
        alphaView.isHidden = true
        locationTableContainerView.isHidden = true
        cashOutBtnView.backgroundColor = UIColor.black
        
        cashOutBtn.layer.cornerRadius = 8.0
        redeemBtn.layer.cornerRadius = 8.0
        locationIndicatorBtn.layer.cornerRadius = 8.0
        
        
        let beerboardBWWStoryboard = UIStoryboard(name: "BeerboardBWWFrameworkStoryboard", bundle: Bundle(for: BeerboardBWWViewController.self))
        
        beerchipTableVC =  beerboardBWWStoryboard.instantiateViewController(withIdentifier: "BeerChipTableViewController") as! BeerChipTableViewController
        
        cashOutVC =  beerboardBWWStoryboard.instantiateViewController(withIdentifier: "CashOutViewController") as! CashOutViewController
        
        redeemBeerchipVC =  beerboardBWWStoryboard.instantiateViewController(withIdentifier: "RedeemBeerchipViewController") as! RedeemBeerchipViewController
        
        
        beerchipTableVC.beerchipTableDelegate = self
        redeemBeerchipVC.redeemBeerchipVCDelegate = self 
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var userdefaultsLocation = UserDefaults.standard.string(forKey: "location")
        
        if userdefaultsLocation == nil {
            userdefaultsLocation = "CAMILLUS"
        }
        locationIndicatorBtn.setTitle(userdefaultsLocation, for: .normal)
    }
    
    
    @IBAction func cashOutBtnAction(_ sender: Any) {
        
    }
    
    
    @IBAction func beerMenuSegmentedControlAction(_ sender: Any) {
        
        if beerMenuSegmentedControl.selectedSegmentIndex == 0 {
            print("called segmnet 0")
            
            currentBalancedisplayLbl.text = "$7.50"
            myBalanceDisplayLable.text = "$7.50"
            cashOutBtnView.isHidden = false
            cashOutBtnView.backgroundColor = UIColor.init(red: 59.0/255.0, green: 26.0/255.0, blue: 14.0/255.0, alpha: 1.0)
            isBeerchipTableVCRemoving = true
            beerChipTableVCAddingAndRemoving()
            
            
        }else{
             print("called segment 1")
            
            currentBalancedisplayLbl.text = "$15.00"
            myBalanceDisplayLable.text = "$15.00"
            cashOutBtnView.isHidden = true
            
            isBeerchipTableVCAdding = true
            beerChipTableVCAddingAndRemoving()
        }
    }
    
    
    
    @IBAction func redeemButtonAction(_ sender: Any) {
        
        if redeemBtn.currentTitle == "REDEEM"
        {
            isBeerchipTableVCRemoving = true
            beerChipTableVCAddingAndRemoving()
            
            isRedeemBeerchipVCAdding = true
            redeemBeerchipVCAddingAndRemoving()
            
            isCashoutVCRemoving = true
            cashoutVCAddingAndRemoving()
            
            redeemBtn.setImage(nil, for: .normal)
            redeemBtn.setTitle("CASH OUT", for: .normal)
            currentBalancedisplayLbl.text = "$15.00"
        }
        else{
            
            redeemBtn.setTitle("REDEEM", for: .normal)
            guard let imageObj  = UIImage(named:"view-redeem-icon.png") else{ return  }
            redeemBtn.setImage( imageObj  , for: .normal)
    
            isRedeemBeerchipVCRemoving = true
            redeemBeerchipVCAddingAndRemoving()
            
            isCashoutVCAdding = true
            cashoutVCAddingAndRemoving()
        }

    }
    
    @IBAction func locationIndicatorBtnAction(_ sender: Any) {
        
        alphaView.isHidden = false
        locationTableContainerView.isHidden = false
    }
    
    func beerChipTableVCAddingAndRemoving()  {
        
        if isBeerchipTableVCAdding {
            self.addChildViewController(beerchipTableVC)
            beerchipTableVC.view.frame = CGRect(x: 0, y: 177, width:  UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height-257))
            self.view.addSubview(beerchipTableVC.view)
            beerchipTableVC.didMove(toParentViewController: self)
            isBeerchipTableVCAdding = false
        }
        
        if isBeerchipTableVCRemoving{
            beerchipTableVC.willMove(toParentViewController: nil)
            beerchipTableVC.view.removeFromSuperview()
            beerchipTableVC.removeFromParentViewController()
            isBeerchipTableVCRemoving = false
        }
    }
    
    func cashoutVCAddingAndRemoving()  {
        
        if isCashoutVCAdding {
            self.addChildViewController(cashOutVC)
            cashOutVC.view.frame = CGRect(x: 0, y: 120, width:  UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height-180))
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
            redeemBeerchipVC.view.frame = CGRect(x: 0, y: 120, width: UIScreen.main.bounds.width, height:  (UIScreen.main.bounds.height-180))
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


extension WelcomeViewController:beerchipTableVCProtocol{
    
    func addBeerinfoVCFromBeerchipTableVC() {
      
        setBeerMenubtnSelected()
        isTableClicked = true
    }
    
    func setBeerMenubtnSelected()  {
       
        currentBalancedisplayLbl.text = "$7.50"
        myBalanceDisplayLable.text = "$7.50"
        cashOutBtnView.isHidden = false
        cashOutBtnView.backgroundColor = UIColor.init(red: 59.0/255.0, green: 26.0/255.0, blue: 14.0/255.0, alpha: 1.0)
        isBeerchipTableVCRemoving = true
        beerChipTableVCAddingAndRemoving()
    }
}

extension WelcomeViewController:redeemBeerchipVCProtocol{
    
    func displayLocationTable() {
        print( " location tablecalled ")
        alphaView.isHidden = false
        locationTableContainerView.isHidden = false
        isRedeemBeerchipVCRemoving = true
        redeemBeerchipVCAddingAndRemoving()
       
        isCashoutVCRemoving = true
        cashoutVCAddingAndRemoving()
        isBeerchipTableVCRemoving = true
        beerChipTableVCAddingAndRemoving()
      
        isRedeemBeerchipLocation = true
    }
}


extension WelcomeViewController:UITableViewDelegate,UITableViewDataSource{
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == beerMenuTableView {
            return  titleArr.count+1
        }else{
            return locationArr.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == beerMenuTableView {
            if indexPath.row == 0 {
                let   cell  = tableView.dequeueReusableCell(withIdentifier: "titleCell") as!RedeemViewBeerchipTableTitleTableViewCell
                cell.beerchipsLbl.text = "BEERCHIPS"
                cell.abvLabel.text = "ABV"
                return cell
            }
            else{
                let  cell  = tableView.dequeueReusableCell(withIdentifier: "subTitleCell") as! RedeemviewBeerchipTableSubTitlesTableViewCell
                cell.abvValueLbl.text = abvValueArr[indexPath.row-1]
                cell.beerTitleLable.text = titleArr[indexPath.row-1]
                let imgName = beerMenuImagesArr[indexPath.row-1]
                cell.beerDisplayImageView.image = UIImage(named: imgName)
                
                if indexPath.row == 2{
                    cell.beerchipsImageView.image = nil
                }
                cell.beerSubTitleLbl.text = subTitleArr[indexPath.row-1]
                return cell
            }
        }
        else{
            let   cell  = tableView.dequeueReusableCell(withIdentifier: "locationCell") as! LocationTableViewCell
            cell.locationNameLbl.text = locationArr[indexPath.row]
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.init(red: 172.0/255.0, green: 26.0/255.0, blue: 46.0/255.0, alpha: 1.0)
            cell.selectedBackgroundView = backgroundView
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == beerMenuTableView {
  
            isTableClicked = true
        }else{
            let locationName = locationArr[indexPath.row]
            locationIndicatorBtn.setTitle(locationName, for: .normal)
            alphaView.isHidden = true
            locationTableContainerView.isHidden = true
            
            usedefaults.set(locationName, forKey: "location")
            
            if isRedeemBeerchipLocation{
                UserDefaults.standard.set(locationName, forKey: "location")
                redeemBtn.setTitle("REDEEM", for: .normal)

            }
            
            let cell = locationTableView.cellForRow(at: indexPath) as! LocationTableViewCell
            cell.locationNameLbl.textColor = .white
          
        }
    }
}
