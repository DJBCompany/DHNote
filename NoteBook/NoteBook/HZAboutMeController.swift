//
//  HZAboutMeController.swift
//  NoteBook
//
//  Created by chris on 16/4/27.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZAboutMeController: UITableViewController {

    var modelArray: [String]? = {
         let modelArray = ["个人详情", "修改密码", "修改密码找回问题答案", "云同步"]
        return modelArray
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeaderView()
        // 设置内容
        setUpCell()
    }
    func setUpCell() {
        tableView.rowHeight = 60
    }
    
    func setUpHeaderView() {
        let headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 180))
        headerView.backgroundColor = UIColor.greenColor()
        tableView.tableHeaderView = headerView
        let iconImageView: UIImageView = UIImageView()
        headerView.addSubview(iconImageView)
        iconImageView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(headerView)
            make.height.width.equalTo(100)
        }
        iconImageView.backgroundColor = UIColor.redColor()
        iconImageView.image = UIImage(named: "me")
        iconImageView.layer.cornerRadius =  50
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.borderColor = UIColor.whiteColor().CGColor
        tableView.tableFooterView = UIView()
        
        // 姓名
        let nameLabel: UILabel = UILabel()
        headerView.addSubview(nameLabel)
        nameLabel.text = "丶小孩丿"
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageView.snp_bottom).offset(10);
            make.centerX.equalTo(iconImageView)
        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HZMeTableViewCell = HZMeTableViewCell.meTableViewCell(tableView)
        let contentString = modelArray![indexPath.row]
        cell.contentString = contentString
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }


}
