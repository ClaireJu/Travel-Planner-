//
//  SettingsTableViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/12/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        transportationSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        updateUI()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
        
    }
    
    
    private func updateUI() {
        if let width = NSUserDefaults.standardUserDefaults().stringForKey(Constants.Width) {
            widthSlider.value = Float(width.toInt()!)
        } else {
            widthSlider.value = 150
        }
        widthLabel.text = "\(Int(widthSlider.value))"
        if let height = NSUserDefaults.standardUserDefaults().stringForKey(Constants.Height) {
            heightSlider.value = Float(height.toInt()!)
        } else {
            heightSlider.value = 200
        }
        heightLabel.text = "\(Int(heightSlider.value))"
        if let transportation = NSUserDefaults.standardUserDefaults().stringForKey(Constants.Transportation) {
            if(transportation == "walk") {
                transportationSwitch.setOn(true, animated:true)
                transportationLabel.text = "Walk"
            } else {
                transportationSwitch.setOn(false, animated:true)
                transportationLabel.text = "Drive"
            }
        } else {
            transportationSwitch.setOn(true, animated:true)
            transportationLabel.text = "Walk"
        }
        
    }
    
    @IBOutlet private weak var widthLabel: UILabel!
    
    
    @IBOutlet private weak var widthSlider: UISlider!
    
    
    @IBAction private func widthValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        widthLabel.text = "\(currentValue)"
        NSUserDefaults.standardUserDefaults().setObject(widthLabel.text, forKey: Constants.Width)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    @IBOutlet private weak var heightLabel: UILabel!

    @IBOutlet private weak var heightSlider: UISlider!
    
    @IBAction private func heightValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        heightLabel.text = "\(currentValue)"
        NSUserDefaults.standardUserDefaults().setObject(heightLabel.text, forKey: Constants.Height)
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    @IBOutlet private weak var transportationLabel: UILabel!
    
    @IBOutlet private weak var transportationSwitch: UISwitch!
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            transportationLabel.text = "Walk"
            NSUserDefaults.standardUserDefaults().setObject("walk", forKey: Constants.Transportation)
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            transportationLabel.text = "Drive"
            NSUserDefaults.standardUserDefaults().setObject("drive", forKey: Constants.Transportation)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    private struct Constants {
        static let Width = "Width"
        static let Height = "Height"
        static let Transportation = "Transportation"
        
    }
    
}
