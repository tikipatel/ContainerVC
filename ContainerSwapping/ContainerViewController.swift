//
//  ContainerViewController.swift
//  ContainerSwapping
//
//  Created by Pratikbhai Patel on 6/15/16.
//  Copyright © 2016 Pratikbhai Patel. All rights reserved.
//

import UIKit

enum SwapSegueIdentifier: String {
    case PinkVCSegue, GreenVCSegue
}

class ContainerViewController: UIViewController {
    
    var transitionInProgress = false
    var currentSegueIdentifier = SwapSegueIdentifier.PinkVCSegue.rawValue
    
    var pinkVC: PinkViewController?
    var greenVC: GreenViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        performSegueWithIdentifier(SwapSegueIdentifier.PinkVCSegue.rawValue, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SwapSegueIdentifier.PinkVCSegue.rawValue {
            pinkVC = segue.destinationViewController as? PinkViewController
        }
        
        if segue.identifier == SwapSegueIdentifier.GreenVCSegue.rawValue {
            greenVC = segue.destinationViewController as? GreenViewController
        }
        
        if segue.identifier == SwapSegueIdentifier.PinkVCSegue.rawValue {
            if childViewControllers.count > 0 {
                swap(fromVC: childViewControllers[0], toVC: pinkVC!)
            } else {
                addChildViewController(segue.destinationViewController)
                let destinationView = segue.destinationViewController.view
                destinationView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
                destinationView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
                view.addSubview(destinationView)
                segue.destinationViewController.didMoveToParentViewController(self)
            }
        } else if segue.identifier == SwapSegueIdentifier.GreenVCSegue.rawValue {
            swap(fromVC: childViewControllers[0], toVC: greenVC!)
        }
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
    
    
    func swapViewControllers() {
        
        guard transitionInProgress == false else {
            return
        }
        
        transitionInProgress = true
        
        switch currentSegueIdentifier {
        case SwapSegueIdentifier.PinkVCSegue.rawValue:
            currentSegueIdentifier = SwapSegueIdentifier.GreenVCSegue.rawValue
        case SwapSegueIdentifier.GreenVCSegue.rawValue:
            currentSegueIdentifier = SwapSegueIdentifier.PinkVCSegue.rawValue
        default:
            fatalError("It should only ever be Green/Pink")
        }
        
        if currentSegueIdentifier == SwapSegueIdentifier.PinkVCSegue.rawValue && pinkVC != nil {
            swap(fromVC: greenVC!, toVC: pinkVC!)
        }
        
        if currentSegueIdentifier == SwapSegueIdentifier.GreenVCSegue.rawValue && greenVC != nil {
            swap(fromVC: pinkVC!, toVC: greenVC!)
        }
        
        performSegueWithIdentifier(currentSegueIdentifier, sender: nil)
    }
}
