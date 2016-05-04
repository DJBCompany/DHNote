//
//  HZNoteCell.swift
//  NoteBook
//
//  Created by chris on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZNoteCell: UITableViewCell {
    
    
    var dic:[String:NSObject]?{
        didSet{
            contentLb.text = dic!["content"] as? String
            
            timeLb.text = dic!["time"] as? String
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
        backgroundColor = UIColor(red: CGFloat(random()%256) / 255.0, green: CGFloat(random()%256) / 255.0, blue: CGFloat(random()%256) / 255.0, alpha: 1.0)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        contentView.addSubview(contentLb)
        contentView.addSubview(timeLb)
        
        ///添加约束
        contentLb.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top).offset(10)
            make.left.equalTo(contentView.snp_left).offset(10)
            make.width.equalTo(280)
            make.bottom.equalTo(contentView.snp_bottom)
        }
        
        timeLb.snp_makeConstraints { (make) -> Void in
           make.right.equalTo(contentView.snp_right)
           make.bottom.equalTo(contentLb.snp_bottom)
        }
        
        
    }
    
    lazy var contentLb:UILabel = {
       let lb = UILabel()
       lb.numberOfLines = 0
       return lb
    }()
    
    lazy var timeLb:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFontOfSize(12)
        return lb
    }()

}
