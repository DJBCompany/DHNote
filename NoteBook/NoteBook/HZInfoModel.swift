//
//  HZInfoModel.swift
//  NoteBook
//
//  Created by DH on 16/4/30.
//  Copyright © 2016年 chris. All rights reserved.
//

import UIKit

class HZInfoModel: NSObject, NSCoding {
    var username: String?
    var password: String?
    var email: String?
    var findQuestion: String?
    var findAnswer: String?
    override init() {
        super.init()
    }
    
    // 解档
    required init?(coder aDecoder: NSCoder) {
        super.init()
        username = aDecoder.decodeObjectForKey("username") as? String
        password = aDecoder.decodeObjectForKey("password") as? String
        email = aDecoder.decodeObjectForKey("email") as? String
        findQuestion = aDecoder.decodeObjectForKey("findQuestion") as? String
        findAnswer = aDecoder.decodeObjectForKey("findAnswer") as? String
    }
    // 归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(username, forKey: "username")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(findQuestion, forKey: "findQuestion")
        aCoder.encodeObject(findAnswer, forKey: "findAnswer")
    }
}
