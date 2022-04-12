//
//  SourceView.swift
//  LocoNews
//
//  Created by Chellaprabu V on 12/04/22.
//

import UIKit

class SourceView: UIView, UITableViewDataSource, UITableViewDelegate {

    var tableView = UITableView()

    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var source: [Source] = []

    override init(frame: CGRect){
        super.init(frame: frame)
        
            setup()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }

    private func triggerSource(){
        
        APIManager.shared.getSource() { result in
            self.source += result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func setup() {

//        triggerSource()
        self.backgroundColor = UIColor.black

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth*0.5, height: screenHeight))
        tableView.layer.backgroundColor = UIColor.black.cgColor
        self.addSubview(tableView)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
        
//        cell.textLabel?.text = source[indexPath.row].name
        cell.textLabel?.text = "Test"

        return cell
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
