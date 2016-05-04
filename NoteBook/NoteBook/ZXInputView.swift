//
//  ZXInputView.swift
//  ZXBlog
//
//  Created by chris on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import SnapKit
//MARK: --实现表情按钮与collection联动的协议
protocol ZXInputViewDelegate:NSObjectProtocol{
    
    func changteToselectedEmotion(whichType: selectedEmotionType)
}
///定义一个枚举
enum selectedEmotionType:Int{
    case recent = 0
    case defualt = 1
    case emoji = 2
    case lxh = 3
}

class ZXInputView: UIView {
    
    ///记录底部被点击的按钮
    var previousSelectedBtn:UIButton?
    ///底部表情按钮的代理
    weak var delegate:ZXInputViewDelegate?
    
    ///默认点击第一个 记录一下第一个按钮
    var recentBtn:UIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        changeEmotion(recentBtn!)
    
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUI(){
        
        if #available(iOS 9.0, *) {
            addSubview(footStackView)
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 9.0, *) {
            footStackView.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.snp_left)
                make.right.equalTo(self.snp_right)
                make.bottom.equalTo(self.snp_bottom)
                make.width.equalTo(44)
            }
        } else {
            // Fallback on earlier versions
        }
        addSubview(inputCollectionView)
        inputCollectionView.changeBtnType = {(sectionNum:Int)->() in
            if #available(iOS 9.0, *) {
                for (index,subView)  in self.footStackView.subviews.enumerate(){
                    if index == sectionNum {
                        // print("1")
                        let btn = subView as! UIButton
                        btn.selected = true
                    }
                    
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
        inputCollectionView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            if #available(iOS 9.0, *) {
               make.bottom.equalTo(footStackView.snp_top)
            } else {
                // Fallback on earlier versions
            }
            
        }
        
    }
    
  //MARK: --懒加载
    @available(iOS 9.0, *)
    lazy var footStackView:UIStackView = {
        let btn = UIButton()
        btn.setTitle("最近", forState: .Normal)
        btn.setBackgroundImage(UIImage(named:"compose_emotion_table_normal"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named:"compose_emotion_table_selected"), forState: .Selected)
        btn.addTarget(self, action: "changeEmotion:", forControlEvents: .TouchUpInside)
        btn.tag = selectedEmotionType.recent.rawValue
        self.recentBtn = btn
        
        let btn1 = UIButton()
        btn1.setTitle("默认", forState: .Normal)
        btn1.setBackgroundImage(UIImage(named:"compose_emotion_table_normal"), forState: .Normal)
        btn1.setBackgroundImage(UIImage(named:"compose_emotion_table_selected"), forState: .Selected)
        btn1.addTarget(self, action: "changeEmotion:", forControlEvents: .TouchUpInside)
        btn1.tag = selectedEmotionType.defualt.rawValue
        
        let btn2 = UIButton()
        btn2.setTitle("Emoji", forState: .Normal)
        btn2.setBackgroundImage(UIImage(named:"compose_emotion_table_normal"), forState: .Normal)
        btn2.setBackgroundImage(UIImage(named:"compose_emotion_table_selected"), forState: .Selected)
        btn2.addTarget(self, action: "changeEmotion:", forControlEvents: .TouchUpInside)
        btn2.tag = selectedEmotionType.emoji.rawValue
    
        let btn3 = UIButton()
        btn3.setTitle("浪小花", forState: .Normal)
        btn3.setBackgroundImage(UIImage(named:"compose_emotion_table_normal"), forState: .Normal)
        btn3.setBackgroundImage(UIImage(named:"compose_emotion_table_selected"), forState: .Selected)
        print(UIImage(named: "compose_emotion_table_selected"))
        btn3.addTarget(self, action: "changeEmotion:", forControlEvents: .TouchUpInside)
        btn3.tag = selectedEmotionType.lxh.rawValue
        
        let arr:[UIView] = [btn,btn1,btn2,btn3]
        
        let stack = UIStackView(arrangedSubviews: arr)
        
        stack.distribution = .FillEqually

       return stack
    }()

    lazy var  inputCollectionView:ZXInputCollectionView = ZXInputCollectionView()
    
    
   //MARK: --底部按钮的点击事件
    func changeEmotion(sender:UIButton){
        previousSelectedBtn?.selected = false
        sender.selected = true
        previousSelectedBtn = sender
        //将tag 转化为枚举类型
        if let type = selectedEmotionType(rawValue: sender.tag){
        //实现按钮与collection的联动
        delegate?.changteToselectedEmotion(type)
        }
    }
    

}
