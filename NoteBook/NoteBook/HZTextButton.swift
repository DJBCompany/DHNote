//
//  HZTextButton.swift
//  NoteBook
//
//  Created by chris on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZTextButton: UIButton {
    
    var btnText :String?{
        didSet{
            
            textLb.text = btnText
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI(){
        
        
        addSubview(textLb)
        
    }
    
    lazy var textLb:UILabel =  {
       let lb = UILabel()
       lb.textAlignment = .Center
       lb.font = UIFont.systemFontOfSize(14)
       return lb
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLb.frame = self.bounds
    }
    
    
    
}
