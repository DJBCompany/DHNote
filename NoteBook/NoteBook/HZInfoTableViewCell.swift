//
//  HZInfoTableViewCell.swift
//  NoteBook
//
//  Created by DH on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZInfoTableViewCell: UITableViewCell {


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .DisclosureIndicator
    }
    
    var label1String: String? {
        didSet{
            textLabel?.text = label1String
        }
    }
    
    var label2String: String? {
        didSet {
            detailTextLabel?.text = label2String
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 快速创建一个cell
    class func infoTableViewCell(tableView: UITableView) ->HZInfoTableViewCell {
        
        let ID: String = "info"
        var cell: HZInfoTableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID) as? HZInfoTableViewCell
        if cell == nil {
            cell = HZInfoTableViewCell(style: .Value1, reuseIdentifier: ID)
        }
        return cell!
    }
}
