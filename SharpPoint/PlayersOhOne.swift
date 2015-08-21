//
//  PlayersOhOne.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/6/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

//Controls the screen for player selection (1-4 Player Oh One)

import UIKit

class PlayersOhOne: UIViewController {
    
    //Declaring variables.
    var game301:String!
    var game501:String!
    var game701:String!
    
    //Action for buttons (currently nothing happens).
    @IBAction func storeOnePlayerOhOne(sender: AnyObject) {
    }

    @IBAction func storeTwoPlayerOhOne(sender: AnyObject) {
    }
    
    @IBAction func storeThreePlayerOhOne(sender: AnyObject) {
    }
    
    @IBAction func storeFourPlayerOhOne(sender: AnyObject) {
    }
    
    //On load, print the variables game301, game501, game701.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(game301)
        println(game501)
        println(game701)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //prepare for segue method.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        //if the segue identifier is passto1pohone, run block of code.
        if (segue.identifier == "passto1pohone") {
            var svc = segue.destinationViewController as! OnePlayerOhOne;
            
            svc.secondpass301p1 = game301
            svc.secondpass501p1 = game501
            svc.secondpass701p1 = game701
            
        }
        //if the segue identifier is passto2pohone, run block of code.
        if (segue.identifier == "passto2pohone") {
            var svc = segue.destinationViewController as! TwoPlayerOhOne;
            
            svc.secondpass301p2 = game301
            svc.secondpass501p2 = game501
            svc.secondpass701p2 = game701
            
        }
        //if the segue identifier is passto3pohone, run block of code.
        if (segue.identifier == "passto3pohone") {
            var svc = segue.destinationViewController as! ThreePlayerOhOne;
            
            svc.secondpass301p3 = game301
            svc.secondpass501p3 = game501
            svc.secondpass701p3 = game701
            
        }
        //if the segue identifier is passto4pohone, run block of code.
        if (segue.identifier == "passto4pohone") {
            var svc = segue.destinationViewController as! FourPlayerOhOne;
            
            svc.secondpass301p4 = game301
            svc.secondpass501p4 = game501
            svc.secondpass701p4 = game701
            
        }
    }
}

