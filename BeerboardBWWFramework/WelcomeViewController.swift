//
//  WelcomeViewController.swift
//  BeerboardBWWFramework
//
//  Created by Srinivasulu Budharapu on 10/04/18.
//  Copyright © 2018 Srinivasulu Budharapu. All rights reserved.
//

import UIKit

public class WelcomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var beerchiptableContainerView: UIView!
    
    @IBOutlet weak var contentView: UIView!
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
     var redeemBeerchipVC = RedeemBeerchipViewController()
    
    
    var isTableClicked = false
    
    var isBeerchipTableVCAdding = false
    var isBeerchipTableVCRemoving = false
    
    var isRedeemBeerchipLocation = false
    var usedefaults = UserDefaults.standard
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.title = "BEERCHIPS"
        beerMenuTableView.estimatedRowHeight = 100.0
        beerMenuTableView.rowHeight = UITableViewAutomaticDimension
        beerMenuTableView.tableFooterView = UIView()
        
        titleArr = ["AUGUST SHELL FORT ROAD HELLES " , "BLUE POINT TOASTED LAGER " ,"SAMUEL ADAMS BOSTON LAGAR"]
        subTitleArr = ["German Style Helles/August Schell brewing Company/New Utm,MN","Vienna Lager/Blue point Brewery/Patchogue,NY","Vienna Lager/Samuel Adams/Boston,MA"]
        beerMenuImagesArr = ["beer-logo-bud-light","beer-logo-bud-light-lime" ,"beer-logo-budweiser","beer-logo-bud-light"]
        abvValueArr = ["5.8%","6%","5%"]
        locationArr = ["Cahokia","Canton","Camillus","Columbus","Dalton","Douglas","East Hartford","East Haven","Enfield","Fairfield","Farmington","Greenwich","Groton"]
        
        cashOutBtnView.backgroundColor = UIColor.black
        
        cashOutBtn.layer.cornerRadius = 8.0
        redeemBtn.layer.cornerRadius = 8.0
        locationIndicatorBtn.layer.cornerRadius = 8.0
        
        alphaView.isHidden = true
        locationTableContainerView.isHidden = true
        
        
        let beerboardBWWStoryboard = UIStoryboard(name: "BeerboardBWWFrameworkStoryboard", bundle: Bundle(for: BeerboardBWWViewController.self))
        
        beerchipTableVC =  beerboardBWWStoryboard.instantiateViewController(withIdentifier: "BeerChipTableViewController") as! BeerChipTableViewController
        redeemBeerchipVC =  beerboardBWWStoryboard.instantiateViewController(withIdentifier: "RedeemBeerchipViewController") as! RedeemBeerchipViewController
        redeemBeerchipVC.redeemBeerchipVCDelegate = self
        
        let index = NSIndexPath(row: 3, section: 0)
        self.locationTableView.selectRow(at: index as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
        
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
       
        alphaView.isHidden = false
        locationTableContainerView.isHidden = false
    }
    
    
    @IBAction func beerMenuSegmentedControlAction(_ sender: Any) {
        
        if beerMenuSegmentedControl.selectedSegmentIndex == 0 {
            print("called segmnet 0")
            
            currentBalancedisplayLbl.text = "$7.50"
            myBalanceDisplayLable.text = "$7.50"
            cashOutBtnView.isHidden = false
            cashOutBtnView.backgroundColor = UIColor.black
            isBeerchipTableVCRemoving = true
            beerChipTableVCAddingAndRemoving()
        }else{
            print("called segment 1")
            
            currentBalancedisplayLbl.text = "$20.50"
            myBalanceDisplayLable.text = "$20.50"
            cashOutBtnView.isHidden = true
            
            isBeerchipTableVCAdding = true
            beerChipTableVCAddingAndRemoving()
        }
    }
    
    
    
    @IBAction func redeemButtonAction(_ sender: Any) {
        
        performSegue(withIdentifier: "RedeemBeerchipSegue", sender: self)

    }
    
    @IBAction func locationIndicatorBtnAction(_ sender: Any) {
        
        alphaView.isHidden = false
        locationTableContainerView.isHidden = false
    }
    
    func beerChipTableVCAddingAndRemoving()  {
        
        if isBeerchipTableVCAdding {
            self.addChildViewController(beerchipTableVC)
            beerchipTableVC.view.frame = CGRect(x: 0, y: 232, width:  UIScreen.main.bounds.width, height: (beerchiptableContainerView.bounds.height))
            contentView.addSubview(beerchipTableVC.view)
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
}


extension WelcomeViewController:redeemBeerchipVCProtocol{
    
    func customBackButtonAction() {
        currentBalancedisplayLbl.text = "$20.50"
        myBalanceDisplayLable.text = "$20.50"
        cashOutBtnView.isHidden = true
        
        isBeerchipTableVCAdding = true
        beerChipTableVCAddingAndRemoving()
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
            
            if indexPath.row == 0 {
                let   cell  = tableView.dequeueReusableCell(withIdentifier: "locationTitleCell") as! LocationTableViewCell
                let label = cell.viewWithTag(99) as! UILabel
                label.text = "LOCATIONS"
                label.font = UIFont .systemFont(ofSize: 25.0)
                return cell
            }
            else{
            
            let   cell  = tableView.dequeueReusableCell(withIdentifier: "locationCell") as! LocationTableViewCell
            cell.locationNameLbl.text = locationArr[indexPath.row-1]
            let backgroundView = UIView()
            backgroundView.backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            cell.selectedBackgroundView = backgroundView
            return cell
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == locationTableView {
            let locationName = locationArr[indexPath.row-1]
            locationIndicatorBtn.setTitle(locationName, for: .normal)
            alphaView.isHidden = true
            locationTableContainerView.isHidden = true
            usedefaults.set(locationName, forKey: "location")
        }
    }
}
