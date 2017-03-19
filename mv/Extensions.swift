//
//  Extensions.swift
//  mv
//
//  Created by Anjani on 3/15/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

private let placeholderImageName = "placeholder"

extension UIImageView {
    
    func setImageWithUrl(urlString : String) {
        
        self.image = UIImage(named: placeholderImageName)
        AppDelegate.resourceManager.resource(forURL: urlString, completionHandler: {[weak self] (data) in
            DispatchQueue.main.async {
                self?.image = UIImage(data: data!)
                let transition = CATransition()
                transition.duration = 0.2
                transition.type = kCATransitionFade
                self?.layer.add(transition, forKey: nil)
                
            }
        }, andSender:self)
    }
    
    func cancelImageLoad() {
        AppDelegate.resourceManager.cancelResourceFetchForSender(self)
    }
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
