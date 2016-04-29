//
//  HZPoperView.swift
//  NoteBook
//
//  Created by chris on 16/4/28.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZPoperView: UIView {
    //外部传过来的数据
    var dataArr:[String]?
    ///记录按钮
    var btn:UIButton = UIButton()
    
    
 /// 三部曲
    //1.重写init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //2.创建子控件
    func setUpUI(){
        print(bounds.size.height)
        
        for title in dataArr!{
            let titleBtn = UIButton()
            btn = titleBtn
            titleBtn.setTitle(title, forState: .Normal)
            titleBtn.backgroundColor = UIColor.redColor()
            
            addSubview(titleBtn)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnHeight = bounds.size.height / CGFloat(dataArr!.count)
        let btnWidth = bounds.size.width
        
        btn.frame = CGRectMake(0,CGFloat(dataArr!.count) * btnHeight,btnWidth , btnHeight)
        
        
        
    }
  
    
}
