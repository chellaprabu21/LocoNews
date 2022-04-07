//
//  TabBarController.swift
//  LocoNews
//
//  Created by Chellaprabu V on 06/04/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        changeAttibutes()
        // Do any additional setup after loading the view.
    }
    
    func changeAttibutes(){
        guard let viewControllers = self.viewControllers else{
            return
        }
        for (index,viewController) in viewControllers.enumerated() {
            switch index{
            case 0:
                viewController.tabBarItem.title = "Headlines"
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
            case 1:
                viewController.tabBarItem.title = "Contries"
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
            case 2:
                viewController.tabBarItem.title = "Search"
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
            default:
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
