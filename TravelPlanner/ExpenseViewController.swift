//
//  ExpenseViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/13/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {

    @IBOutlet private weak var expenseView: BezierPathsView!
    
    
    @IBOutlet private weak var expenseViewInfoLabel: UILabel!

    private var photos = [NSData]()

    private func expenseNumber() -> Int {
        if let expense = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.Expense) as? [String] {
            photos = NSUserDefaults.standardUserDefaults().objectForKey(Constants.Photos) as [NSData]
            return expense.count
        } else {
            photos.removeAll()
            return 0
        }
    }
    
    private var maxExpense: CGFloat = 0
    
    private func expenseArrayCompute() ->[CGFloat] {
        maxExpense = 0
        var expenseArray = [CGFloat]()
        if let expense = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.Expense) as? [String] {
            for singleExpense in expense {
                var stringSpilt = singleExpense.componentsSeparatedByString("  ")
                if(stringSpilt[1].toInt() != nil) {
                    maxExpense = max(maxExpense, CGFloat(stringSpilt[1].toInt()!))
                    expenseArray.append(CGFloat(stringSpilt[1].toInt()!))
                } else {
                    expenseArray.append(CGFloat(0))
                }
            }
        }
        return expenseArray
    }
    
    
    private var widthRatio = CGFloat(2) / CGFloat(3)
    private var heightRatio = CGFloat(3) / CGFloat(4)

    
    private func showExpense() {
        let brickNumber = expenseNumber()
        if(brickNumber != 0) {
            let brickWidth = expenseView.bounds.size.width * widthRatio / (2 * CGFloat(brickNumber) - 1)
            let whitespace = brickWidth
            let expenseArray = expenseArrayCompute()
            expenseViewInfoLabel?.text = "The maximum expense is " + "\(maxExpense)"
            var count = 0
            for expense in expenseArray {
                var brickHeight = CGFloat(0)
                if(maxExpense != 0) {
                    brickHeight = expenseView.bounds.size.height * heightRatio * expense / maxExpense
                }
                let brickSize = CGSize(width: brickWidth, height: brickHeight)
                var brickFrame = CGRect(origin: CGPointZero, size: brickSize)
                brickFrame.origin.x = expenseView.bounds.size.width * (1 - widthRatio) / 2 + 2 * CGFloat(count) * brickWidth
                brickFrame.origin.y = expenseView.bounds.size.height * (1 - (1 - heightRatio) * 2 / 3) - brickHeight
                let brickView = UIView(frame: brickFrame)
                brickView.backgroundColor = UIColor(red: 0.0, green: 197/255.0, blue: 205/255.0, alpha: 1.0)

                let barrierSize = brickSize
                let barrierOrigin = CGPoint(x: brickView.frame.origin.x, y: brickView.frame.origin.y)
                let path = UIBezierPath(rect: CGRect(origin: barrierOrigin, size: barrierSize))
                expenseView.setPath(path, named: String(count))
                expenseView.addSubview(brickView)

                
                
                let photoHeight = expenseView.bounds.size.height * (1 - heightRatio) * 2 / 5
                let photoSize = CGSize(width: brickWidth, height: photoHeight)
                var photoFrame = CGRect(origin: CGPointZero, size: photoSize)
                photoFrame.origin.x = brickFrame.origin.x
                photoFrame.origin.y = brickFrame.origin.y + brickFrame.size.height + expenseView.bounds.size.height * (1 - heightRatio) * 2 / 15
                let photoView = UIImageView(frame: photoFrame)
                photoView.image = UIImage(data: photos[count])
                expenseView.addSubview(photoView)
                count = count + 1
            }
        } else {
            expenseViewInfoLabel?.text = "Please add a plan to show expense stats!"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeSubviews()
        expenseView.removePath()
        expenseView.setPath(nil, named: "Empty")
        expenseViewInfoLabel?.text = "   "
        showExpense()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        removeSubviews()
        expenseView.removePath()
        expenseView.setPath(nil, named: "Empty")
        expenseViewInfoLabel?.text = "   "
        showExpense()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        removeSubviews()
        expenseView.removePath()
        expenseView.setPath(nil, named: "Empty")
        expenseViewInfoLabel?.text = "   "
        showExpense()
        
    }
    
    
    private func removeSubviews() {
        for subview in expenseView.subviews {
            if let newSubview = subview as? UIView {
                newSubview.removeFromSuperview()
            }
        }
    }
    
    
    private struct Constants {
        static let Expense = "Expense"
        static let Photos = "Photos"
    }
    

}
