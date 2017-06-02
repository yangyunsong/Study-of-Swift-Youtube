//
//  Video.swift
//  YouTube
//
//  Created by 杨云淞 on 2017/5/24.
//  Copyright © 2017年 杨云淞. All rights reserved.
//

import UIKit
import SwiftyJSON
import TRON

//struct Video: JSONDecodable {
//    var thumbnailImageName: String?
//    var title: String?
//    
//    init(json: JSON) throws {
//        
//    }
//}


class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercaseFristCharacter = String(key.characters.first!).uppercased()
        
        let range = NSMakeRange(0, 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercaseFristCharacter)
        let selector = NSSelectorFromString("set\(selectorString):")
        let response = self.responds(to: selector)
        
        if !response {
            return
        }
        super.setValue(value, forKey: key)
    }
}


class Video: SafeJsonObject {
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "channel" {
            let channelDictionary = value as! [String: AnyObject]
            self.channel = Channel()
            self.channel?.setValuesForKeys(channelDictionary)
            
        }else {
            super.setValue(value, forKey: key)
        }
    }
    
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
}


class Channel: SafeJsonObject {
    var name: String?
    var profile_image_name: String?
}
