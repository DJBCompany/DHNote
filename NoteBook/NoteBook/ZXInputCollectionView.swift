//
//  ZXInputCollectionView.swift
//  ZXBlog
//
//  Created by chris on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
let ScreenW = UIScreen.mainScreen().bounds.width
let ZXInputCollectionViewCellReuseIdentifier = "ZXInputCollectionViewCellReuseIdentifier"
class ZXInputCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    var changeBtnType:((sectionNum:Int)->())?
    
    var emotionData:[[[ZXEmotion]]]{
        return ZXEmotionManager.getAllEmotion()
    }
    let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
        dataSource = self
        delegate = self
        registerClass(ZXInputCollectionViewCell.self, forCellWithReuseIdentifier: ZXInputCollectionViewCellReuseIdentifier)
    
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        flowLayout.itemSize = CGSizeMake(ScreenW,self.bounds.height)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.pagingEnabled = true
        self.bounces = false
        

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


extension ZXInputCollectionView{
   //MARK: --数据源方法
    //多少组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return emotionData.count
    }
    
    //一组多少行
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionData[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXInputCollectionViewCellReuseIdentifier, forIndexPath: indexPath) as! ZXInputCollectionViewCell
        cell.pageEmotions = emotionData[indexPath.section][indexPath.item]
                
        return cell
    }
    
    
}


class ZXInputCollectionViewCell:UICollectionViewCell{
    
    var emotionBtns:[ZXEmotionBtn] = [ZXEmotionBtn]()
    var pageEmotions:[ZXEmotion]?{
        didSet{
            for btn in emotionBtns{
                btn.hidden = true
            }
            
            for (index,emotion) in pageEmotions!.enumerate(){
                let btn = emotionBtns[index]
                btn.emotion = emotion
                if let png = emotion.png {
                    //拼接路径加斜杠
                    let imgPath = emotion.packagePath! + "/\(png)"
                    btn.setImage(UIImage(named: imgPath), forState: .Normal)
                    //清空emoji
                    btn.setTitle("", forState: .Normal)
                    btn.hidden = false
                }
                if let emoji = emotion.emoji{
                    btn.setTitle(emoji, forState: .Normal)
                    btn.titleLabel?.font = UIFont.systemFontOfSize(38)
                    //清空png
                    btn.setImage(nil , forState: .Normal)
                    btn.hidden = false
                }
                
            }
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
        creatEmotionBtns()
        contentView.addSubview(deleteBtn)
        deleteBtn.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(self).offset(-10)
        }
        
    }
    
  //MARK: --创建20个按钮,重用的时候直接改变button的值就行了
    func creatEmotionBtns(){
        for _ in 0..<20{
        let btn = ZXEmotionBtn(type: .Custom)
        emotionBtns.append(btn)
        //给按钮添加点击事件
        btn.addTarget(self, action: "clickEmotion:", forControlEvents: .TouchUpInside)
        contentView.addSubview(btn)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnW = self.frame.size.width/7
        let btnH = self.frame.size.height/3
        for (index, btn) in emotionBtns.enumerate(){
            btn.frame = CGRectMake(CGFloat(index%7)*btnW, CGFloat(index/7)*btnH, btnW, btnH)
        }
    }
    
    //添加删除按钮
    lazy var deleteBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"compose_emotion_delete"), forState: .Normal)
        btn.setImage(UIImage(named:"compose_emotion_delete_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        return btn
    }()
    
    
    //表情按钮的点击事件
    func clickEmotion(sender:ZXEmotionBtn){
        //拼接表情数组
        if let emotion = sender.emotion{
         ZXEmotionManager.appendEmotion(emotion)
         //将其显示在textView上 由于是多层传递 所以用到通知 并且将表情传过去
          
    NSNotificationCenter.defaultCenter().postNotificationName("writeEmotion", object: nil, userInfo: ["emotion":emotion])
    
        }
    }
    
}














