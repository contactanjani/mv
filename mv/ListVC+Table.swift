//
//  ListViewController+TableView.swift
//  mv
//
//  Created by Anjani on 3/18/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

let pinDisplayCellIdentifier = "pin"

extension ListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = pinDisplayList, list.count > 0 else {
            return 0
        }
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let model = pinDisplayList?[indexPath.row] {
            if let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier!, for: indexPath) as? BaseTableViewCell {
                cell.update(model)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
