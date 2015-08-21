//
//  CricketPlayers.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/6/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

//Controls the screen for player selection (1-4 Player Cricket)

import UIKit

class CricketPlayers: UIViewController {
    
    //Database variables.
    var databasePath = NSString()
    var defaults = NSUserDefaults.standardUserDefaults()

    //Outlet.
    @IBOutlet weak var oneplayer: UIButton!
    
    //On load (nothing currently).
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Actions for buttons
    @IBAction func storeOnePlayerCricket(sender: AnyObject) {
    }
    
    @IBAction func storeTwoPlayerCricket(sender: AnyObject) {
    }
    
    @IBAction func storeFourPlayerCricket(sender: AnyObject) {
    }
    
    //Outlet for logotag.
    @IBOutlet weak var logotag: UIImageView!

    //Prepare for segue method.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "passto1pcricket") {
            var svc = segue.destinationViewController as! OnePlayerCricket;
            svc.segueNumberId = logotag.tag
        }
        
        if (segue.identifier == "passto2pcricket") {
            var svc = segue.destinationViewController as! TwoPlayerCricket;
            svc.segueNumberId = logotag.tag
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

