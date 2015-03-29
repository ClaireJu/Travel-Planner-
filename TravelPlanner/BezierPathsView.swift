//
//  BezierPathsView.swift
//  TravelPlanner
//
//  Created by Claire on 3/13/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class BezierPathsView: UIView {
    private var bezierPaths = [String:UIBezierPath]()
    
    func removePath() {
        bezierPaths.removeAll()
    }
    
    func setPath(path: UIBezierPath?, named name: String) {
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        var strokeColor: UIColor = UIColor.lightGrayColor()
        for (_, path) in bezierPaths {
            strokeColor.setStroke()
            path.stroke()
        }
    }
}
