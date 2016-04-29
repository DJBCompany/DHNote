//
//  HZCategoryController.swift
//  NoteBook
//
//  Created by chris on 16/4/27.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZCategoryController: UITableViewController {
    var sectionArr = ["默认"]
    
    var dataArr = [[String:NSObject]]()
    
    var isHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "分类"
      
        let leftBarButtonItem = UIBarButtonItem(title: "新建", style: .Plain, target: self, action: "new")
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let righBarButtonItem = UIBarButtonItem(title: "编辑", style: .Plain, target: self, action: "edit")
        navigationItem.rightBarButtonItem = righBarButtonItem;
        
        
        let textProperties = [NSFontAttributeName:UIFont.systemFontOfSize(14),NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        leftBarButtonItem.setTitleTextAttributes(textProperties, forState: .Normal)
        righBarButtonItem.setTitleTextAttributes(textProperties, forState: .Normal)

        tableView.registerClass(HZNoteCell.self, forCellReuseIdentifier: "cell")
    }
    
    
///按钮点击事件
    func new(){
        if(!isHidden){
            self.navigationController?.view.addSubview(popView)
            
    
        }else{
            popView.removeFromSuperview()
        }
        isHidden = !isHidden
    }
    
    
    func edit(){
        
        print("编辑")
        
        
    }
    
    
///懒加载popView
    lazy var popView:UIView = {
        let popView = UIView()
        popView .removeFromSuperview()
        popView.frame = CGRectMake(0, 64, 150, 80);
        
        
        let btn1 = UIButton()
        btn1.backgroundColor = UIColor.greenColor()
        btn1.setTitle("item", forState: .Normal)
        btn1.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn1.frame = CGRectMake(0, 0,popView.bounds.width , popView.bounds.height*0.5)
        popView.addSubview(btn1)
        btn1.addTarget(self, action: Selector("addItem"), forControlEvents: .TouchUpInside)
        
        
        let btn2 = UIButton()
        btn2.backgroundColor = UIColor.greenColor()
        btn2.setTitle("class", forState: .Normal)
        btn2.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn2.frame = CGRectMake(0, popView.bounds.height*0.5,popView.bounds.width , popView.bounds.height*0.5)
        popView.addSubview(btn2)
        btn2.addTarget(self, action: Selector("addClass"), forControlEvents: .TouchUpInside)
        

        
        let seperatorView1 = UIView()
        seperatorView1.frame = CGRectMake(0, popView.bounds.height*0.5, popView.bounds.width, 1)
        seperatorView1.backgroundColor = UIColor.grayColor()
        popView.addSubview(seperatorView1)
        
        let seperatorView2 = UIView()
        seperatorView2.frame = CGRectMake(0, popView.bounds.height, popView.bounds.width, 1)
        seperatorView2.backgroundColor = UIColor.grayColor()
        popView.addSubview(seperatorView2)

        let seperatorView3 = UIView()
        seperatorView3.frame = CGRectMake(popView.bounds.width-1, 0, 1 ,  popView.bounds.height)
        seperatorView3.backgroundColor = UIColor.grayColor()
        popView.addSubview(seperatorView3)

        
        return popView
    }()
    
///addItem点击事件
    func addItem(){
        let noteVc = HZNoteController()
        
        noteVc.noteClosure = { dic->() in
           self.dataArr.append(dic)
           self.tableView.reloadData()
        }
        
        navigationController?.showViewController(noteVc, sender: nil)

        new()
    }
    
    
    
    
///addClass点击事件
    func addClass(){
       print("2")
        
        
    }
    
    
    

}
extension HZCategoryController{

override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return sectionArr.count
}
override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataArr.count
}
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HZNoteCell
        
      
        cell.dic = dataArr[indexPath.row]
        
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArr[section]
    }
    
}



