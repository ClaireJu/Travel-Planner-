//
//  ImageViewController.swift
//  Smashtag
//
//  Created by Claire on 2/15/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{
    
    
    private var imageData: NSData? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    func setImageData(clikedImage: NSData!) {
        imageData = clikedImage
    }
    
        private func fetchImage()
    {
        if let newImageData = imageData {
            self.image = UIImage(data: imageData!)
        } else {
            self.image = nil
        }
    }
    
    
    @IBOutlet private weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 10.0
        }
    }
    
    
    
    private func setZoomScaleToFullScreen() {
        if let widthImage = imageView.image?.size.width {
            var widthScale = scrollView.frame.size.width / widthImage
            if let heightImage = imageView.image?.size.height {
                let heightNaviBar = self.navigationController?.navigationBar.frame.size.height ?? CGFloat(0)
                let heightTarBar = self.tabBarController?.tabBar.frame.size.height ?? CGFloat(0)
                let heightStatusBar = UIApplication.sharedApplication().statusBarFrame.height
                var heightScale = (scrollView.frame.size.height - heightNaviBar - heightTarBar - heightStatusBar) / heightImage
                scrollView.setZoomScale(max(widthScale, heightScale), animated: true)
            }
        }
    }
    
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
        private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            setZoomScaleToFullScreen()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if image != nil {
            fetchImage()
        }
    }
}

