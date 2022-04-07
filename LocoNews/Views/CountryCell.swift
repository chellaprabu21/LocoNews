//
//  CountryCell.swift
//  LocoNews
//
//  Created by Chellaprabu V on 06/04/22.
//

import UIKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    
    override class func awakeFromNib() {

    }
    func setName(_ name: String){
        countryName.text = name
    }
}
