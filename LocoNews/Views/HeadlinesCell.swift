//
//  HeadlinesCell.swift
//  LocoNews
//
//  Created by Chellaprabu V on 06/04/22.
//

import UIKit

class HeadlinesCell: UITableViewCell {

    @IBOutlet weak var headlineText: UILabel!
    @IBOutlet weak var sourceText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setNews(_ news: Article) {
        
        headlineText.translatesAutoresizingMaskIntoConstraints = false
        sourceText.translatesAutoresizingMaskIntoConstraints = false
        
        headlineText.text = news.title
        sourceText.text = news.source.name
    }

}
