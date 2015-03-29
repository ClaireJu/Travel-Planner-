//
//  DatePickerTableViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/5/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class DatePickerTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newShowMessage = showMessage {
            dateLabel.text = newShowMessage + ":  "
        }
        datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    private var showMessage: String?
    
    func setShowMessage(transShowMessage: String?) {
        showMessage = transShowMessage
    }
    
    @IBAction private func done(sender: UIBarButtonItem) {
        if let labelText = dateLabel.text {
            if(labelText.hasPrefix("Start")) {
                NSUserDefaults.standardUserDefaults().setObject(labelText, forKey: "tmpStartDate")
            } else {
                NSUserDefaults.standardUserDefaults().setObject(labelText, forKey: "tmpEndDate")
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction private func cancel(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    
    @IBOutlet private weak var datePicker: UIDatePicker!
    

    
    @IBOutlet private weak var dateLabel: UILabel!

    
    
    func datePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var date = dateFormatter.stringFromDate(datePicker.date)
        
        if let newShowMessage = showMessage {
            dateLabel.text = newShowMessage + ":  " + date
        } else {
            dateLabel.text = date
        }
        
    }

    
}
