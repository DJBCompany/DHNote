//
//  ZXTextView.swift
//  ZXBlog
//
//  Created by chris on 16/3/5.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ZXTextView: UITextView {
    var placeHolder:NSString?
    override func drawRect(rect: CGRect) {
        placeHolder?.drawAtPoint(CGPointMake(2, 5), withAttributes: [NSFontAttributeName:UIFont.systemFontOfSize(14),NSForegroundColorAttributeName:UIColor.greenColor()])
    }

}
