//
//  NetworkManager.swift
//  mv
//
//  Created by Anjani on 3/18/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager
{
    static private let _sharedInstance = NetworkManager()
    
    class var shared: NetworkManager {
        return _sharedInstance
    }
    
    init()
    {
        
    }
    
    func initiateAPIGetCall(urlString : String, completion: @escaping (_ model: Any?) -> Void) {
        
        let completeUrlString = API.baseUrl + API.commonEndPoint + urlString
        let request = URLRequest(url: URL(string: completeUrlString)!)
        
        print(request)
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error == nil {
                do {
                    let list : Any = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                    completion(list)
                }catch {
                    completion(nil)
                }
            }else {
                completion(nil)
            }
            
            }.resume()
    }
}
