//
//  HeadlineVC.swift
//  LocoNews
//
//  Created by Chellaprabu V on 06/04/22.
//

import UIKit
import SafariServices

class HeadlineVC: UIViewController {

    @IBOutlet weak var headLineTable: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var headlineView: UIView!
    var sourceView: SourceView!
    
    @IBOutlet weak var segment: UISegmentedControl!
        
    var news: [Article] = []
    var country: String?
    var page = 0
    var hideSegment = true
    var tabSeleted = 0
    var tabChanged = false
    var syncQ = DispatchQueue(label:"NewsDeletion")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        sourceView =  SourceView(frame: headlineView.frame, country: country ?? "in")
        containerView.addSubview(sourceView)
        sourceView.isHidden = true
        
        segment.isHidden = true
        headLineTable.delegate = self
        headLineTable.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "Search for news"
        self.tabBarController?.delegate = self
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        
        if let tabbar = self.navigationController?.tabBarItem{
            tabSeleted = tabbar.tag
        }
        

        
        if tabSeleted == 0{
            
            if tabChanged{
                news.removeAll()
                tabChanged = false
                triggerData()
            }
            searchBar.isHidden = true
            self.navigationItem.title = "Headlines"
            lazy var once: Void = {
                triggerData()
            }()
            _ = once
        }
        else if tabSeleted == 1{
            syncQ.sync {
                self.news.removeAll()
            }
            searchBar.isHidden = true
            segment.isHidden = false
            self.navigationItem.title = "Countries"
            triggerData()
        }
        else if tabSeleted == 2{
            self.navigationItem.title = "Search"
            searchBar.isHidden = false
        }
    }

    func increamentPage() -> Int{
        page += 1
        return page
    }
    
    @IBAction func didTapSegment(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            sourceView.isHidden = true
            headlineView.isHidden = false
        case 1:
            sourceView.countryName = country!
            sourceView.triggerSource()
            sourceView.isHidden = false
            headlineView.isHidden = true
        default:
            break;
        }
        
    }
    
    private func triggerData(){
        
        APIManager.shared.getNews(forPage: increamentPage(), forCountry: country) { result in
            self.news += result
            DispatchQueue.main.async {
                self.headLineTable.reloadData()
            }
        }
    }
    
    private func triggerSearch(_ seach:String){
        
        APIManager.shared.getSearch(forText: seach){ result in
            self.news += result
            DispatchQueue.main.async {
                self.headLineTable.reloadData()
            }
        }
    }

}

extension HeadlineVC: UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabChanged = true
    }
}

extension HeadlineVC: UISearchBarDelegate{
    
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchQueryText = searchBar.text!
        searchBar.endEditing(true)
        
        
        news.removeAll()
        triggerSearch(searchQueryText)
        hideKeyboard()
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Enter a search phrase"
            return false
        }
    }
}

extension HeadlineVC : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        
        if pos > headLineTable.contentSize.height-100-scrollView.frame.size.height{
//            if tabSeleted == 0 { triggerData() }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // To display the actual html of the story
        let path = news[indexPath.row].url
        
        let vc = SFSafariViewController(url: getWebPage(from: path))
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getWebPage(from url: String)-> URL {
        var comps = URLComponents(string: url)!
        comps.scheme = "https"
        let https = comps.string!
        let toURL = URL(string: https)
        return toURL!
    }
    
}
