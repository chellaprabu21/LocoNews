//
//  SourceView.swift
//  LocoNews
//
//  Created by Chellaprabu V on 12/04/22.
//

import UIKit

class SourceView: UIView{

    var tableView = UITableView()
    var countryName = "in"
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var source: [Source] = []

    init(frame: CGRect, country: String){
        super.init(frame: frame)
            setup()
            countryName = country
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    

    public func triggerSource(){
        
        source.removeAll()
        APIManager.shared.getSource(forCountry: countryName) { result in
            self.source += result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func setup() {

        tableView = UITableView(frame: self.frame)
        self.addSubview(tableView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SourceView: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
        
        cell.textLabel?.text = source[indexPath.row].name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryDict:[String: String] = ["Channel": source[indexPath.row].name!,
                                            "ChannelId": source[indexPath.row].id!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showChannelHeadlines"),
                                                        object: nil,
                                                        userInfo: countryDict)
    }
}

