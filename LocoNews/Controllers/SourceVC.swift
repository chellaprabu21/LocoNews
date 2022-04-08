//
//  SourceVC.swift
//  LocoNews
//
//  Created by Chellaprabu V on 07/04/22.
//

import UIKit

class SourceVC: UIViewController {

    @IBOutlet weak var sourceTable: UITableView!
    
    var source: [Source] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sourceTable.delegate = self
        sourceTable.dataSource = self
    }
    
    private func triggerData(){
        
        APIManager.shared.getSource() { result in
            self.source += result
            DispatchQueue.main.async {
                self.sourceTable.reloadData()
            }
        }
    }

}

extension SourceVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sourceTable.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as! ChannelCell
        cell.setChannelName(source[indexPath.row].name!)
        return cell
    }
    
    
}
