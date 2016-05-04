//
//  HZReachController.swift
//  NoteBook
//
//  Created by chris on 16/4/27.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit
import SVProgressHUD

class HZReachController: UIViewController,UISearchBarDelegate{
    
    var dayArr = ["in one day","in three day","in one week","in two weeks","in one month","in two month"]
    
    var oneDay = [[String:NSObject]]()
    var threeDay = [[String:NSObject]]()
    var oneWeek = [[String:NSObject]]()
    var twoWeek = [[String:NSObject]]()
    var oneMonth = [[String:NSObject]]()
    var twoMonth = [[String:NSObject]]()
    
    var dataArr:[[String:NSObject]]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(self.getDocumentPath()) as? [[String:NSObject]]
    }
    
    let searchBar = UISearchBar();
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        searchBar.placeholder = "搜索"
        searchBar.delegate = self
        setUpUI()
        view.backgroundColor = UIColor.whiteColor()
        
        
    }
    
    
    func setUpUI(){
        
        
        creatDayView()
        
        
    }
    func creatDayView(){
        
      view.addSubview(dayView)
        
     dayView.frame = CGRectMake(0, 64, ScreenW, 44 * 3)
        for(index,value) in dayArr.enumerate(){
            print(value)
            let btn = UIButton()
            btn.tag = index
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.greenColor().CGColor
            btn.setTitle(value, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            dayView.addSubview(btn)
            btn.addTarget(self, action: "searchForDay:", forControlEvents: UIControlEvents.TouchUpInside)
            btn.frame = CGRectMake(CGFloat(index / 3) * ScreenW * 0.5,CGFloat(index % 3) * 44,ScreenW * 0.5 , 44 )
        }
        
       view.addSubview(classView)
        
        if (dataArr?.count != nil){
       let  count  = CGFloat(((dataArr?.count)!) + 1) / 2
        
       print(count)
        
       classView.frame = CGRectMake(0, 44 * 3 + 20 + 64, ScreenW, count * 44)
        
        for(index,dict) in dataArr!.enumerate(){
            let btn = UIButton()
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.greenColor().CGColor
            btn.setTitle(dict["header"] as? String, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            classView.addSubview(btn)
            btn.addTarget(self, action: "searchForClass:", forControlEvents: UIControlEvents.TouchUpInside)
            btn.frame = CGRectMake(CGFloat(index / 2) * ScreenW * 0.5,CGFloat(index % 2) * 44,ScreenW * 0.5 , 44 )
        }

        }
    }
    
    lazy var dayView:UIView = {
      let dv = UIView()
      return dv
    }()
    
    lazy var classView:UIView = {
        let cv = UIView()
        return cv
        
    }()
    

    ///键盘失去第一响应者
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        (navigationItem.titleView as! UISearchBar).resignFirstResponder()
    }
    ///按照时间查询
    func searchForDay(sender:UIButton){
        for dict in dataArr!{
        let subDataArr = dict["data"] as! [[String:NSObject]]
            for subDict in subDataArr{
                let timeStr = subDict["time"]
                let formattor = NSDateFormatter()
                formattor.dateFormat = "yyyy:MM:dd HH:mm"
                let noteDate = formattor.dateFromString(timeStr as! String)
                
                //获取当前日历
                let cal = NSCalendar.currentCalendar()
                
                //设置要获取的比较
                let unites = NSCalendarUnit(arrayLiteral: .Month,.Day)
                
                let compts = cal.components(unites, fromDate: noteDate!, toDate: NSDate(), options: [])
                
                if compts.day == 1 {
                    oneDay.append(subDict)
                }
                if compts.day <= 3{
                    threeDay.append(subDict)
                }
                if compts.day <= 7{
                    oneWeek.append(subDict)
                }
                if compts.day <= 14{
                    twoWeek.append(subDict)
                }
                if compts.month <= 1{
                    oneMonth.append(subDict)
                }
                if compts.month <= 2{
                    twoMonth.append(subDict)
                }
            }
        }
        let detailVc = HZDetailController()
        let chooseTitle = sender.currentTitle as! NSString
        if chooseTitle.isEqualToString("in one day"){
           detailVc.subDataArr = oneDay
        }
        if chooseTitle.isEqualToString("in three day"){
            detailVc.subDataArr = threeDay
        }
        if chooseTitle.isEqualToString("in one week"){
            detailVc.subDataArr = oneWeek
        }
        if chooseTitle.isEqualToString("in two weeks"){
            detailVc.subDataArr = twoWeek
        }
        if chooseTitle.isEqualToString("in one month"){
            detailVc.subDataArr = oneMonth
        }
        if chooseTitle.isEqualToString("in two month"){
            detailVc.subDataArr = twoMonth
        }

     //navigationController?.showDetailViewController(detailVc, sender: nil)

        navigationController?.showViewController(detailVc, sender: nil)
        
    }
    
    ///按照分类查询
    func getDocumentPath()-> String{
        let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
        return (documentPath! as NSString).stringByAppendingPathComponent("note")
    }

    
    func searchForClass(sender:UIButton){
        let detailVc = HZDetailController()
        detailVc.title = sender.currentTitle!
        for dict in dataArr!{
            let header = dict["header"] as! NSString
            if header.isEqualToString(sender.currentTitle!) {
                let subDataArr = dict["data"]
                detailVc.subDataArr = subDataArr as? [[String:NSObject]]
            }
        }
       navigationController?.showViewController(detailVc, sender: nil)
}
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        SVProgressHUD.showErrorWithStatus("正在拼命查询中")
        searchBar.resignFirstResponder()
        searchBar.text = nil

    }
    
}
