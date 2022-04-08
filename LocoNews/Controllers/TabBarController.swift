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
                viewController.navigationController?.navigationBar.topItem?.title = "Headlines"
                viewController.tabBarItem.tag = 0
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
            case 1:
                viewController.tabBarItem.title = "Contries"
                viewController.navigationController?.navigationBar.topItem?.title = "Countries"
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                viewController.tabBarItem.tag = 1
            case 2:
                viewController.tabBarItem.title = "Search"
                viewController.navigationController?.navigationBar.topItem?.title = "Search"
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                viewController.tabBarItem.tag = 2
            default:
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
            }
        }
    }
}


