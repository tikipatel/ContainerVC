//
//  ViewController.swift
//  ContainerSwapping
//
//  Created by Pratikbhai Patel on 6/15/16.
//  Copyright © 2016 Pratikbhai Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var containerVC: ContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Container" {
            containerVC = segue.destinationViewController as? ContainerViewController
        }
    }

    @IBAction func segmentControlAction(sender: UISegmentedControl) {
        self.containerVC?.switchVC(toIndex: sender.selectedSegmentIndex)
    }
}

