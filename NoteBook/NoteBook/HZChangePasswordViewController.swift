//
//  HZChangePasswordViewController.swift
//  NoteBook
//
//  Created by DH on 16/5/3.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit
import SVProgressHUD

class HZChangePasswordViewController: UIViewController {

    var oldPasswordField: UITextField?
    var nowPassword1Field: UITextField?
    var nowPassword2Field: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        let oldPasswordField = UITextField()
        self.oldPasswordField = oldPasswordField
        oldPasswordField.borderStyle = .RoundedRect
        oldPasswordField.placeholder = "请输入原来的密码"
        view.addSubview(oldPasswordField)
        
        oldPasswordField.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(100)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        let nowPassword1Field = UITextField()
        self.nowPassword1Field = nowPassword1Field
        nowPassword1Field.borderStyle = .RoundedRect
        nowPassword1Field.placeholder = "请输入新密码"
        view.addSubview(nowPassword1Field)
        nowPassword1Field.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(oldPasswordField.snp_bottom).offset(30)
            make.centerX.equalTo(oldPasswordField)
            make.width.equalTo(oldPasswordField)
        }
        let nowPassword2Field = UITextField()
        self.nowPassword2Field = nowPassword2Field
        nowPassword2Field.borderStyle = .RoundedRect
        nowPassword2Field.placeholder = "请重新输入新密码"
        view.addSubview(nowPassword2Field)
        nowPassword2Field.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nowPassword1Field.snp_bottom).offset(30)
            make.centerX.equalTo(oldPasswordField)
            make.width.equalTo(oldPasswordField)
        }
        let sureBtn = UIButton()
        sureBtn.layer.cornerRadius = 5
        sureBtn.layer.masksToBounds = true
        sureBtn.backgroundColor = UIColor.greenColor()
        view.addSubview(sureBtn)
        sureBtn.setTitle("确定", forState: .Normal)
        sureBtn.addTarget(self, action: "sureBtnDidClick", forControlEvents: .TouchUpInside)
        sureBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nowPassword2Field.snp_bottom).offset(30)
            make.centerX.equalTo(nowPassword2Field)
            make.width.equalTo(100)
        }
    }
    func sureBtnDidClick() {
        // 取出本地缓存密码
        // 从本地沙盒中取
        let UserPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
        let filePath = (UserPath! as NSString).stringByAppendingPathComponent("userInfo.plist")
        let infoModel: HZInfoModel? = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? HZInfoModel
//        if infoModel?.password == oldPasswordField?.text && {
//            
//        }
        
        if infoModel?.password == oldPasswordField?.text && nowPassword2Field?.text != "" && nowPassword1Field?.text != "" && nowPassword1Field?.text == nowPassword2Field?.text {
            // 修改成功
            SVProgressHUD.showSuccessWithStatus("修改成功")
            infoModel?.password = nowPassword2Field?.text
            
            // 存进沙盒
            let UserPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
            let filePath = (UserPath! as NSString).stringByAppendingPathComponent("userInfo.plist")
            NSKeyedArchiver.archiveRootObject(infoModel!, toFile: filePath)
            navigationController?.popViewControllerAnimated(true)
        } else {
            SVProgressHUD.showErrorWithStatus("信息有误")
        }
        
    }
}
