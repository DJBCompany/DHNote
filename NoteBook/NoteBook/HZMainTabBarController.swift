//
//  HZMainTabBarController.swift
//  NoteBook
//
//  Created by chris on 16/4/27.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZMainTabBarController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let bar = HZTabBar()
        setValue(bar, forKey: "tabBar")
        addAllChildControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    ///添加所有的子控制器的方法
   func addAllChildControllers(){
    
    
        let categoryVc = HZCategoryController();
        addChildViewController(categoryVc, title: "Category", image: "")
    
         let reachVc = HZReachController()
         addChildViewController(reachVc, title: "Reach", image: "")
    
         let analysisVc = HZAnalysisController()
         addChildViewController(analysisVc, title: "Analysis", image: "")
    
         let meVc = HZAboutMeController()
         addChildViewController(meVc, title: "me", image: "")
    
    }
    ///添加子控制器
    func addChildViewController(childController: UIViewController, title:String, image:String) {
        let nav = HZMainNavController(rootViewController: childController)
        
        navigationItem.title = title
        
        addChildViewController(nav);
    }
    

    
}
