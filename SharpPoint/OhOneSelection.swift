//
//  OhOneSelection.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/6/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

//Occurs when user selects a game of Oh One.  Prompts user with Oh One gametype screen.


import UIKit

class OhOneSelection: UIViewController {
    
    //outlet for 301/501/701 buttons.
    @IBOutlet weak var button701: UIButton!
    @IBOutlet weak var button501: UIButton!
    @IBOutlet weak var button301: UIButton!
    
    //Actions for buttons, When button is clicked (currently nothing happens).
    @IBAction func store301(sender: AnyObject) {
    }
    
    @IBAction func store501(sender: AnyObject) {
    }
    
    @IBAction func store701(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Segue method, oasses the title of the 301 button to the next screen.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        //if the segue identifier is pass301, run code block.
        if (segue.identifier == "pass301") {
            var svc = segue.destinationViewController as! PlayersOhOne;
            
            svc.game301 = button301.currentTitle!
        }
        
        //if the segue identifier is pass501, run code block.
        if (segue.identifier == "pass501") {
            var svc = segue.destinationViewController as! PlayersOhOne;

            svc.game501 = button501.currentTitle!
        }
        
        //if the segue identifier is pass701, run code block.
        if (segue.identifier == "pass701") {
            var svc = segue.destinationViewController as! PlayersOhOne;
            
            svc.game701 = button701.currentTitle!
            
        }
    }
}


