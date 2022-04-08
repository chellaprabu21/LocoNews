//
//  CountryVC.swift
//  LocoNews
//
//  Created by Chellaprabu V on 06/04/22.
//

import UIKit

class CountryVC: UIViewController {

    @IBOutlet weak var countryCollection: UICollectionView!
    
    var selectedCountry: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        countryCollection.dataSource = self
        countryCollection.delegate = self
        
    }
}

extension CountryVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Country.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = countryCollection.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CountryCell
        
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;

        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        cell.setName(Array(Country.list)[indexPath.row].key)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCountry = Array(Country.list)[indexPath.row].value

        self.performSegue(withIdentifier: "headlineVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "headlineVC" {
             if let viewController = segue.destination as? HeadlineVC {
                 viewController.country = selectedCountry
             }
         }
    }
    
}
