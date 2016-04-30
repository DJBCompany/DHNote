//
//  HZClassViewController.swift
//  NoteBook
//
//  Created by chris on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZClassViewController: UIViewController {
    
    
    var classclosure:((className:String)->())?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.whiteColor()
        
        setUpUI()
    }

    func setUpUI(){
       view.addSubview(classTextField)
        
      view.addSubview(submitBtn)
        
       classTextField.snp_makeConstraints { (make) -> Void in
          make.top.equalTo(view.snp_top).offset(200)
          make.right.equalTo(view.snp_right).offset(-20)
          make.left.equalTo(view.snp_left).offset(20)
        }
        
       submitBtn.snp_makeConstraints { (make) -> Void in
          make.top.equalTo(classTextField.snp_bottom).offset(40)
          make.centerX.equalTo(view.snp_centerX)
          
        }
        
        
    }
    
    lazy var classTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入分类名"
        return textField
    }()
    
    
    lazy var submitBtn:UIButton = {
         let btn = UIButton()
         btn.setTitle("submit", forState:.Normal)
         btn.backgroundColor = UIColor.redColor()
         btn.addTarget(self, action:Selector("submit"), forControlEvents: .TouchUpInside)
        return btn
    }()
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        classTextField.resignFirstResponder()
    }
    
    
    func submit(){
        
        classTextField.resignFirstResponder()
        
        classclosure?(className: classTextField.text!)
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }

}
