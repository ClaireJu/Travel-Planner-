//
//  TextDetailTableViewCell.swift
//  TravelPlanner
//
//  Created by Claire on 3/7/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class TextDetailTableViewCell: UITableViewCell {
    
    private var textDetail: String? {
        didSet {
            updateUI()
        }
    }
    
    
    func setTextDetail(newTextDetail: String?) {
        textDetail = newTextDetail
    }
    
    
    @IBOutlet private weak var textDetailLabel: UILabel!
    
    
    private func updateUI() {
        textDetailLabel?.text = nil
        if let textDetail = self.textDetail
        {
            textDetailLabel?.text = textDetail
        }
    }
    


}
