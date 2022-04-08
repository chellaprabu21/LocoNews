//
//  ChannelCell.swift
//  LocoNews
//
//  Created by Chellaprabu V on 07/04/22.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelCell: UILabel!
    
    
    func setChannelName(_ name: String){
        channelCell.text = name
    }

}
