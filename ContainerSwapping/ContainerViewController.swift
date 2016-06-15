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
        performSegue(withIdentifier: SwapSegueIdentifier.PinkVCSegue.rawValue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    
        newVC = segue.destinationViewController
        
        if childViewControllers.count > 0 {
            swap(fromVC: childViewControllers[0], toVC: newVC!)
        } else {
            addChildViewController(segue.destinationViewController)
            let destinationView = segue.destinationViewController.view
            destinationView?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            destinationView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(destinationView!)
            segue.destinationViewController.didMove(toParentViewController: self)
        }
        
        currentVC = newVC
        newVC = nil
    }
    
    func swap(fromVC: UIViewController, toVC: UIViewController) {
        
        toVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        fromVC.willMove(toParentViewController: nil)
        addChildViewController(toVC)
        
        transition(from: fromVC, to: toVC, duration: 0.5, options: .transitionCrossDissolve, animations: nil) { (finished) in
            fromVC.removeFromParentViewController()
            toVC.didMove(toParentViewController: self)
            self.transitionInProgress = false
        }
    }
    
    
    func switchVC(toIndex index: Int) {
        
        guard transitionInProgress == false else {
            return
        }
        
        transitionInProgress = true
        currentSegueIdentifier = availableVCSegues[index]
        
        performSegue(withIdentifier: currentSegueIdentifier, sender: nil)
    }
}
