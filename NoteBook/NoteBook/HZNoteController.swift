//
//  HZNoteController.swift
//  NoteBook
//
//  Created by chris on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit
import Social

class HZNoteController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "item"
        
        view.backgroundColor = UIColor.whiteColor()
        let leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: "back")
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let righBarButtonItem = UIBarButtonItem(title: "分享", style: .Plain, target: self, action: "share")
        navigationItem.rightBarButtonItem = righBarButtonItem;
        
        
        let textProperties = [NSFontAttributeName:UIFont.systemFontOfSize(14),NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        leftBarButtonItem.setTitleTextAttributes(textProperties, forState: .Normal)
        righBarButtonItem.setTitleTextAttributes(textProperties, forState: .Normal)
        
        
        setUpUI()
        

    }
    
    func setUpUI(){
        
       let toolBar = UIToolbar()
        let item1 = UIBarButtonItem(title: "图片", style: .Plain, target: self, action: Selector("insetPicture"))
       
        
        let item2 = UIBarButtonItem(title: "语音", style: .Plain, target: self, action: Selector("insetPicture"))
        
        let item3 = UIBarButtonItem(title: "导入文件", style: .Plain, target: self, action: Selector("insetPicture"))
        
        let item4 = UIBarButtonItem(title: "百度", style: .Plain, target: self, action: Selector("insetPicture"))
        
        toolBar.items = [item1,item2,item3,item4]
        
        
        toolBar.frame = CGRectMake(100, 100, 100, 100)
        view.addSubview(toolBar)
        
    }
    
    
///左右按钮点击事件
    func back(){
        navigationController?.popViewControllerAnimated(true)
    }

    func share(){
        if(SLComposeViewController.isAvailableForServiceType(SLServiceTypeSinaWeibo)){
            let shareVc = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
            
                       
            shareVc.addURL(NSURL(string: "http://www.baidu.com"))
            
            shareVc.view.backgroundColor = UIColor.whiteColor()
            presentViewController(shareVc, animated: true, completion: nil)
            
        }
        
        
    }

}
