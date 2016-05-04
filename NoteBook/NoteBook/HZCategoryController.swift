//
//  HZCategoryController.swift
//  NoteBook
//
//  Created by chris on 16/4/27.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZCategoryController: UITableViewController {
    
    
   ///默认数据
    
    var editingClick  = true
    var _allDataArr: [[String:NSObject]]?
   // var allDataArr: [[String:NSObject]] = [["header":"默认","data":[AnyObject]()]]
    
    

    var allDataArr:[[String:NSObject]]{
        get{
            if _allDataArr == nil {
                
                _allDataArr =  NSKeyedUnarchiver.unarchiveObjectWithFile(getDocumentPath()) as? [[String:NSObject]]
                
                if _allDataArr == nil {
                    
                    _allDataArr = [["header":"默认","data":[AnyObject]()]]
                }
                
            }
            return _allDataArr!
        }
        
        set {
            _allDataArr = newValue
        }
        
        
    }
    

    var isHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "分类"
      
        let leftBarButtonItem = UIBarButtonItem(title: "新建", style: .Plain, target: self, action: "new")
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightBtn = UIButton()
        rightBtn.setTitle("编辑", forState: .Normal)
        rightBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        rightBtn.addTarget(self, action: Selector("edit"), forControlEvents: .TouchUpInside)
        rightBtn.sizeToFit()
        let righBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
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
        
        if(editingClick){
        tableView.editing = true
        }else{
            tableView.editing = false
        }
        editingClick = !editingClick
        
        
}
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        var dic1 = allDataArr[sourceIndexPath.section]
        
        var tempArr1 = dic1["data"] as! [AnyObject]
        
        let note = tempArr1[sourceIndexPath.row]
        
        tempArr1.removeAtIndex(sourceIndexPath.row)
        
        allDataArr[sourceIndexPath.section]["data"] = tempArr1
        
       var dic2 = allDataArr[destinationIndexPath.section]
       
       var tempArr2 = dic2["data"] as! [AnyObject]
        
      tempArr2.insert(note, atIndex: destinationIndexPath.row)
       

       allDataArr[destinationIndexPath.section]["data"] = tempArr2
        
       self.saveToLocation()
     //self.tableView.reloadData()

        
        
    }
    
    override func tableView(tableView: UITableView, var commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        editingStyle = UITableViewCellEditingStyle.Delete
        
       var dic = allDataArr[indexPath.section]
        
       var tempArr = dic["data"] as! [AnyObject]
        
       tempArr.removeAtIndex(indexPath.row)
        
        allDataArr[indexPath.section]["data"] = tempArr
        
        self.saveToLocation()
        
        self.tableView.reloadData()

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

func addClass(){
    
    let classVc = HZClassViewController()
    
    classVc.classclosure = {(dic:[String:NSObject])->() in
     self.allDataArr.append(dic)
    
     self.saveToLocation()
     self.tableView.reloadData()
        
    }
    presentViewController(classVc, animated: true, completion: nil)
    
    new()
    
}
    
func addItem(){
    let noteVc = HZNoteController()
    
    
    if(tableView.editing == true){
        tableView.editing = false
    }
    
    noteVc.noteClosure = {(dict:[String:NSObject])->() in
        var dic = self.allDataArr[0]
        
        var dataArr = dic["data"] as! [[String:NSObject]]
        dataArr.append(dict)
        
    
        
        self.allDataArr[0]["data"] = dataArr
        
        self.saveToLocation()
       
        self.tableView.reloadData()
    }
    
    navigationController?.showViewController(noteVc, sender: nil)
    
    
    new()
}
    
    
    func getDocumentPath()-> String{
        let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
        return (documentPath! as NSString).stringByAppendingPathComponent("note")
    }
    
    func saveToLocation(){
        NSKeyedArchiver.archiveRootObject(allDataArr, toFile: getDocumentPath())
    }

}

extension HZCategoryController{
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return allDataArr.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let dict = allDataArr[section]
        let dataArr = dict["data"] as! [[String:NSObject]]
        return dataArr.count
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dict = allDataArr[section]
        return dict["header"] as? String
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HZNoteCell
        
        let dic = allDataArr[indexPath.section] 
        let dataArr = dic["data"] as! [[String:NSObject]]
        let rowDic = dataArr[indexPath.row]
        cell.dic =  rowDic
        
        return cell
        
       
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       let contentVc = HZContentController()
        
        
        let dic = allDataArr[indexPath.section]
        var dataArr = dic["data"] as! [[String:NSObject]]
        let rowDic = dataArr[indexPath.row]
        
        contentVc.dic = rowDic
        
        contentVc.reloadClourse = {(dic:[String:NSObject])->() in
        
            
            dataArr[indexPath.row] = dic
            
            self.allDataArr[indexPath.section]["data"] = dataArr
            
            self.saveToLocation()
            
            self.tableView.reloadData()
        
        }
        
       navigationController?.showViewController(contentVc, sender: nil)
        
    }
    
    
    
    
}
