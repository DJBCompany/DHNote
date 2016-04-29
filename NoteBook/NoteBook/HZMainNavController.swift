//
//  HZMainNavController.swift
//  NoteBook
//
//  Created by chris on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZMainNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.redColor()
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   ///重写push方法隐藏tabBar  
    override func pushViewController(vc: UIViewController, animated: Bool) {
        
        
        super.pushViewController(vc, animated: animated)
          if (vc == childViewControllers[0]){
            vc.hidesBottomBarWhenPushed = false
        }else{
            vc.hidesBottomBarWhenPushed = true
        }
    
//        if(childViewControllers.count == 1){
//            viewController.hidesBottomBarWhenPushed = false
//        }else{
//            viewController.hidesBottomBarWhenPushed = true
//        }
    }
    
    override func showViewController(vc: UIViewController, sender: AnyObject?) {
        vc.hidesBottomBarWhenPushed = true
        super.showViewController(vc, sender: sender)
    }

}
