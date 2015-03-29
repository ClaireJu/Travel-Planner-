//
//  PlanningTableViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/5/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit
import AssetsLibrary

class PlanningTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
 {
    
    
    @IBOutlet private weak var newPlanTextField: UITextField!{didSet {newPlanTextField.delegate = self}}
    
    
    
    
    @IBOutlet private weak var fromLocationTextField: UITextField!{didSet {fromLocationTextField.delegate = self}}
    
    

    @IBOutlet private weak var toSegmentedControl: UISegmentedControl!
    

    @IBAction private func toChooseChanged(sender: UISegmentedControl) {
        switch toSegmentedControl.selectedSegmentIndex
        {
        case 0: toLocationTextField.delegate = self
                toLocationTextField.becomeFirstResponder()
        case 1:
            self.performSegueWithIdentifier(Constants.ToSegue, sender: self)
        default: break;
        }
    }
    
    
    @IBOutlet private weak var toLocationTextField: UITextField!{didSet {toLocationTextField.delegate = self}}

    
    
    
    @IBOutlet private weak var startDateLabel: UILabel!
    
    @IBOutlet private weak var endDateLabel: UILabel!
    
    
    
    @IBOutlet private weak var expenseTextField: UITextField! {
        didSet {
            expenseTextField.delegate = self
            if let expenseTextFieldValue = expenseTextField.text.toInt() {
                expenseStepper.value = Double(expenseTextFieldValue)
            } else {
                expenseStepper.value = 0
            }
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        if let expenseTextFieldValue = expenseTextField.text.toInt() {
            expenseStepper.value = Double(expenseTextFieldValue)
        } else {
            expenseStepper.value = 0
        }

        NSUserDefaults.standardUserDefaults().setObject(newPlanTextField.text, forKey: Constants.TmpNewPlan)
        NSUserDefaults.standardUserDefaults().setObject(fromLocationTextField.text, forKey: Constants.TmpFromLocation)
        NSUserDefaults.standardUserDefaults().setObject(toLocationTextField.text, forKey: Constants.TmpToLocation)
        NSUserDefaults.standardUserDefaults().setObject(expenseTextField.text, forKey: Constants.TmpExpense)
        NSUserDefaults.standardUserDefaults().synchronize()
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBOutlet private weak var expenseStepper: UIStepper!
    
    @IBAction private func expenseChanged(sender: UIStepper) {
        expenseTextField.text = Int(sender.value).description
        NSUserDefaults.standardUserDefaults().setObject(expenseTextField.text, forKey: Constants.TmpExpense)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    

    
    @IBOutlet private weak var notesTextView: UITextView! {didSet {notesTextView.delegate = self}}
    
    
    
    func textView(textView: UITextView!, shouldChangeTextInRange: NSRange, replacementText: NSString!) -> Bool {
        NSUserDefaults.standardUserDefaults().setObject(notesTextView.text, forKey: Constants.TmpNotes)
        NSUserDefaults.standardUserDefaults().synchronize()
        if(replacementText == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    
    @IBAction private func openPhotoLibrary(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
         if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(image), forKey: Constants.TmpPhoto)
            NSUserDefaults.standardUserDefaults().synchronize()
            photoImageView.image = image
        }
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    
    
    
    
    @IBAction private func save(sender: UIBarButtonItem) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.TmpNewPlan)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.TmpFromLocation)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.TmpToLocation)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.TmpStartDate)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.TmpEndDate)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.TmpExpense)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.TmpNotes)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constants.TmpPhoto)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if let plan = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.NewPlan) as? [String] {
            var newPlan = plan
            newPlan.append(newPlanTextField.text)
            NSUserDefaults.standardUserDefaults().setObject(newPlan, forKey: Constants.NewPlan)
        } else {
            NSUserDefaults.standardUserDefaults().setObject([newPlanTextField.text], forKey: Constants.NewPlan)
        }
        
        if let fromLocation = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.FromLocation) as? [String] {
            var newFromLocation = fromLocation
            newFromLocation.append("From:  " + fromLocationTextField.text)
            NSUserDefaults.standardUserDefaults().setObject(newFromLocation, forKey: Constants.FromLocation)
        } else {
            NSUserDefaults.standardUserDefaults().setObject(["From:  " + fromLocationTextField.text], forKey: Constants.FromLocation)
        }
        
        if let toLocation = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.ToLocation) as? [String] {
            var newToLocation = toLocation
            newToLocation.append("To:  " + toLocationTextField.text)
            NSUserDefaults.standardUserDefaults().setObject(newToLocation, forKey: Constants.ToLocation)
        } else {
            NSUserDefaults.standardUserDefaults().setObject(["To:  " + toLocationTextField.text], forKey: Constants.ToLocation)
        }


        if let startDate = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.StartDate) as? [String] {
            var newStartDate = startDate
            newStartDate.append(startDateLabel.text!)
            NSUserDefaults.standardUserDefaults().setObject(newStartDate, forKey: Constants.StartDate)
        } else {
            NSUserDefaults.standardUserDefaults().setObject([startDateLabel.text!], forKey: Constants.StartDate)
        }
        
        if let endDate = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.EndDate) as? [String] {
            var newEndDate = endDate
            newEndDate.append(endDateLabel.text!)
            NSUserDefaults.standardUserDefaults().setObject(newEndDate, forKey: Constants.EndDate)
        } else {
            NSUserDefaults.standardUserDefaults().setObject([endDateLabel.text!], forKey: Constants.EndDate)
        }
        
        if let expense = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.Expense) as? [String] {
            var newExpense = expense
            newExpense.append("Expense:  " + expenseTextField.text)
            NSUserDefaults.standardUserDefaults().setObject(newExpense, forKey: Constants.Expense)
        } else {
            NSUserDefaults.standardUserDefaults().setObject(["Expense:  " + expenseTextField.text], forKey: Constants.Expense)
        }
        
        if let notes = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.Notes) as? [String] {
            var newNotes = notes
            newNotes.append("Notes:  " + notesTextView.text)
            NSUserDefaults.standardUserDefaults().setObject(newNotes, forKey: Constants.Notes)
        } else {
            NSUserDefaults.standardUserDefaults().setObject(["Notes:  " + notesTextView.text], forKey: Constants.Notes)
        }
        
        
        
        if let photos = NSUserDefaults.standardUserDefaults().objectForKey(Constants.Photos) as? [NSData] {
            var newPhotos = photos
            if photoImageView.image != nil {
                newPhotos.append(UIImagePNGRepresentation(photoImageView.image))
            } else {
                let alert = UIAlertController(title: "Please add a photo!", message:
                    "", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            NSUserDefaults.standardUserDefaults().setObject(newPhotos, forKey: Constants.Photos)
        } else {
            if photoImageView.image != nil {
                NSUserDefaults.standardUserDefaults().setObject([UIImagePNGRepresentation(photoImageView.image)], forKey: Constants.Photos)
            } else {
                let alert = UIAlertController(title: "Please add a photo!", message:
                    "", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        

        NSUserDefaults.standardUserDefaults().synchronize()
        
        let alert = UIAlertController(title: "Saved Successfully!", message:
            "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        updateUI()

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    
    private func updateUI() {
        if let tmpNewPlan = NSUserDefaults.standardUserDefaults().stringForKey(Constants.TmpNewPlan) {
            newPlanTextField.text = tmpNewPlan
        } else {
            newPlanTextField.text = " "
        }
        
        if let tmpFromLocation = NSUserDefaults.standardUserDefaults().stringForKey(Constants.TmpFromLocation) {
            fromLocationTextField.text = tmpFromLocation
        } else {
            fromLocationTextField.text = ""
        }
        
        if let tmpToLocation = NSUserDefaults.standardUserDefaults().stringForKey(Constants.TmpToLocation) {
            toLocationTextField.text = tmpToLocation
        } else {
            toLocationTextField.text = ""
        }
        
        
        if let tmpStartDate = NSUserDefaults.standardUserDefaults().stringForKey(Constants.TmpStartDate) {
            startDateLabel.text = tmpStartDate
        } else {
            startDateLabel.text = "Start Date:  "
        }
        
        if let tmpEndDate = NSUserDefaults.standardUserDefaults().stringForKey(Constants.TmpEndDate) {
            endDateLabel.text = tmpEndDate
        } else {
            endDateLabel.text = "End Date:  "
        }
        
        if let tmpExpense = NSUserDefaults.standardUserDefaults().stringForKey(Constants.TmpExpense) {
            expenseTextField.text = tmpExpense
        } else {
            expenseTextField.text = ""
        }
        
        
        if let tmpNotes = NSUserDefaults.standardUserDefaults().stringForKey(Constants.TmpNotes) {
            notesTextView.text = tmpNotes
        } else {
            notesTextView.text = "Notes"
        }
        
        
        if let tmpPhoto = NSUserDefaults.standardUserDefaults().objectForKey(Constants.TmpPhoto) as? NSData{
            photoImageView.image = UIImage(data: tmpPhoto)
        } else {
            photoImageView.image = nil
        }
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.StartDateSegue:
                if let dpvc = segue.destinationViewController.contentViewController as? DatePickerTableViewController {
                    dpvc.setShowMessage(Constants.StartDateSegue)
                }
            case Constants.EndDateSegue:
                if let dpvc = segue.destinationViewController.contentViewController as? DatePickerTableViewController {
                    dpvc.setShowMessage(Constants.EndDateSegue)
                }
            default: break
            }
        }
    }
    
    
    
    private struct Constants {
        static let StartDateSegue = "Start Date"
        static let EndDateSegue = "End Date"
        static let ToSegue = "To Location Map"
        
        
        static let TmpNewPlan = "tmpNewPlan"
        static let TmpFromLocation = "tmpFromLocation"
        static let TmpToLocation = "tmpToLocation"
        static let TmpStartDate = "tmpStartDate"
        static let TmpEndDate = "tmpEndDate"
        static let TmpExpense = "tmpExpense"
        static let TmpNotes = "tmpNotes"
        static let TmpPhoto = "tmpPhoto"
        
        
        static let NewPlan = "NewPlan"
        static let FromLocation = "FromLocation"
        static let ToLocation = "ToLocation"
        static let StartDate = "StartDate"
        static let EndDate = "EndDate"
        static let Expense = "Expense"
        static let Notes = "Notes"
        static let Photos = "Photos"
        
    }
    
    
    
}


extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController
        } else {
            return self
        }
    }
}


