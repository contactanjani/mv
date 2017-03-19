//
//  PinDisplayItem.swift
//  mv
//
//  Created by Anjani on 3/18/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

class PinDisplayItem : ModelInterface{
    
    var imageUrl : String?
    var id : String?
    var likesString : String?
    var categoryString : String = ""
    
    var cellIdentifier : String?
    
    init(dictionary : [String:Any]) {
        
        if let urlDictionary = dictionary[PinDisplayItemKeys.url] as? [String:Any] {
            if let thumbnailUrl = urlDictionary[PinDisplayItemKeys.thumb] as? String {
                imageUrl = thumbnailUrl
            }
        }
        if let id_value = dictionary[PinDisplayItemKeys.id] as? String {
            id = id_value
        }
        
        if let likes_value = dictionary[PinDisplayItemKeys.likes] as? Int {
            likesString = String(format: "Likes: %d", likes_value)
        }
        
        if let categoryList = dictionary[PinDisplayItemKeys.category] as? [[String:Any]] {
            for category in categoryList {
                if let title = category[PinDisplayItemKeys.title] as? String {
                    if categoryString == "" {
                        categoryString = "Category: \(title)"
                    }else {
                        categoryString = categoryString + ", " + title
                    }
                }
            }
        }
    }
}
