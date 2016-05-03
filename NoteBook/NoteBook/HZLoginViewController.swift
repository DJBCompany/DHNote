//
//  HZLoginViewController.swift
//  NoteBook
//
//  Created by DH on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit
import SVProgressHUD
class HZLoginViewController: UIViewController {
    
    // 定义一个闭包属性
    var loginBtnDidSuccessClourse: (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    // 监听登录按钮的点击
    @IBAction func loginBtnDidClick(sender: AnyObject) {
        if (passwordField.text != "" && usernameField.text != "") {
            // 从本地沙盒中取
            let UserPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
            let filePath = (UserPath! as NSString).stringByAppendingPathComponent("userInfo.plist")
            let infoModel: HZInfoModel? = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? HZInfoModel
            if ((usernameField.text == infoModel?.username) && passwordField.text == infoModel?.password) {
//                SVProgressHUD.showInfoWithStatus("")
                // 跳转到下一个控制器
//                let mianVc = HZMainTabBarController()
                // 切换根控制器
//                if loginBtnDidSuccessClourse != nil {
//                    loginBtnDidSuccessClourse!()
//                }
                // 发出一个通知
                NSNotificationCenter.defaultCenter().postNotificationName("LoginVCSuccessNotification", object: self)
                
            } else {
                SVProgressHUD.showErrorWithStatus("用户名或密码错误")
            }
            
            
        } else {
            SVProgressHUD.showErrorWithStatus("请输入用户名或密码")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
