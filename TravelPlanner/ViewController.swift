//
//  ViewController.swift
//  TravelPlanner
//
//  Created by Claire on 3/9/15.
//  Copyright (c) 2015 XiaoJu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var images = [NSData]()
    
    private var planNames = [String]()

    private var pageViewController : UIPageViewController?
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilizeUI()
        createPageViewController()
        setupPageControl()
    }
    
    
    private func updateUI() {
        if let photos = NSUserDefaults.standardUserDefaults().objectForKey(Constants.Photos) as? [NSData] {
            images = photos
            images.insert(UIImagePNGRepresentation(UIImage(named: "03.jpg")), atIndex: 0)
        }
        if let plans = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.NewPlan) as? [String]{
            planNames = plans
            planNames.insert(Constants.PageViewWelcome, atIndex: 0)
        }         
    }
    
    
    private func initilizeUI() {
        if let photos = NSUserDefaults.standardUserDefaults().objectForKey(Constants.Photos) as? [NSData] {
            images = photos
            images.insert(UIImagePNGRepresentation(UIImage(named: "03.jpg")), atIndex: 0)
        } else {
            images.append(UIImagePNGRepresentation(UIImage(named: "03.jpg")))
        }
        if let plans = NSUserDefaults.standardUserDefaults().stringArrayForKey(Constants.NewPlan) as? [String]{
            planNames = plans
            planNames.insert(Constants.PageViewWelcome, atIndex: 0)
        } else {
            planNames.append(Constants.PageViewWelcome)
        }
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as UIPageViewController
        pageController.dataSource = self
        
        if images.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward,  animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        pageViewController?.delegate = self
    }
    
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    // UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as PageContentViewController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex - 1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as PageContentViewController
        
        if itemController.itemIndex + 1 < images.count {
            return getItemController(itemController.itemIndex + 1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> PageContentViewController? {
        
        if itemIndex < images.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier(Constants.PageContentViewControllerIndentifier) as PageContentViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageData = images[itemIndex]
            pageItemController.planName = planNames[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    // Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        println("here")
        
        return images.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        println("there")
        return 0
    }
    
    
    private struct Constants {
        static let Photos = "Photos"
        static let NewPlan = "NewPlan"
        static let PageContentViewControllerIndentifier = "PageContentViewController"
        static let PageViewWelcome = "Welcome! Please swipe to see your plans."
        
    }
    
}