//
//  ContainerViewController.swift
//  ContainerSwapping
//
//  Created by Pratikbhai Patel on 6/15/16.
//  Copyright © 2016 Pratikbhai Patel. All rights reserved.
//

import UIKit

enum SwapSegueIdentifier: String {
    case PinkVCSegue, GreenVCSegue, BlueVCSegue, YellowVCSegue
}

class ContainerViewController: UIViewController {
    
    var transitionInProgress = false
    var currentSegueIdentifier = SwapSegueIdentifier.PinkVCSegue.rawValue
    
    var currentVC: UIViewController?
    var newVC: UIViewController?
    
    var availableVCSegues = [SwapSegueIdentifier.PinkVCSegue.rawValue, SwapSegueIdentifier.GreenVCSegue.rawValue, SwapSegueIdentifier.BlueVCSegue.rawValue, SwapSegueIdentifier.YellowVCSegue.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        performSegueWithIdentifier(SwapSegueIdentifier.PinkVCSegue.rawValue, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        newVC = segue.destinationViewController
        
        if childViewControllers.count > 0 {
            swap(fromVC: childViewControllers[0], toVC: newVC!)
        } else {
            addChildViewController(segue.destinationViewController)
            let destinationView = segue.destinationViewController.view
            destinationView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
            destinationView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            view.addSubview(destinationView)
            segue.destinationViewController.didMoveToParentViewController(self)
        }
        
        currentVC = newVC
        newVC = nil
    }
    
    func swap(fromVC fromVC: UIViewController, toVC: UIViewController) {
        
        toVC.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
        
        fromVC.willMoveToParentViewController(nil)
        addChildViewController(toVC)
        
        transitionFromViewController(fromVC, toViewController: toVC, duration: 0.5, options: .TransitionCrossDissolve, animations: nil) { (finished) in
            fromVC.removeFromParentViewController()
            toVC.didMoveToParentViewController(self)
            self.transitionInProgress = false
        }
    }
    
    
    func switchVC(toIndex index: Int) {
        
        guard transitionInProgress == false else {
            return
        }
        
        transitionInProgress = true
        currentSegueIdentifier = availableVCSegues[index]
        
        performSegueWithIdentifier(currentSegueIdentifier, sender: nil)
    }
}
