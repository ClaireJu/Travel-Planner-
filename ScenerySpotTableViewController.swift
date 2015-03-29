//
//  ScenerySpotTableViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/7/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class ScenerySpotTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var scenerySpots = [[String]]()
    
    
    
    func setScenerySpots (newScenerySpots: [[String]]) {
        scenerySpots = newScenerySpots
    }
    
    private func searchMinDistance () -> Int {
        if(scenerySpots.count > 0) {
            var currentIndex = 0
            var minDistanceIndex = 0
            var stringSpilt = scenerySpots[0][1].componentsSeparatedByString("  ")
            var minDistance = stringSpilt[1].substringToIndex(advance(stringSpilt[1].startIndex, countElements(stringSpilt[1]) - 3)).toInt()
            for spot in scenerySpots {
                stringSpilt = spot[1].componentsSeparatedByString("  ")
                if (stringSpilt[1].substringToIndex(advance(stringSpilt[1].startIndex, countElements(stringSpilt[1]) - 3)).toInt() < minDistance) {
                    minDistanceIndex = currentIndex
                    minDistance = stringSpilt[1].substringToIndex(advance(stringSpilt[1].startIndex, countElements(stringSpilt[1]) - 3)).toInt()
                }
                currentIndex++
            }
            return minDistanceIndex
        } else {
            return -1
        }
    }
    
    
    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return scenerySpots.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scenerySpots[section].count
    }
    
    
        override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return scenerySpots[section].count > 0 ? "Scenery Spot " + "\(section + 1)": nil
    
        }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var spot = scenerySpots[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SpotCellReuseIdentifier, forIndexPath: indexPath) as SpotTableViewCell
        cell.setSpotInfo(spot)
        return cell
    }
    
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.BackToToSegue:
                let cell = sender as SpotTableViewCell
                if let indexPath = tableView.indexPathForCell(cell) {
                    if let ptvc = segue.destinationViewController.contentViewController as? PlanningTableViewController {
                        let toLocation = scenerySpots[indexPath.section][0]
                        NSUserDefaults.standardUserDefaults().setObject(toLocation.substringFromIndex(advance(toLocation.startIndex, 11)), forKey: Constants.TmpToLocation)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    }
                }
            case Constants.SelectSegue:
                if let svc = segue.destinationViewController as? ShowViewController {
                    if let ppc = svc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    if (searchMinDistance() != -1) {
                        var info = ""
                        for newInfo in scenerySpots[searchMinDistance()] {
                            info = info + newInfo + "\n"
                        }
                        svc.setText(info)
                    }
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    
    private struct Constants {
        static let SpotCellReuseIdentifier = "Spot"
        static let TmpFromLocation = "tmpFromLocation"
        static let TmpToLocation = "tmpToLocation"
        static let BackToToSegue = "Back To To Location"
        static let SelectSegue = "Select as"
        
        
    }

}
