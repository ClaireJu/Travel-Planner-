//
//  PageContentViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/9/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

  
    @IBOutlet private weak var pageImageView: UIImageView!
    
    @IBOutlet private weak var planNameLabel: UILabel!
    
    var itemIndex: Int = 0
    
    var imageData: NSData? {
        didSet {
            if let newPageImageView = pageImageView {
                if let newImageData = imageData {
                    newPageImageView.image = UIImage(data: newImageData)
                }
            }
        }
    }
    
    var planName: NSString? {
        didSet {
            if let newPlanNameLabel = planNameLabel {
                if let newPlanName = planName {
                    newPlanNameLabel.text = newPlanName
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newPageImageView = pageImageView {
            if let newImageData = imageData {
                newPageImageView.image = UIImage(data: newImageData)
            }
        }
        if let newPlanNameLabel = planNameLabel {
            if let newPlanName = planName {
                newPlanNameLabel.text = newPlanName
            }
        }
    }

}
