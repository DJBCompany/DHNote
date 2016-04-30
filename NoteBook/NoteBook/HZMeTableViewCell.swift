//
//  HZMeTableViewCell.swift
//  NoteBook
//
//  Created by DH on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit
import SnapKit

class HZMeTableViewCell: UITableViewCell {
    
    // 内容
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textAlignment = .Center
        return contentLabel
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentLabel)
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(contentView)
        }
    }
    
    var contentString: String? {
        didSet{
            contentLabel.text = contentString
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 快速创建一个cell
    class func meTableViewCell(tableView: UITableView) ->HZMeTableViewCell {
        
        let ID: String = "me"
        var cell: HZMeTableViewCell? = (tableView.dequeueReusableCellWithIdentifier(ID) as? HZMeTableViewCell)
        if cell == nil {
            cell = HZMeTableViewCell(style: .Default, reuseIdentifier: ID)
        }
        return cell!
    }
}
