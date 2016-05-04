//
//  ZXEmotion.swift
//  ZXBlog
//
//  Created by chris on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ZXEmotion: NSObject {
    ///发给服务器时用的,一个微笑图发给服务器应该是[微笑]
    var chs:String?
    ///表情的相对路径
    var png:String?
    ///emoji图片的16进制表示要转为字符串
    var code:String?{
        didSet{
           //创建一个scanner的实例
            let scanner = NSScanner(string: code!)
           //创建一个结果接收
            var result:UInt32 = 0
            scanner.scanHexInt(&result)
            //将结果转化成Unicode
            let unicode = UnicodeScalar(result)
            //将Unicode转换成character
            let character = Character(unicode)
            //将character转换成字符串
            emoji = "\(character)"
        }
    }
    
    var emoji: String?
    ///图片的包路径
    var packagePath:String?
    
    init(dic:[String:NSObject]){
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

}
