//
//  HZInfoViewController.swift
//  NoteBook
//
//  Created by DH on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZInfoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeaderView()
        modelDict = ["school":"天津科技大学", "number":"12031001"]
    }
    
    var modelDict: [String:String]?
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFontOfSize(20)
        return nameLabel
    }()
    
    // 设置headerView
    func setUpHeaderView() {
        let headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 100))
        headerView.backgroundColor = UIColor.greenColor()
        tableView.tableHeaderView = headerView
        let iconImageView: UIImageView = UIImageView()
        headerView.addSubview(iconImageView)
        iconImageView.snp_makeConstraints { (make) -> Void in
//            make.center.equalTo(headerView)
            make.right.equalTo(headerView).offset(-10)
            make.height.width.equalTo(60)
            make.centerY.equalTo(headerView)
        }
        iconImageView.backgroundColor = UIColor.redColor()
        iconImageView.image = UIImage(named: "me")
        iconImageView.layer.cornerRadius =  30
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.borderColor = UIColor.whiteColor().CGColor
        tableView.tableFooterView = UIView()
        
        headerView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(headerView).offset(20)
            make.centerY.equalTo(headerView)
        }
        // 从本地沙盒中取
        let UserPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
        let filePath = (UserPath! as NSString).stringByAppendingPathComponent("userInfo.plist")
        let infoModel: HZInfoModel? = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? HZInfoModel
        nameLabel.text = infoModel?.username
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = HZInfoTableViewCell.infoTableViewCell(tableView)
        if indexPath.row == 0 {
            cell.label1String = "学校"
            cell.label2String = "天津科技大学"
        }
        if indexPath.row == 1 {
            cell.label1String = "学号"
            cell.label2String = "120319101"
        }
        return cell
    }
    
}
