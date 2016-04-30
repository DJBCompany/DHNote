//
//  HZNoteController.swift
//  NoteBook
//
//  Created by chris on 16/4/29.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit
import Social
import SVProgressHUD


class HZNoteController: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZXInputViewDelegate{
    
   // var noteClosure:((content:String,time:String)->())?
    
    var noteClosure:(([String:NSObject])->())?
    
    let screenH = UIScreen.mainScreen().bounds.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setNav()
        setUpUI()
        sutUpToolBar()
        //监听键盘
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeToolFrame:", name: UIKeyboardWillChangeFrameNotification, object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:
            "writeEmotion:", name: "writeEmotion", object: nil)
    }
    ///写入表情
    func writeEmotion(info:NSNotification){
        let dic =  info.userInfo
        let emotion = dic!["emotion"] as! ZXEmotion
        if let png = emotion.png {
            //获取当前textView上的内容
            let textViewAttributeStr = NSMutableAttributedString(attributedString: textView.attributedText)
            //获取png的绝对路径
            let imgPath = emotion.packagePath! + "/\(png)"
            let img = UIImage(named: imgPath)
            //自定义attachment
            let attachMent = ZXAttachment()
            attachMent.emotion = emotion
            attachMent.image = img
            let lineHeight = textView.font!.lineHeight
            //设置图片的bounds
            attachMent.bounds = CGRectMake(0, -5, lineHeight, lineHeight)
            let attributeStr = NSAttributedString(attachment: attachMent)
            let range = textView.selectedRange
            textViewAttributeStr.insertAttributedString(attributeStr, atIndex: range.location)
            
            
            let mutaleAttributeStr = NSMutableAttributedString(attributedString: textViewAttributeStr)
            
            textView.attributedText = mutaleAttributeStr
            //赋值后得改变光标的位置
            textView.selectedRange.location = range.location + 1
        }
        if let emoji = emotion.emoji{
            //获取当前textView上的内容
            let textViewAttributeStr = NSMutableAttributedString(attributedString: textView.attributedText)
            let attritibuteStr = NSAttributedString(string: emoji)
            let range = textView.selectedRange
            //设置文字的大小
            textViewAttributeStr.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(16)], range: NSMakeRange(0, textViewAttributeStr.length))
            
            textViewAttributeStr.replaceCharactersInRange(NSMakeRange(range.location, 0), withAttributedString: attritibuteStr)
            textView.attributedText = textViewAttributeStr
        }
        //代理调用textViewDidChange
        textView.delegate?.textViewDidChange!(textView)
    }
    
    
    
    //响应键盘事件方法
    func changeToolFrame(keyboardInfo:NSNotification){
        //键盘停止时的frame
        let keyBounce = keyboardInfo.userInfo!["UIKeyboardBoundsUserInfoKey"]!.CGRectValue
        let keyH = keyBounce.height
        let rect =  keyboardInfo.userInfo!["UIKeyboardFrameEndUserInfoKey"]!.CGRectValue
        
        if rect.origin.y == screenH {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.toolBar.transform = CGAffineTransformIdentity
            })
            
        }else{
            UIView.animateWithDuration(0.25, animations: { () -> Void in
            })
            self.toolBar.transform = CGAffineTransformTranslate(self.toolBar.transform, 0, -keyH)
        }
    }
    
    
    
    
    func setNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: "disMissVc")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: "save")
        navigationItem.rightBarButtonItem?.enabled = false
        
    }
    ///Mark--导航栏按钮点击事件按钮点击事件
    func disMissVc(){

        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    func save(){
       let date = NSDate()
       let formattor = NSDateFormatter()
       formattor.dateFormat = "yyyy:MM:dd HH:mm"
       let time = formattor.stringFromDate(date)
        
      let dic = ["time":time,"content":getTextViewStr()]
        
       noteClosure?(dic)
        
      navigationController?.popViewControllerAnimated(true)
    }
    
    
    ///设置主界面
    func setUpUI(){
        view.addSubview(textView)
        textView.frame = view.frame
        textView.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(textView.snp_center)
            make.width.equalTo(ScreenW - 2*albumMargin)
            make.height.equalTo(collectionView.snp_width)
        }
        // print(collectionView.frame)
        
    }
    ///懒加载textView
    lazy var textView:ZXTextView = {
        let txtVw = ZXTextView()
        txtVw.placeHolder = "凛冬将至"
        txtVw.delegate = self
        //滑动让键盘消失
        //设置垂直滚动
        txtVw.alwaysBounceVertical = true
        //滑动消失
        txtVw.keyboardDismissMode = .OnDrag
        //设置font
        txtVw.font = UIFont.systemFontOfSize(16)
        return txtVw
    }()
    ///懒加载CollectionView
    lazy var collectionView:ZXAlbumCollectionView = {
        let collcetVw = ZXAlbumCollectionView()
        //MARK: --添加图片 闭包的循环引用
        collcetVw.addPhotoClosure = { [weak self] ()->() in
            self?.choosePicture()
        }
        collcetVw.backgroundColor = UIColor.greenColor()
        return collcetVw
    }()
    ///textView的代理方法
    func textViewDidChange(textView: UITextView) {
        //如果没有内容就显示占位符
        
        textView.hasText() ? (self.textView.placeHolder = "") :
            (self.textView.placeHolder = "凛冬将至,")
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        //重绘 一定要重绘否则不会改变
        self.textView.setNeedsDisplay()
    }
    
    //设置底部工具栏
    func sutUpToolBar(){
        view.addSubview(toolBar)
        toolBar.frame = CGRectMake(0, screenH-44, ScreenW, 44)
    }
    lazy var toolBar:UIToolbar = {
        let tlBar = UIToolbar()
        let itemSettings = [["title": "相册", "action": "choosePicture"],
            ["title": "百度", "action": "goBaidu"],
            ["title": "分享","action":"share"],
            ["title": "表情", "action": "inputEmoticon"]]
        var items = [UIBarButtonItem]()
        for dic in itemSettings{
            let item = HZTextButton(type: .Custom)
            
            //添加点击事件
            if let action =  dic["action"]{
                
                item.addTarget(self, action:Selector(action), forControlEvents: .TouchUpInside)
            }
            
            
            item.btnText = dic["title"]
            //设置按钮大小 不能少
            item.sizeToFit()
            items.append(UIBarButtonItem(customView: item))
            //添加弹簧
            let spring = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            items.append(spring)
        }
        //移除最后一个弹簧
        items.removeLast()
        tlBar.items = items
        return tlBar
    }()
    
    
    //MARK: -- 按钮点击事件
    func choosePicture(){
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
            //有权访问相册
            let picker = UIImagePickerController()
            presentViewController(picker, animated: true, completion: nil)
            //同时实现两个协议才能成为代理
            picker.delegate = self
            
            
            
        }else{
            //无权访问相册
            print("无权访问相册")
        }
    }
    //表情按钮
    func inputEmoticon(){
        //textView.inputView = nil
        textView.resignFirstResponder()
        //弹出表情键盘 让textView成为第一响应者
        if textView.inputView == nil {
            textView.inputView = testInputView
        } else{
            textView.inputView = nil
        }
        textView.becomeFirstResponder()
        //自定义键盘
    }
    
    
    ///百度
    func goBaidu(){
        let url = NSURL(string: "https://www.baidu.com")
        UIApplication.sharedApplication().openURL(url!)
        
    }
    
        deinit{
        print("vc 88")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "writeEmotion", object: nil)
    }
    
    //分享按钮
    func share(){
        
        if(textView.hasText() == false){
            SVProgressHUD .showErrorWithStatus("分享内容不能为空")
            return
        }
        
        
        if(SLComposeViewController.isAvailableForServiceType(SLServiceTypeSinaWeibo)){
            
            textView.resignFirstResponder()
            
            
            let shareVc = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
            
            shareVc.setInitialText(getTextViewStr())
            
            presentViewController(shareVc, animated: true, completion: nil)
            
            
            textView.text = nil
            
        }
        
    }
   ///获取textview上的文字
    func getTextViewStr()->String{
                    var  textViewStr = ""
                    textView.attributedText.enumerateAttributesInRange(NSMakeRange(0, textView.attributedText.length), options: []) { (data:[String:AnyObject], range:NSRange, _ ) -> Void in
                        //遍历textView
                        if let attachment = data["NSAttachment"] as? ZXAttachment{
                            //获取png 对应的chs 字符串
                            textViewStr += attachment.emotion?.chs ?? ""
                        }else{
                            //截取range范围内的字符串
                            let subStr = (self.textView.text as NSString).substringWithRange(range)
        
                            textViewStr += subStr
                        }
                        
                    }

        return textViewStr
    }
    
    
    ///测试键盘的inputView
    lazy var testInputView:ZXInputView = {
        let textVw = ZXInputView()
        textVw.delegate = self
        textVw.bounds.size = CGSizeMake(ScreenW,216)
        return textVw
    }()
    
    ///实现inputViewDelegate
    func changteToselectedEmotion(type:selectedEmotionType) {
        
        let indexPath = NSIndexPath(forItem: 0, inSection: type.rawValue)
        
        testInputView.inputCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
    }
}




extension HZNoteController{
    
    ///MARK: --imagePickerController的代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        if picker.sourceType == .PhotoLibrary{
            //创建一个数组,存储选择的照片
            collectionView.appendImage(image)
        }
        //选完后跳转控制器
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    
}










