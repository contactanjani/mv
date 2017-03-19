//
//  ListVC+Effects.swift
//  mv
//
//  Created by Anjani on 3/18/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

extension ListViewController {

    func addEffects() {
        self.addPullToRefreshControl()
        self.addLongPressGesture()
    }
    
    func addLongPressGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ListViewController.longPress(_:)))
        longPressRecognizer.minimumPressDuration = 0.5
        self.tblViewPin.addGestureRecognizer(longPressRecognizer)
    }
    
    func addPullToRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.lightGray
        self.refreshControl?.tintColor = UIColor.white
        self.refreshControl?.addTarget(self, action: #selector(ListViewController.refreshAction(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func refreshAction(sender : AnyObject) {
        NSLog("started pull refresh", NSDate())
        self.refreshControl?.beginRefreshing()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: {
            self.refreshData()
        })
    }
    
    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tblViewPin.indexPathForRow(at: touchPoint) {
                
                let pressedCell = tblViewPin.cellForRow(at: indexPath)
                
                var visibleCells = tblViewPin.visibleCells
                let index = visibleCells.index(where: { (cell) -> Bool in
                    return pressedCell == cell
                })
                
                visibleCells.remove(at: index!)
                
                for cell in visibleCells {
                    cell.alpha = 0
                }
                
                let transition = CATransition()
                transition.duration = 0.2
                transition.type = kCATransitionFade
                self.tblViewPin.layer.add(transition, forKey: nil)
            }
            
        }else if longPressGestureRecognizer.state == UIGestureRecognizerState.ended {
            
                let visibleCells = tblViewPin.visibleCells
                for cell in visibleCells {
                    cell.alpha = 1
                }
                let transition = CATransition()
                transition.duration = 0.1
                transition.type = kCATransitionFade
                self.tblViewPin.layer.add(transition, forKey: nil)
        }
    }
}
