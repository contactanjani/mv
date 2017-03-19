//
//  ListViewCell.swift
//  mv
//
//  Created by Anjani on 3/17/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

class ListViewCell : BaseTableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTopInformation: UILabel!
    @IBOutlet weak var lblBottomInformation: UILabel!
    
    var model : PinDisplayItem?
    
    override func prepareForReuse() {
        imgView.cancelImageLoad()
    }
    
    override func update(_ object : ModelInterface) {
        
        model = nil
        model = object as? PinDisplayItem
        self.updateView()
    }
    
    func updateView() {
        
        DispatchQueue.main.async {
            self.imgView.setImageWithUrl(urlString: (self.model?.imageUrl)!);
            if self.model?.likesString != nil {
                self.lblTopInformation.text = self.model?.likesString
            }
            if self.model?.categoryString != nil {
                self.lblBottomInformation.text = self.model?.categoryString
            }
        }
    }
}
