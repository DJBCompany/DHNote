//
//  ZXEmotionManager.swift
//  ZXBlog
//
//  Created by chris on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ZXEmotionManager: NSObject {
    
    //static 修饰的成员属性是类变量
    
    ///最近表情数组
  static var recentEmotion:[ZXEmotion] = [ZXEmotion]()
    
    ///默认表情数组
    
  static var defaultEmotion:[ZXEmotion] = ZXEmotionManager.getEmotionFromPackage("com.sina.default")
    
    ///emoji表情数组
    
  static var emojiEmotion:[ZXEmotion] = ZXEmotionManager.getEmotionFromPackage("com.apple.emoji")
    
    ///浪小花表情数组
    
  static var lxhEmotion:[ZXEmotion] = ZXEmotionManager.getEmotionFromPackage("com.sina.lxh")
    
    
//    ///存储所有数据的数组
//    var allEmotion:[[ZXEmotion]] {
//        return [recentEmotion,defaultEmotion,emojiEmotion,lxhEmotion]
//    }
    
    ///定义一个拿到所有数据的接口
  class func getAllEmotion()->([[[ZXEmotion]]]){
        return [pageEmotions(recentEmotion),pageEmotions(defaultEmotion),pageEmotions(emojiEmotion),pageEmotions(lxhEmotion)]
    }
    
    
    //将emotion从bundle中读取,在字典转模型
    
  class func getEmotionFromPackage(packagePath:String)->([ZXEmotion]){
      //经过测试得到图片的路径是有包路径  + 图片的相对包路径
        //获取bundle路径
        let bundlePath = NSBundle.mainBundle().pathForResource("Emoticons.bundle", ofType: nil)!
        //拼接包路径  此时需要传入一个包路径
        let pkPath = (bundlePath as NSString).stringByAppendingPathComponent(packagePath)
        
        //图片的路径在plist文件中
        
        //获取plist路径
        
        let plistPath = (pkPath as NSString).stringByAppendingPathComponent("info.plist")
        
        //获取字典
        let dic = NSDictionary(contentsOfFile: plistPath)!
        
        
            let emotionArr = dic["emoticons"] as! [[String:NSObject]]
            //遍历数组
              //定义一个临时数组来存储模型
              var tempArr = [ZXEmotion]()
            for emotionDic in emotionArr{
                
               let emotion = ZXEmotion(dic: emotionDic)
                
               //给emotion一个包路径 便于以后用 所以给emotion添加一个packagePath属性
                
                emotion.packagePath = pkPath
                
               tempArr.append(emotion)
            }
            //返回模型数组
            return tempArr
        }
        

    
    class func pageEmotions(emoticons:[ZXEmotion]) -> [[ZXEmotion]] {
        
        // 表情 有 25
        // 第一页 20
        // 第二页 5
        // 需要判断最后一页,是否等于20.如果小于20,让截取的长度 等于那个长度
        var result = [[ZXEmotion]]()
        //得知道有多少个表情
        let count = emoticons.count
        
        // 知道多少页
        let page = (count - 1)/20 + 1
        
        //切割原有的数组
        for i in 0..<page {
            //定义一个长度,用于记录切割长度
            var len = 20
            // 判断最后一页
            if i == page-1 {
                // 数组的长度 - 页数*每页的个数 = 剩余切割的长度
                // 需要注意边界值
                if count - i*20 >= 0{
                    
                    len = count - i*20
                }
                
                
            }
            
            let subArray = (emoticons as NSArray).subarrayWithRange(NSMakeRange(i*20, len)) as! [ZXEmotion]
            
            result.append(subArray)
            
        }
        
        return result
    }

 class func appendEmotion(emotion:ZXEmotion){
     if recentEmotion.contains(emotion){
        return
         }
       //新添加的表情应该插入放在最前面  不能用append
        recentEmotion.insert(emotion, atIndex: 0)
    //限制最近表情的个数不超过20个 如果超过20个 将最后一个移除
    if recentEmotion.count > 20 {
        recentEmotion.removeLast()
    }
        
    }
    
    
}
    
    
    


