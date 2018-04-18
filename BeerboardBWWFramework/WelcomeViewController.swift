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

    override public func viewDidLoad() {
        super.viewDidLoad()

        titleArr = ["AUGUST SHELL FORT ROAD HELLES " , "BLUE POINT TOASTED LAGER " ,"SAMUEL ADAMS BOSTON LAGAR"]
        subTitleArr = ["German Style Helles/August Schell brewing Company/New Utm,MN","Vienna Lager/Blue point Brewery/Patchogue,NY","Vienna Lager/Samuel Adams/Boston,MA"]
        beerMenuImagesArr = ["beer-logo-bud-light","beer-logo-bud-light-lime" ,"beer-logo-budweiser","beer-logo-bud-light"]
        abvValueArr = ["5.8%","6%","5%"]
        // Do any additional setup after loading the view.
    }
}

extension WelcomeViewController:UITableViewDelegate,UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return  titleArr.count+1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
}
