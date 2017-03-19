//
//  ListViewController.swift
//  mv
//
//  Created by Anjani on 3/15/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

class ListViewController : UITableViewController {
    
    @IBOutlet var tblViewPin: UITableView!
    
    var pinDisplayList : [PinDisplayItem]?
    var pageNum  = 1
    
    override func viewDidLoad() {
        fetchData()
        configureUI()
    }
    
    func configureUI() {
        self.addEffects()
    }
}
