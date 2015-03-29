//
//  SpotTableViewCell.swift
//  TravelPlanner
//
//  Created by Claire on 3/7/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class SpotTableViewCell: UITableViewCell {

    private var spotInfo: String? {
        didSet {
            updateUI()
        }
    }
    
    
    func setSpotInfo(newSpotInfo: String?) {
        spotInfo = newSpotInfo
    }
    
    @IBOutlet private weak var spotInforLabel: UILabel!
    
    
    
    private func updateUI() {
        spotInforLabel?.text = nil
        if let spotInfo = self.spotInfo
        {
            spotInforLabel?.text = spotInfo
        }
    }

}
