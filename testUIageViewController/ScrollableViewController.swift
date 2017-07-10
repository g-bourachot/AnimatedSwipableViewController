//
//  ScrollableViewController.swift
//  AnimatedSwipableViewController
//
//  Created by Guillaume Bourachot on 10/07/2017.
//  Copyright © 2017 Guillaume Bourachot. All rights reserved.
//

import UIKit

class ScrollableViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Variables
    private let scrollView = UIScrollView()
    private var isAnimatingOnBoarding = false
    
    var showOnBoardingAnimation : Bool = true
    var contentViewControllers: [UIViewController] = []
    var startingAnimationDelay = 0.0
    var halfwayAnimationDelay = 0.5
    var swippingWidthRatio = 0.3
    
    
    //MARK: - Life cycle
    override func loadView() {        
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        self.view = scrollView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let width: CGFloat = CGFloat(contentViewControllers.count) * self.view.bounds.size.width
        scrollView.contentSize = CGSize.init(width: width, height: self.view.bounds.size.height)
        layoutViewController(fromIndex: 0, toIndex: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if showOnBoardingAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.startingAnimationDelay) {
                self.onBoardingAnimation()
            }
        }
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let fromIndex = floor(scrollView.bounds.origin.x  / scrollView.bounds.size.width)
        let toIndex = floor((scrollView.bounds.maxX - 1) / scrollView.bounds.size.width)
        layoutViewController(fromIndex: Int(fromIndex), toIndex: Int(toIndex))
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if isAnimatingOnBoarding {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.halfwayAnimationDelay) {
                self.isAnimatingOnBoarding = false
                self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            }
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offset = round(targetContentOffset.pointee.x / self.view.bounds.size.width) * self.view.bounds.size.width
        targetContentOffset.pointee.x = offset
    }
    
    //MARK: - Animation function
    
    func onBoardingAnimation() {
        self.scrollView.setContentOffset(CGPoint.init(x: 0.2 * self.view.bounds.size.width, y: 0), animated: true)
        isAnimatingOnBoarding = true
    }
    
    private func layoutViewController(fromIndex: Int, toIndex: Int) {
        
        for i in 0 ..< contentViewControllers.count {
            // Remove views that should not be visible anymore
            if (contentViewControllers[i].view.superview != nil && (i < fromIndex || i > toIndex)) {
                contentViewControllers[i].willMove(toParentViewController: nil)
                contentViewControllers[i].view.removeFromSuperview()
                contentViewControllers[i].removeFromParentViewController()
            }
            
            // Add views that are now visible
            if (contentViewControllers[i].view.superview == nil && (i >= fromIndex && i <= toIndex)) {
                var viewFrame = self.view.bounds
                viewFrame.origin.x = CGFloat(i) * self.view.bounds.size.width
                contentViewControllers[i].view.frame = viewFrame
                self.addChildViewController(contentViewControllers[i])
                scrollView.addSubview(contentViewControllers[i].view)
                contentViewControllers[i].didMove(toParentViewController: self)
            }
        }
    }
}
