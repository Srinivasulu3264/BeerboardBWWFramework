//
//  BeerChipTableViewController.swift
//  BeerboardBeerchipFramework
//
//  Created by Vmoksha on 23/02/18.
//  Copyright © 2018 Vmoksha. All rights reserved.
//

import UIKit



class BeerChipTableViewController: UIViewController {
    
    var beerNamesArr = [String]()
     var beerSubtitlsArr = [String]()
    var beerCostArr = [String]()
  

    @IBOutlet weak var beerchipTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerchipTable.tableFooterView = UIView()
        beerNamesArr = ["FOUNDERS ALL DAY IPA" , "HEINEKEN" ,"LAGUNITAS IPA","FOUNDERS ALL DAY IPA" , "HEINEKEN"]
        beerCostArr = ["$11.00","$2.00","$2.00","$3.50","$2.00"]
        beerSubtitlsArr = ["American IPA/ Founders Brewing / Grand Rapids,MI","Euro Lager/Heineken/Amsterdam ,NLD","American IPA /Lagunitas brewing/Petaluma CA","American IPA/ Founders Brewing / Grand Rapids,MI","Euro Lager/Heineken/Amsterdam ,NLD"]
        // Do any additional setup after loading the view.
    }
}
extension BeerChipTableViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  beerNamesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerchipTableViewCell
        cell.beerTitleLbl.text = beerNamesArr[indexPath.row]
        cell.beerSubTitleLbl.text = beerSubtitlsArr[indexPath.row]
        cell.beerCostLbl.text =  beerCostArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
