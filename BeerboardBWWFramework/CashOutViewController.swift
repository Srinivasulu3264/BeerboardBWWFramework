//
//  CashOutViewController.swift
//  BeerboardBeerchipFramework
//
//  Created by Vmoksha on 26/02/18.
//  Copyright © 2018 Vmoksha. All rights reserved.
//

import UIKit

class CashOutViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    
    var  giftImagesArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        giftImagesArr = ["gift-card-hooters","gift-card-applebees","gift-card-express","gift-card-itunes","gift-card-walmart","gift-card-starbucks"]
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftImagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cashoutCell", for: indexPath)
        let cashoutImgView = cell .viewWithTag(99) as! UIImageView
        let imgName = giftImagesArr[indexPath.row]
        cashoutImgView.image = UIImage(named: imgName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: (self.view.frame.size.width-30.0)/2.0  , height: (self.view.frame.size.height-150.0)/3.0  )
    }
}


