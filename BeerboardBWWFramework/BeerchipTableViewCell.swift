//
//  BeerchipTableViewCell.swift
//  BeerboardBeerchipFramework
//
//  Created by Vmoksha on 23/02/18.
//  Copyright © 2018 Vmoksha. All rights reserved.
//

import UIKit

class BeerchipTableViewCell: UITableViewCell {

    
    @IBOutlet weak var beerCostLbl: UILabel!
    
    @IBOutlet weak var beerTitleLbl: UILabel!
    
    @IBOutlet weak var beerSubTitleLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
