//
//  WelcomeViewController.swift
//  BeerboardBWWFramework
//
//  Created by Srinivasulu Budharapu on 10/04/18.
//  Copyright © 2018 Srinivasulu Budharapu. All rights reserved.
//

import UIKit

public class WelcomeViewController: UIViewController {
    
    var titleArr = [String]()
    var subTitleArr = [String]()
    var abvValueArr = [String]()
    var locationArr = [String]()
    var locationAddreddArr = [String]()
    var beerMenuImagesArr = [String]()
    
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
    }
    
    
    
    @IBAction func cashOutBtnAction(_ sender: Any) {
        
    }
    
    
    @IBAction func beerMenuSegmentedControlAction(_ sender: Any) {
    }
    
    @IBAction func locationIndicatorBtnAction(_ sender: Any) {
        
        alphaView.isHidden = false
        locationTableContainerView.isHidden = false
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
        /*
        if tableView == beerMenuTableView {
            isBeerinfoVCAdding = true
            beerInfoVCAddingAndRemoving()
            isTableClicked = true
        }else{
            let locationName = locationArr[indexPath.row]
            locationIndicatorBtn.setTitle(locationName, for: .normal)
            alphaView.isHidden = true
            locationTableContainerView.isHidden = true
            
            usedefaults.set(locationName, forKey: "location")
            
            if isRedeemBeerchipLocation{
                UserDefaults.standard.set(locationName, forKey: "location")
                redeemButton.setTitle("REDEEM", for: .normal)
                redeemBtnAction(self)
            }
            
            let cell = locationTableView.cellForRow(at: indexPath) as! LocationTableViewCell
            cell.locationNameLbl.textColor = .white
            cell.locationAddessLbl.textColor = .white
        }
         */}
}
