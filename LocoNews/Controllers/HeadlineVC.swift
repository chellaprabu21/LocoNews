//
//  HeadlineVC.swift
//  LocoNews
//
//  Created by Chellaprabu V on 06/04/22.
//

import UIKit

class HeadlineVC: UIViewController {

    @IBOutlet weak var headLineTable: UITableView!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    var news: [Article] = []
    var country: String?
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        triggerData()
        // Do any additional setup after loading the view.
        segment.isHidden = true
        headLineTable.delegate = self
        headLineTable.dataSource = self
    }
    
    func increamentPage() -> Int{
        page += 1
        return page
    }
    private func triggerData(){
        
        APIManager.shared.getNews(forPage: increamentPage(), forCountry: country) { result in 
            self.news += result
            DispatchQueue.main.async {
                self.headLineTable.reloadData()
            }
        }
    }
    
}

extension HeadlineVC : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        
        if pos > headLineTable.contentSize.height-100-scrollView.frame.size.height{
//            triggerData()
        }
    }
}

extension HeadlineVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = headLineTable.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! HeadlinesCell
        
        let article = news[indexPath.row]
        
        cell.setNews(article)
        

        
        return cell
    }
    
    
    
}
