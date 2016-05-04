//
//  HZChangeFindQuestionViewController.swift
//  NoteBook
//
//  Created by DH on 16/5/3.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZChangeFindQuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        // 从本地沙盒中取
        let UserPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
        let filePath = (UserPath! as NSString).stringByAppendingPathComponent("userInfo.plist")
        let infoModel: HZInfoModel? = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? HZInfoModel
        
        let questionLabel = UILabel()
        questionLabel.font = UIFont.systemFontOfSize(20)
        questionLabel.textAlignment = .Center
        if let text = infoModel?.findQuestion {
            questionLabel.text = text + "?"
        }
        view.addSubview(questionLabel)
        questionLabel.backgroundColor = UIColor.grayColor()
        questionLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(100)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.centerX.equalTo(view)
        }
        
        
    }
    

}
