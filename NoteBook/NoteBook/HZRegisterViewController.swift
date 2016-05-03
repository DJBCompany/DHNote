//
//  HZRegisterViewController.swift
//  NoteBook
//
//  Created by DH on 16/4/30.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit
import SVProgressHUD

class HZRegisterViewController: UIViewController {

    @IBOutlet weak var findAnswerField: UITextField!
    @IBOutlet weak var findQuestionField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

   
    @IBAction func submitBtnDidClick(sender: AnyObject) {
        // 创建一个模型
        let infoModel = HZInfoModel()
        if (findAnswerField.text != "" && findQuestionField.text != "" && emailField.text != "" && usernameField.text != "" && passwordField.text != "") {
            infoModel.username = usernameField.text
            infoModel.password = passwordField.text
            infoModel.email = emailField.text
            infoModel.findQuestion = findQuestionField.text
            infoModel.findAnswer = findAnswerField.text
            let UserPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
            let filePath = (UserPath! as NSString).stringByAppendingPathComponent("userInfo.plist")
            NSKeyedArchiver.archiveRootObject(infoModel, toFile: filePath)
            navigationController?.popViewControllerAnimated(true)

        } else {
            SVProgressHUD.showErrorWithStatus("请输入完整信息")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
