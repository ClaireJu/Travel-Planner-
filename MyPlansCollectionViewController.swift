//
//  MyPlansCollectionViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/6/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

let reuseIdentifier = "planCell"

class MyPlansCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //If you do not want clean NSDefaults each time you start the app, please comment this.
        for key in NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key.description)
        }
        NSUserDefaults.standardUserDefaults().synchronize()


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        collectionView?.reloadData()
    }
    

    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photos = NSUserDefaults.standardUserDefaults().objectForKey(Constants.Photos) as? [NSData] {
            return photos.count
        }
        return 0
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as MyPlansCollectionViewCell

        if let photos = NSUserDefaults.standardUserDefaults().objectForKey(Constants.Photos) as? [NSData] {
            cell.planImageView.image = UIImage(data:photos[indexPath.row % photos.count])
        }
        if let newPlans = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.NewPlan) as? [String]{
            if(newPlans[indexPath.row % newPlans.count] != " ") {
                cell.planNameLabel.text = newPlans[indexPath.row % newPlans.count]
            } else {
                cell.planNameLabel.text = "No Plan Name"
            }
        }
        
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: Selector("swipe:"))
        swipeGesture.delegate = self
        swipeGesture.direction = .Left
        cell.addGestureRecognizer(swipeGesture)
        return cell
    }
    
    func swipe(sender: UIGestureRecognizer) {
            if let senderCell = sender.view as? UICollectionViewCell {
                var indexPath = collectionView?.indexPathForCell(senderCell)
                if let photos = NSUserDefaults.standardUserDefaults().objectForKey(Constants.Photos) as? [NSData] {
                    var newPhotos = photos
                    newPhotos.removeAtIndex(indexPath!.row)
                    NSUserDefaults.standardUserDefaults().setObject(newPhotos, forKey: Constants.Photos)
                    NSUserDefaults.standardUserDefaults().synchronize()
                    var deleteitems: NSArray = [indexPath!]
                    collectionView?.deleteItemsAtIndexPaths(deleteitems)
                    
                    if let plan = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.NewPlan) as? [String] {
                        var newPlan = plan
                        newPlan.removeAtIndex(indexPath!.row)
                        NSUserDefaults.standardUserDefaults().setObject(newPlan, forKey: Constants.NewPlan)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                    
                    if let fromLocation = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.FromLocation) as? [String] {
                        var newFromLocation = fromLocation
                        newFromLocation.removeAtIndex(indexPath!.row)
                        NSUserDefaults.standardUserDefaults().setObject(newFromLocation, forKey: Constants.FromLocation)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                    
                    if let toLocation = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.ToLocation) as? [String] {
                        var newToLocation = toLocation
                        newToLocation.removeAtIndex(indexPath!.row)
                        NSUserDefaults.standardUserDefaults().setObject(newToLocation, forKey: Constants.ToLocation)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                    
                    if let startDate = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.StartDate) as? [String] {
                        var newStartDate = startDate
                        newStartDate.removeAtIndex(indexPath!.row)
                        NSUserDefaults.standardUserDefaults().setObject(newStartDate, forKey: Constants.StartDate)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                    
                    if let endDate = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.EndDate) as? [String] {
                        var newEndDate = endDate
                        newEndDate.removeAtIndex(indexPath!.row)
                        NSUserDefaults.standardUserDefaults().setObject(newEndDate, forKey: Constants.EndDate)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                    
                    if let expense = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.Expense) as? [String] {
                        var newExpense = expense
                        newExpense.removeAtIndex(indexPath!.row)
                        NSUserDefaults.standardUserDefaults().setObject(newExpense, forKey: Constants.Expense)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                    
                    if let notes = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.Notes) as? [String] {
                        var newNotes = notes
                        newNotes.removeAtIndex(indexPath!.row)
                        NSUserDefaults.standardUserDefaults().setObject(newNotes, forKey: Constants.Notes)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }





                    
                }
                
        }
    }

    
    
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            var cellWidth = 0
            if let width = NSUserDefaults.standardUserDefaults().stringForKey(Constants.Width) {
                cellWidth = width.toInt()!
            } else {
                cellWidth = 150
            }
            var cellHeight = 0
            if let height = NSUserDefaults.standardUserDefaults().stringForKey(Constants.Height) {
                cellHeight = height.toInt()!
            } else {
                cellHeight = 200
            }

            return CGSize(width: cellWidth, height:cellHeight)
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    
    
    
    


    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.DetailSegue:
                if let cell = sender as? MyPlansCollectionViewCell {
                if let indexPath = collectionView?.indexPathForCell(cell) {
                    let seguedToDtvc = segue.destinationViewController as? DetailTableViewController
                    if let dtvc = seguedToDtvc {
                        if let newPlan = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.NewPlan) as? [String]{
                            dtvc.pushDetail("New Plan:  " + newPlan[indexPath.row % newPlan.count])
                        } else {
                            dtvc.pushDetail("New Plan")
                        }
                        
                        
                        if let fromLocation = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.FromLocation) as? [String] {
                            dtvc.pushDetail(fromLocation[indexPath.row % fromLocation.count])
                        } else {
                            dtvc.pushDetail("From")
                        }
                        
                        if let toLocation = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.ToLocation) as? [String] {
                            dtvc.pushDetail(toLocation[indexPath.row % toLocation.count])
                        } else {
                            dtvc.pushDetail("To")
                        }


                        if let startDate = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.StartDate) as? [String] {
                            dtvc.pushDetail(startDate[indexPath.row % startDate.count])
                        } else {
                            dtvc.pushDetail("Start Date")
                        }
                        
                        if let endDate = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.EndDate) as? [String] {
                            dtvc.pushDetail(endDate[indexPath.row % endDate.count])
                        } else {
                            dtvc.pushDetail("End Date")
                        }
                        
                        if let expense = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.Expense) as? [String] {
                            dtvc.pushDetail(expense[indexPath.row % expense.count])
                        } else {
                            dtvc.pushDetail("Expense")
                        }
                        
                        if let notes = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.Notes) as? [String] {
                            dtvc.pushDetail(notes[indexPath.row % notes.count])
                        } else {
                            dtvc.pushDetail("Notes")
                        }
                        
                        if let photos = NSUserDefaults.standardUserDefaults().objectForKey(Constants.Photos) as? [NSData] {
                            dtvc.pushDetail(photos[indexPath.row % photos.count])
                        }
                        
                    }
                }
                }
            default: break
            }
        }
    }
    
    
    private struct Constants {
        static let NewPlan = "NewPlan"
        static let FromLocation = "FromLocation"
        static let ToLocation = "ToLocation"
        static let StartDate = "StartDate"
        static let EndDate = "EndDate"
        static let Expense = "Expense"
        static let Notes = "Notes"
        static let Photos = "Photos"
        static let DetailSegue = "Detail"
        static let Width = "Width"
        static let Height = "Height"
    }
}
