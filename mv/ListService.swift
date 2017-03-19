//
//  ListService.swift
//  mv
//
//  Created by Anjani on 3/18/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation



class ListService {
    
    static private let _shared = ListService()
    private var maxPages = 1
    
    init() {
    }
    
    class var shared : ListService {
        return _shared
    }
    
    func getPinDisplayList(pageNumber : Int, completion: @escaping (_ model: [PinDisplayItem]?) -> Void) {
        
        //if pageNumber > 1 && pageNumber > maxPages {return}                 //limit api calls till last page
        
        let urlParameters = ""                  //placeholder for parameters if any
        
        NetworkManager.shared.initiateAPIGetCall(urlString: urlParameters){ (response) in
            
            var pinList : [PinDisplayItem]? = nil
            if (response is [[String:Any]]) == true {
                pinList = [PinDisplayItem]()
                for pinObj in response as! [[String:Any]] {
                        let pinModel = PinDisplayItem(dictionary: pinObj)
                        pinModel.cellIdentifier = pinDisplayCellIdentifier
                        pinList?.append(pinModel)
                    }
            }
            completion(pinList)
        }
    }
}
