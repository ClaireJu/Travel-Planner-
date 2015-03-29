//
//  ShowViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/8/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    
    @IBOutlet private weak var showTextView: UITextView! {
        didSet {
            showTextView.text = text
        }
    }
    
    private var text: String = "" {
        didSet {
            showTextView?.text = text
        }
    }
    
    func setText(text: String?) {
        if let newText = text {
            self.text = newText
        }
        
    }
    
    //Make popover size fit for text size
    override var preferredContentSize: CGSize {
        get {
            if showTextView != nil && presentingViewController != nil {
                return showTextView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
                
            }
        }
        set { super.preferredContentSize = newValue }
    }
    
    
   }
