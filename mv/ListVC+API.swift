//
//  ListVC+API.swift
//  mv
//
//  Created by Anjani on 3/18/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

extension ListViewController {
    
    func fetchData() {
        ListService.shared.getPinDisplayList(pageNumber: pageNum) {[weak self] (list) in
            guard list != nil else {
                return
            }
            
            if self?.pageNum == 1 {
                self?.pinDisplayList = nil
                self?.pinDisplayList = list
            }else {
                self?.pinDisplayList? =  list! + (self?.pinDisplayList)!
            }
            
            self?.pageNum = (self?.pageNum)! + 1
            
            DispatchQueue.main.async(execute: {
                self?.refreshControl?.endRefreshing()
                self?.tblViewPin.reloadData()
            })
        }
    }
    
    func refreshData() {
        ListService.shared.getPinDisplayList(pageNumber: pageNum) {[weak self] (list) in
            guard list != nil else {
                return
            }
            
            if self?.pageNum == 1 {
                self?.pinDisplayList = nil
                self?.pinDisplayList = list
            }else {
                self?.pinDisplayList? =  (list?.shuffled())! + (self?.pinDisplayList)!
            }
            
            self?.pageNum = (self?.pageNum)! + 1
            
            DispatchQueue.main.async(execute: {
                
                self?.refreshControl?.endRefreshing()
                
                var freshIndexPaths = [IndexPath]()
                var i = 0
                for _ in list! {
                    let indexPath = IndexPath(row: i, section: 0)
                    freshIndexPaths.append(indexPath)
                    i = i + 1
                }
                
//                self?.tblViewPin.beginUpdates()
//                self?.tblViewPin.insertRows(at: freshIndexPaths, with: .none)
//                self?.tblViewPin.endUpdates()
                self?.tblViewPin.reloadData()   //this leads to superior UI transition. (it reloads only the cells visible btw, efficient!)
                
                NSLog("ended pull refresh", NSDate())
            })
        }
    }
}
