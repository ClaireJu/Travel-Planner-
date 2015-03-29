//
//  DetailTableViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/7/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    
    private enum Detail {
        case ImageDetail(NSData)
        case TextDetail(String)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var planDetail = [Detail]()
    
  
    
    func pushDetail (imageData: NSData?) {
        if let newImageData = imageData {
            planDetail.append(Detail.ImageDetail(newImageData))
        }
    }
    
    
    func pushDetail (text: String?) {
        if let newText = text {
            planDetail.append(Detail.TextDetail(newText))
        }
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return planDetail.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    private struct Storyboard {
        static let ImageCellReuseIdentifier = "Image Detail"
        static let TextCellReuseIdentifier = "Text Detail"
        
    }
    
    
    //show different contents in different kinds of cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var detail = planDetail[indexPath.section]
        switch detail {
        case .ImageDetail(let imageData):
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.ImageCellReuseIdentifier, forIndexPath: indexPath) as ImageDetailTableViewCell
            cell.setImageDetail(imageData)
            return cell
        case .TextDetail(let text):
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.TextCellReuseIdentifier, forIndexPath: indexPath) as TextDetailTableViewCell
            cell.setTextDetail(text)
            return cell
        }
        

    }
    
    
  
    
    
    //set appropriate height for images and autodimension for text
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var detail = planDetail[indexPath.section]
        switch detail {
        case .ImageDetail(_):
            return 250;
        case .TextDetail(_):
            return UITableViewAutomaticDimension
        }
    }
    
    
    
    // MARK: - Navigation
       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.ImageSegue:
                let cell = sender as ImageDetailTableViewCell
                if let indexPath = tableView.indexPathForCell(cell) {
                    if let ivc = segue.destinationViewController as? ImageViewController {
                        var detail = planDetail[indexPath.section]
                        switch detail {
                        case .ImageDetail(let imageData):
                            ivc.setImageData(imageData)
                        default: break
                        }
                    }
                }
            default: break
            }
        }
    }
    
    
    
    private struct Constants {
        static let ImageSegue = "Image"
        
        
    }


}
