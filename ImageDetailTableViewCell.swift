//
//  ImageDetailTableViewCell.swift
//  TravelPlanner
//
//  Created by Claire on 3/7/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class ImageDetailTableViewCell: UITableViewCell {
    

    private var imageDetail: NSData? {
        didSet {
            updateUI()
        }
    }
    
    func setImageDetail(newImageDetail: NSData?) {
        imageDetail = newImageDetail
    }
    
    
    
    @IBOutlet private weak var detailImageView: UIImageView!
    
    private func updateUI() {
        
        detailImageView?.image = nil
        if let imageDetail = self.imageDetail {
            detailImageView.image = UIImage(data:imageDetail)
        }
    }

}
